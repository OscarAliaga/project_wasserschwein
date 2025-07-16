from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from pathlib import Path
from dotenv import load_dotenv
from contextlib import asynccontextmanager
import openai, os, random, re

from langchain_community.document_loaders import DirectoryLoader, TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.embeddings import OpenAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_openai import ChatOpenAI
from langchain.chains import RetrievalQA
from langchain.chains.question_answering import load_qa_chain
from langchain_core.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate

# ============= CONFIG GLOBAL ==============

BASE_DIR = Path(__file__).resolve().parent

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

qa_chains = {"es": {}, "en": {}}
user_sessions = {}

# ========== APP CON LIFESPAN =========
@asynccontextmanager
async def lifespan(app: FastAPI):
    load_rag_pipeline()
    yield

app = FastAPI(lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.mount(
    "/images",
    StaticFiles(directory=BASE_DIR / "assets" / "images"),
    name="images"
)

# ============= MODELO ============
class Question(BaseModel):
    question: str
    user_id: str
    stage: int = 1
    lang: str = "es"

qa_chains = {"es": {}, "en": {}}
user_sessions = {}

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

openai.api_key = os.getenv("OPENAI_API_KEY")

# ======== TEMAS =========
temas_by_lang = {
    "es": {
        "fracciones": {
            "tips": [
                "🍕 Imagina que compartes una pizza: cada trozo representa una fracción del total.",
                "📚 Las fracciones impropias se pueden convertir en números mixtos para entenderlas mejor."
            ],
            "image": "pizza_full.png"
        },
        "decimales": {
            "tips": [
                "💰 Los decimales muestran partes pequeñas de una unidad, como los centavos en una moneda.",
                "📐 Usa una regla para ver cómo los decimales representan longitudes en la vida real."
            ],
            "image": "vaso_medio_lleno.png"
        },
        "multiplicación": {
            "tips": [
                "🧮 Descomponer los números grandes en factores más pequeños puede ayudarte a multiplicar más fácil.",
                "🔄 El orden de los factores no altera el producto: 3 × 4 es lo mismo que 4 × 3."
            ],
            "image": "https://raw.githubusercontent.com/tuusuario/assets/main/multiplicacion_basica.png"
        },
        "divisiones": {
            "tips": [
                "📘 Estima primero tu respuesta antes de dividir para comprobar si tiene sentido.",
                "🧠 Revisa el cociente y el residuo para verificar que la división esté bien hecha."
            ],
            "image": "doce_galletas.png"
        },
        "ecuaciones": {
            "tips": [
                "🎯 Usa operaciones inversas (como restar en vez de sumar) para despejar la incógnita.",
                "🔢 Verifica tu resultado reemplazando el valor en la ecuación original."
            ],
            "image": "https://raw.githubusercontent.com/tuusuario/assets/main/ecuacion_basica.png"
        },
        "probabilidades": {
            "tips": [
                "🎲 La probabilidad se mide entre 0 (imposible) y 1 (seguro), como al lanzar una moneda.",
                "📊 Usa fracciones o porcentajes para expresar la probabilidad de que ocurra un evento."
            ],
            "image": "bolsa_bolas.png"
        }
    },
    "en": {
        "fractions": {
            "tips": [
                "🍕 Imagine you're sharing a pizza: each slice represents a fraction of the whole.",
                "📚 Improper fractions can be turned into mixed numbers to make them easier to understand."
            ],
            "image": "pizza_full.png"
        },
        "decimals": {
            "tips": [
                "💰 Decimals show parts of a whole, like cents in a dollar.",
                "📐 Use a ruler to see how decimals appear in real-life measurements."
            ],
            "image": "vaso_medio_lleno.png"
        },
        "multiplication": {
            "tips": [
                "🧮 Breaking numbers into smaller parts can help you multiply more easily.",
                "🔄 The order of numbers doesn’t change the result: 3 × 4 is the same as 4 × 3."
            ],
            "image": "https://raw.githubusercontent.com/tuusuario/assets/main/multiplicacion_basica.png"
        },
        "division": {
            "tips": [
                "📘 Estimate your answer first to check if it makes sense before dividing.",
                "🧠 Check both the quotient and remainder to make sure your division is correct."
            ],
            "image": "doce_galletas.png"
        },
        "equations": {
            "tips": [
                "🎯 Use inverse operations to isolate the variable and solve the equation.",
                "🔢 Replace the solution back into the equation to verify if it works."
            ],
            "image": "https://raw.githubusercontent.com/tuusuario/assets/main/ecuacion_basica.png"
        },
        "probability": {
            "tips": [
                "🎲 Probability ranges from 0 (impossible) to 1 (certain), like rolling a dice.",
                "📊 Use fractions or percentages to express how likely something is to happen."
            ],
            "image": "bolsa_bolas.png"
        }
    }
}

# ========= RAG PIPELINE ==========
@asynccontextmanager
def load_rag_pipeline():
    global qa_chains

    data_dir = BASE_DIR / "data_chunks"
    index_dir = BASE_DIR / "index"

    base_prompts = {
        "es": """Eres Capibara, un tutor **extremadamente** paciente, **amigable y divertido** que ayuda a niños de primaria a entender ideas complejas con **ejemplos súper simples, muchísimos emojis relevantes**, frases motivadoras y **mucho cariño**. Siempre mantén un tono entusiasta y de apoyo. No seas formal. Aquí tienes información relevante para tu respuesta, pero tu personalidad es lo más importante:\n\n{context}""",
        "en": """You are Capibara, an **extremely** patient, **friendly and fun** tutor who helps elementary students understand complex ideas using **super simple examples, tons of fun emojis**, motivational phrases, and **lots of affection**. Always keep an enthusiastic and supportive tone. Don't be formal. Here is some helpful information for your answer, but your personality is the most important part:\n\n{context}"""
    }

    base_dirs = {
        "es": data_dir / "es",
        "en": data_dir / "en"
    }

    index_dirs = {
        "es": index_dir / "es",
        "en": index_dir / "en"
    }

    system_prompts = {
        lang: {
            1: base_prompts[lang] + (
                "\n\n### ✨ Introducción al concepto\n"
                "Explica el concepto con claridad y cariño. Usa títulos y bullets si es útil.\n\n"
                "Termina con una pregunta amable para invitar a ver un ejemplo.\n"
                "**NO olvides usar muchos emojis y evitar ser demasiado formal.**"
                if lang == "es" else
                "\n\n### ✨ Introduction to the concept\n"
                "Explain the concept clearly and warmly. Use headings and bullets where helpful.\n\n"
                "End with a friendly question inviting the student to see an example.\n"
                "**USE lots of emojis and stay cheerful.**"
            ),
            2: base_prompts[lang] + (
                "\n\n### 🧩 Ejemplo para reforzar\n"
                "Entrega un ejemplo concreto del concepto explicado antes. No repitas la explicación.\n"
                "• Usa formato de bullet si es útil.\n"
                "• Mantén un tono animado y claro.\n\n"
                "Termina con una pregunta amable para invitar a resolver un ejercicio.\n"
                if lang == "es" else
                "\n\n### 🧩 Reinforcing Example\n"
                "Give a specific example of the previously explained concept. Do NOT repeat the explanation.\n"
                "• Use bullet points if helpful.\n"
                "• Keep it fun and focused.\n\n"
                "End with a friendly question inviting the student to do some exercises.\n"
            ),
            3: base_prompts[lang] + (
                "\n\n### 🚀 Hora de practicar\n"
                "Entrega un ejercicio simple para que el estudiante lo intente. Sé claro, evita explicar el concepto otra vez.\n"
                "• Muestra el ejercicio en un bloque claro.\n\n"
                "Termina con una frase de felicitación y ánimo. 🎉"
                if lang == "es" else
                "\n\n### 🚀 Practice Time\n"
                "Give a simple exercise for the student to try. Be clear, and avoid re-explaining the concept.\n"
                "• Show the task in a clear block.\n\n"
                "Finish with praise and encouragement. 🎉"
            )
        } for lang in ["es", "en"]
    }

    for lang in ["es", "en"]:
        print(f"Loading pipeline for language: {lang}")
        loader = DirectoryLoader(base_dirs[lang], glob="**/*.txt", loader_cls=TextLoader)
        documents = loader.load()
        splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
        texts = splitter.split_documents(documents)
        embeddings = OpenAIEmbeddings()

        if os.path.exists(index_dirs[lang]):
            db = FAISS.load_local(index_dirs[lang], embeddings, allow_dangerous_deserialization=True)
        else:
            db = FAISS.from_documents(texts, embeddings)
            db.save_local(index_dirs[lang])

        retriever = db.as_retriever()

        llms = {stage: ChatOpenAI(temperature=0.7, model="gpt-3.5-turbo") for stage in [1, 2, 3]}

        qa_chains[lang] = {
            stage: RetrievalQA(
                retriever=retriever,
                combine_documents_chain=load_qa_chain(
                    llm=llms[stage],
                    chain_type="stuff",
                    prompt=ChatPromptTemplate.from_messages([
                        SystemMessagePromptTemplate.from_template(system_prompts[lang][stage]),
                        HumanMessagePromptTemplate.from_template("{question}")
                    ])
                )
            )
            for stage in [1, 2, 3]
        }
@app.post("/ask")
def ask_ai(request: Request, question: Question):
    lang = question.lang if question.lang in ["es", "en"] else "es"
    uid = question.user_id
    text = question.question.strip().lower()
    current_stage = question.stage

    print(f"DEBUG: UID={uid}, LANG={lang}, TEXT='{text}', STAGE={current_stage}")

    # Recuperar o crear sesión
    session = user_sessions.get(uid, {"stage": 1, "topic": ""})
    topic = session["topic"]
    next_stage = 1
    chain_to_use = 1

    # Lógica de etapas
    if current_stage == 1:
        topic = text
        next_stage = 2
        chain_to_use = 1
    elif current_stage == 2 and text in ["sí", "si", "yes"]:
        next_stage = 3
        chain_to_use = 2
    elif current_stage == 3 and text in ["sí", "si", "yes"]:
        next_stage = 1
        chain_to_use = 3
    else:
        topic = text
        next_stage = 2
        chain_to_use = 1

    user_sessions[uid] = {"stage": next_stage, "topic": topic}
    print(f"DEBUG: Session[{uid}] = {user_sessions[uid]}")

    # Seleccionar cadena según idioma y etapa
    qa_set = qa_chains.get(lang, qa_chains["es"])
    chain = qa_set.get(chain_to_use, qa_set[1])
    print(f"DEBUG: Using chain stage {chain_to_use} in language '{lang}' for topic: '{topic}'")

    # Obtener respuesta
    respuesta_raw = chain.invoke({"query": topic})
    full_answer = (
        respuesta_raw["result"]
        if isinstance(respuesta_raw, dict) and "result" in respuesta_raw
        else str(respuesta_raw)
    )

    # Separar respuesta principal y pregunta de seguimiento
    main_answer = full_answer
    followup = ""
    if current_stage in [1, 2]:
        question_matches = re.findall(r"[^.?!]*\?", full_answer)
        if question_matches:
            followup = question_matches[-1].strip()
            main_answer = full_answer.replace(followup, "").strip()
        else:
            followup = (
                "¿Te gustaría ver un ejemplo? 😊" if current_stage == 1 else
                "¿Quieres intentar un ejercicio ahora? 💪"
            ) if lang == "es" else (
                "Would you like to see an example? 😊" if current_stage == 1 else
                "Do you want to try a practice now? 💪"
            )

    # Mostrar botones solo si hay followup
    show_buttons = bool(followup and current_stage in [1, 2])

    # Tip e imagen
    temas = temas_by_lang.get(lang, {})
    topic_words = re.findall(r'\b\w+\b', topic.lower())
    tema_detectado = next((t for t in temas if any(word in t for word in topic_words)), None)
    print(f"DEBUG: Tema detectado: {tema_detectado}")

    if tema_detectado:
        tip = random.choice(temas[tema_detectado]["tips"])
    else:
        fallback_tips = {
            "es": [
                "🧠 Lee bien el problema antes de resolverlo.",
                "✏️ Usa dibujos o esquemas para entender mejor la situación.",
                "💡 Intenta explicarlo con tus propias palabras a alguien más."
            ],
            "en": [
                "🧠 Read the problem carefully before solving it.",
                "✏️ Try drawing or sketching to understand better.",
                "💡 Explain it in your own words to someone else."
            ]
        }
        tip = random.choice(fallback_tips.get(lang, fallback_tips["es"]))

    image = None
    if current_stage in [2, 3] and tema_detectado:
        img_path = temas[tema_detectado]["image"]
        if img_path.startswith("http"):
            image = img_path
        else:
            host = request.headers.get("host", "localhost:8000")
            scheme = "http"
            image = f"{scheme}://{host}/images/{img_path}"
            print(f"DEBUG: Dynamic image URL generated: {image}")

    return JSONResponse(
        content={
            "answer": main_answer,
            "followup": followup,
            "tip": tip,
            "image": image,
            "next_stage": next_stage,
            "show_buttons": show_buttons
        },
        media_type="application/json; charset=utf-8"
    )

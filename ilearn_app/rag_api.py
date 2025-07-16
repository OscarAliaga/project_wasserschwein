from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
import os
import random

# Langchain imports
from langchain_community.document_loaders import DirectoryLoader, TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.embeddings import OpenAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_openai import ChatOpenAI
from langchain.chains import RetrievalQA, load_qa_chain
from langchain_core.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate

class Question(BaseModel):
    question: str
    user_id: str
    stage: int = 1 # Default to 1 if not provided

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount static files for images
# IMPORTANT: Adjust this path to where your 'imagenes_ejercicios' folder is
app.mount("/static/imagenes_ejercicios", StaticFiles(directory="/Users/oaliaga/Documents/Difference Maker 2025/Material nuevo/proyecto_rag_gpt35/imagenes_ejercicios"), name="imagenes_ejercicios")

# API Key
os.environ["OPENAI_API_KEY"] = "***REMOVED***proj-4LB1as8OZShBumvvg9bDGpkDhn1U7jbhZmBKbq2z-n7vyA-6jJVWjg0CFwMJADoz-SRn2DGLE9T3BlbkFJMmsLGiT7Q1TwY3yeJXWmym88_ieayGUo_Om0XDm14ammT-jjGrEcCFwhdVLjIdt6oaiLg0Uh4A"

# Global variables
qa_chains = {}
user_sessions = {} # Stores {'user_id': {'stage': int, 'topic': str}}

# Global definition for 'temas' dictionary
temas = {
    "fracción": {
        "tips": [
            "🍕 Imagina que compartes una pizza: ¡cada trozo es una fracción!",
            "📚 Las fracciones impropias se pueden convertir en números mixtos."
        ],
        "image": "pizza_1_cuarto.jpeg"
    },
    "decimal": {
        "tips": [
            "💰 Los decimales muestran partes pequeñas de una unidad.",
            "📐 Usa una regla para ver los decimales en longitudes reales."
        ],
        "image": "vaso_medio_lleno.jpeg"
    },
    "multiplicación": {
        "tips": [
            "🧮 Descomponer los números puede ayudarte a multiplicar más fácil.",
            "🔄 El orden de los factores no altera el producto."
        ],
        "image": "https://raw.githubusercontent.com/tuusuario/assets/main/multiplicacion_basica.png"
    },
    "división": {
        "tips": [
            "📘 Estima primero tu resultado para comprobar si tiene sentido.",
            "🧠 Revisa el cociente y el residuo para verificar la división."
        ],
        "image": "doce_galletas.jpeg"
    },
    "ecuación": {
        "tips": [
            "🎯 Usa operaciones inversas para despejar la incógnita.",
            "🔢 Verifica tu resultado reemplazando en la ecuación."
        ],
        "image": "https://raw.githubusercontent.com/tuusuario/assets/main/ecuacion_basica.png"
    },
    "probabilidad": {
        "tips": [
            "🎲 La probabilidad se mide del 0 al 1.",
            "📊 Usa fracciones o porcentajes para expresarla."
        ],
        "image": "bolsa_bolas.jpeg"
    }
}

@app.on_event("startup")
def load_rag_pipeline():
    global qa_chains

    loader = DirectoryLoader(
        "/Users/oaliaga/Documents/Difference Maker 2025/Material nuevo/proyecto_rag_gpt35/data_chunks",
        glob="**/*.txt",
        loader_cls=TextLoader
    )
    documents = loader.load()

    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
    texts = splitter.split_documents(documents)

    embeddings = OpenAIEmbeddings()
    db = FAISS.from_documents(texts, embeddings)
    retriever = db.as_retriever()

    # --- UPDATED BASE PROMPT AND SYSTEM PROMPTS FOR PERSONALITY AND QUESTION ADHERENCE ---
    base_prompt = (
        "Eres Capibara, un tutor **extremadamente** paciente, **amigable y divertido** que ayuda a niños de primaria "
        "a entender ideas complejas con **ejemplos súper simples, muchísimos emojis relevantes**, frases motivadoras "
        "y **mucho cariño**. Siempre mantén un tono entusiasta y de apoyo. No seas formal. "
        "Aquí tienes información relevante para tu respuesta, pero tu personalidad es lo más importante:\n\n{context}"
    )

    system_prompts = {
        1: base_prompt + (
            "\n\nTu tarea principal es explicar el concepto de forma simple y didáctica. "
            "**INCLUYE SIEMPRE MUCHOS EMOTICONES DIVERTIDOS Y RELEVANTES.** "
            "Al final de tu explicación, **DEBES HACER UNA PREGUNTA CLARA AL ESTUDIANTE**, por ejemplo: "
            "'¿Te gustaría ver un ejemplo didáctico? ✨' o '¿Quieres que te muestre un ejemplo para entenderlo mejor? 🤔'"
        ),
        2: base_prompt + (
            "\n\nTu tarea principal es entregar un ejemplo didáctico del tema. "
            "**INCLUYE SIEMPRE MUCHOS EMOTICONES DIVERTIDOS Y RELEVANTES.** "
            "Al final de tu ejemplo, **DEBES HACER UNA PREGUNTA CLARA AL ESTUDIANTE**, por ejemplo: "
            "'¿Quieres que desarrollemos un ejercicio juntos para practicar? 🚀' o '¿Te animas a resolver un problema conmigo? 💪'"
        ),
        3: base_prompt + (
            "\n\nTu tarea principal es entregar un ejercicio simple para que el estudiante haga contigo. "
            "**INCLUYE SIEMPRE MUCHOS EMOTICONES DIVERTIDOS Y RELEVANTES.** "
            "Termina tu respuesta **SIEMPRE** con una frase motivadora y de felicitación. "
            "Por ejemplo: '¡Excelente trabajo! Estoy muy orgulloso de ti. Sigue así. 🎉😊'"
        )
    }

    llms = {stage: ChatOpenAI(temperature=0.7, model="gpt-3.5-turbo") for stage in system_prompts} # Increased temperature, specified model

    qa_chains = {
        stage: RetrievalQA(
            retriever=retriever,
            combine_documents_chain=load_qa_chain(
                llm=llms[stage],
                chain_type="stuff",
                prompt=ChatPromptTemplate.from_messages([
                    SystemMessagePromptTemplate.from_template(system_prompts[stage]),
                    HumanMessagePromptTemplate.from_template("{question}")
                ])
            )
        ) for stage in system_prompts
    }

@app.post("/ask")
def ask_ai(question: Question):
    global qa_chains, user_sessions

    uid = question.user_id
    text = question.question.strip().lower()
    current_request_stage = question.stage

    print(f"DEBUG: Start of ask_ai for UID: {uid}, Text: '{text}', Incoming Stage: {current_request_stage}")

    # --- Session Management Logic ---
    # Determine the 'actual' current stage in the session, and the 'next' stage to transition to.
    session_data = user_sessions.get(uid, {"stage": 1, "topic": ""}) # Get existing or new session data
    current_session_stage = session_data["stage"] # What the backend *thinks* the user's stage is
    session_topic = session_data["topic"] # What the backend *thinks* the user's topic is

    chain_to_use = 1 # Default chain
    next_session_stage = 1 # Default next stage (resets to beginning)

    print(f"DEBUG: Session retrieved/initial: {session_data}. current_session_stage: {current_session_stage}")
    print(f"DEBUG: Incoming question.stage (from Flutter): {current_request_stage}")

    # Logic to determine which chain to use and what the *next* stage should be
    # Prioritize Flutter's incoming stage if it's 1 (new conversation start)
    if current_request_stage == 1:
        # This is a new conversation/topic, or a explicit reset from Flutter.
        chain_to_use = 1
        session_topic = text # The incoming text is the new topic
        next_session_stage = 2 # After explanation, ask for example
        print(f"DEBUG: Incoming Stage 1 detected. Setting topic: '{session_topic}', next_session_stage: {next_session_stage}")
    elif current_request_stage == 2 and text in ["sí", "si", "yes"]:
        # User confirmed 'yes' for an example
        chain_to_use = 2
        next_session_stage = 3 # After example, ask for exercise
        print(f"DEBUG: Incoming Stage 2 ('sí') detected. Topic: '{session_topic}', next_session_stage: {next_session_stage}")
    elif current_request_stage == 3 and text in ["sí", "si", "yes"]:
        # User confirmed 'yes' for an exercise
        chain_to_use = 3
        next_session_stage = 1 # After exercise, loop back to initial stage for a new topic
        print(f"DEBUG: Incoming Stage 3 ('sí') detected. Topic: '{session_topic}', next_session_stage: {next_session_stage}")
    else:
        # This handles:
        # - current_request_stage is 2 or 3, but text is NOT "sí" (e.g., user said "no" or typed something else)
        # - An invalid `current_request_stage` was sent by client (shouldn't happen with proper Flutter logic)
        # In all these cases, we reset the flow to stage 1 (explanation)
        print(f"DEBUG: Entered ELSE block (Unexpected input or 'No'). Resetting flow.")
        chain_to_use = 1 # Default to explanation chain
        session_topic = text # Treat current input as a new topic
        next_session_stage = 2 # After explanation, next stage is to ask for example
        print(f"DEBUG: ELSE block: Topic set: '{session_topic}'. Next Session Stage will be: {next_session_stage}")

    # Update the user's session data
    user_sessions[uid] = {
        "stage": next_session_stage,
        "topic": session_topic
    }
    print(f"DEBUG: Session updated for UID {uid}: {user_sessions[uid]}")

    # Safety check for chain_to_use
    if chain_to_use not in qa_chains:
        print(f"DEBUG: Error: chain_to_use {chain_to_use} not found in qa_chains. Defaulting to 1.")
        chain_to_use = 1

    print(f"DEBUG: Running LLM with chain: {chain_to_use}. Using topic: '{session_topic}'")

    # The actual LLM call
    respuesta = qa_chains[chain_to_use].run(session_topic)

    # Tema detection for tips/images (using the active session_topic for consistency)
    if session_topic: # Use the established topic for context relevant tips/images
        tema_detectado = next((t for t in temas if t in session_topic.lower()), None)
    else: # Fallback if no topic is established (shouldn't happen often)
        tema_detectado = next((t for t in temas if t in text), None)

    print(f"DEBUG: Tema detected for tips/image: {tema_detectado}")

    tip = random.choice(temas.get(tema_detectado, {}).get("tips", [
        "🧠 Lee bien el problema antes de resolverlo.",
        "✏️ Usa dibujos o esquemas para entender mejor la situación."
    ]))

    image = None
    if tema_detectado:
        img_path = temas[tema_detectado]["image"]
        image = img_path if img_path.startswith("http") else f"http://10.0.2.2:8000/static/imagenes_ejercicios/{img_path}"
        print(f"DEBUG: Image URL: {image}")
    else:
        print("DEBUG: No tema detected, no image.")


    print(f"DEBUG: Final next_stage sent to Flutter in JSONResponse: {user_sessions[uid]['stage']}")
    return JSONResponse(
        content={
            "answer": respuesta,
            "tip": tip,
            "image": image,
            "next_stage": user_sessions[uid]['stage'] # Send the actual updated session stage
        },
        media_type="application/json; charset=utf-8"
    )
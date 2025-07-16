import os

from langchain.document_loaders import TextLoader
from langchain.embeddings import OpenAIEmbeddings
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.vectorstores import FAISS
from tqdm import tqdm

# 📂 Ruta a la carpeta con los .txt en español
input_dir = "/Users/oaliaga/Documents/Difference_Maker_2025/Material_nuevo/proyecto_rag_gpt35/data_chunks_en"

# 📂 Ruta donde se guardará el índice
output_path = "/Users/oaliaga/Documents/Difference_Maker_2025/Material_nuevo/proyecto_rag_gpt35/index_en"

# 🧠 Inicializar embeddings de OpenAI
embeddings = OpenAIEmbeddings()

# ✂️ Configurar cómo dividir los textos
text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)

# 📦 Cargar, dividir y procesar los documentos
all_docs = []

print(f"\n📚 Procesando documentos en: {input_dir}")

for file in tqdm(os.listdir(input_dir)):
    if not file.endswith(".txt"):
        continue

    path = os.path.join(input_dir, file)
    loader = TextLoader(path, encoding="utf-8")
    docs = loader.load()

    # Extraer metadatos desde el nombre del archivo
    parts = file.replace(".txt", "").split("_")
    metadata = {
        "file": file,
        "unit": parts[0] if len(parts) > 0 else "",
        "class": parts[1] if len(parts) > 1 else "",
        "chunk": parts[2] if len(parts) > 2 else "",
        "topic": "_".join(parts[3:]) if len(parts) > 3 else "",
        "lang": "en",
    }

    for doc in docs:
        doc.metadata = metadata

    split_docs = text_splitter.split_documents(docs)
    all_docs.extend(split_docs)

# 💾 Construir y guardar el índice
print(f"\n🧠 Construyendo índice FAISS para idioma español...")
db = FAISS.from_documents(all_docs, embeddings)
db.save_local(output_path)
print(f"✅ Índice guardado en: {output_path}")

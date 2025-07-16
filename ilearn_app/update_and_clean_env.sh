#!/bin/bash

echo "✅ Activando entorno virtual (asegúrate de haberlo creado)..."
# Descomenta la línea que corresponde a tu sistema operativo
# source venv/bin/activate          # Mac/Linux
# venv\Scripts\activate          # Windows (usa Git Bash o PowerShell)

echo "🔍 Verificando paquetes desactualizados..."
pip list --outdated

echo "🔄 Instalando herramientas de mantenimiento..."
pip install --upgrade pip pip-review pipdeptree black isort mypy ruff

echo "🔁 Actualizando todos los paquetes con pip-review..."
pip-review --auto

echo "🧼 Verificando árbol de dependencias..."
pipdeptree --warn silence

echo "🧠 Verificando tipado estático con mypy..."
mypy .

echo "🎨 Ordenando imports con isort..."
isort .

echo "🖤 Formateando el código con black..."
black .

echo "🕵️ Revisando estilo y errores con ruff..."
ruff .

echo "✅ Mantenimiento completo. Tu entorno está actualizado y limpio."

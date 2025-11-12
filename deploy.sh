#!/bin/bash

# ==========================================================
# 🚀 SCRIPT DE DEPLOY AUTOMÁTICO PARA JUAN GUBIO
# Proyecto: juan-gubio
# Usuario Docker Hub: juanpi38818
# Versión: 1.0.1
# ==========================================================

# 1️⃣ Variables
USER="juanpi38818"
IMAGE_NAME="juan-gubio"
TAG="1.0.1"

# 2️⃣ Construir imagen local
echo "🛠️  Construyendo imagen Docker..."
docker build -t $IMAGE_NAME:$TAG .

# 3️⃣ Etiquetar imagen con tu usuario real
echo "🏷️  Etiquetando imagen como $USER/$IMAGE_NAME:$TAG"
docker tag $IMAGE_NAME:$TAG $USER/$IMAGE_NAME:$TAG

# 4️⃣ Iniciar sesión en Docker Hub
echo "🔑 Iniciando sesión en Docker Hub..."
docker login -u $USER

# 5️⃣ Subir la imagen al repositorio remoto
echo "⬆️  Subiendo imagen a Docker Hub..."
docker push $USER/$IMAGE_NAME:$TAG

# 6️⃣ Subir cambios a GitHub
echo "📤 Subiendo cambios a GitHub..."
git add .
git commit -m "Deploy version $TAG"
git push origin juan-gubio

# 7️⃣ Mostrar mensaje final con enlace directo
echo "✅ Imagen subida correctamente."
echo "🌍 Verifica aquí: https://hub.docker.com/r/$USER/$IMAGE_NAME"
echo "📦 Nombre de la imagen para Render: $USER/$IMAGE_NAME:$TAG"
echo ""
echo "💡 Ahora ve a Render y usa esa URL en 'Deploy from Docker Image'."
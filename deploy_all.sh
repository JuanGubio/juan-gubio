#!/bin/bash
# 🚀 Script de despliegue automático: Docker Hub + GitHub Packages + Render
# Autor: JuanGubio
# Versión: 1.0.1

# --- CONFIGURACIÓN ---
IMAGE_NAME="juan-gubio"
IMAGE_VERSION="1.0.1"
DOCKERHUB_USER="juangubio"
GITHUB_USER="juangubio"
REPO_NAME="juan-gubio"
GHCR_IMAGE="ghcr.io/$GITHUB_USER/$IMAGE_NAME:$IMAGE_VERSION"
DOCKERHUB_IMAGE="$DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_VERSION"

echo "=============================="
echo "  🚀 Iniciando despliegue..."
echo "=============================="

# --- 1️⃣ Build de la imagen ---
echo "📦 Construyendo imagen Docker..."
docker build -t $IMAGE_NAME:$IMAGE_VERSION .

# --- 2️⃣ Etiquetar para Docker Hub ---
echo "🏷️ Etiquetando imagen para Docker Hub..."
docker tag $IMAGE_NAME:$IMAGE_VERSION $DOCKERHUB_IMAGE

# --- 3️⃣ Subir a Docker Hub ---
echo "📤 Subiendo a Docker Hub ($DOCKERHUB_IMAGE)..."
docker login -u $DOCKERHUB_USER
docker push $DOCKERHUB_IMAGE

# --- 4️⃣ Etiquetar para GitHub Packages ---
echo "🏷️ Etiquetando imagen para GitHub Packages..."
docker tag $IMAGE_NAME:$IMAGE_VERSION $GHCR_IMAGE

# --- 5️⃣ Subir a GitHub Container Registry ---
echo "🔐 Iniciando sesión en GitHub Packages..."
echo "👉 Ingresa tu token de GitHub (con permisos write:packages):"
read -s GITHUB_TOKEN
echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USER --password-stdin

echo "📤 Subiendo a GitHub Container Registry ($GHCR_IMAGE)..."
docker push $GHCR_IMAGE

# --- 6️⃣ Confirmación ---
echo "✅ Imagen publicada correctamente en:"
echo "   - Docker Hub → https://hub.docker.com/r/$DOCKERHUB_USER/$IMAGE_NAME"
echo "   - GitHub Packages → https://github.com/$GITHUB_USER/$REPO_NAME/pkgs/container/$IMAGE_NAME"
echo "=============================="
echo "🚀 Despliegue completado con éxito"
echo "=============================="
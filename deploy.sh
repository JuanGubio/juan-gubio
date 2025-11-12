#!/bin/bash

USER="juanpi38818"
IMAGE_NAME="juan-gubio"
TAG="1.0.1"

echo "Construyendo imagen Docker..."
docker build -t $IMAGE_NAME:$TAG .

echo "Etiquetando imagen como $USER/$IMAGE_NAME:$TAG"
docker tag $IMAGE_NAME:$TAG $USER/$IMAGE_NAME:$TAG

echo "Iniciando sesión en Docker Hub..."
docker login -u $USER

echo "Subiendo imagen a Docker Hub..."
docker push $USER/$IMAGE_NAME:$TAG

echo "Subiendo cambios a GitHub..."
git add .
git commit -m "Deploy version $TAG"
git push origin juan-gubio

echo "Imagen subida correctamente."
echo "Verifica aquí: https://hub.docker.com/r/$USER/$IMAGE_NAME"
echo "Nombre de la imagen para Render: $USER/$IMAGE_NAME:$TAG"
echo ""
echo "Ahora ve a Render y usa esa URL en 'Deploy from Docker Image'."
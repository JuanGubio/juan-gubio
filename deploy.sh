#!/bin/bash

# Script de despliegue para Juan Gubio
# Construye, etiqueta y sube la imagen Docker, luego despliega en Render

echo "Construyendo imagen Docker..."
docker build -t juangubio:1.0.1 .

echo "Etiquetando imagen para Docker Hub..."
docker tag juangubio:1.0.1 juangubio/juan-gubio:1.0.1

echo "Subiendo imagen a Docker Hub..."
docker push juangubio/juan-gubio:1.0.1

echo "Imagen subida exitosamente a Docker Hub: juangubio/juan-gubio:1.0.1"

# Para despliegue en Render, se hace manualmente en la web
echo "Para desplegar en Render:"
echo "1. Ve a https://render.com"
echo "2. Crea un nuevo Web Service"
echo "3. Elige 'Deploy an existing image'"
echo "4. Ingresa: juangubio/juan-gubio:1.0.1"
echo "5. Asigna puerto 8080 y despliega"

# Para Google Cloud Run (requiere gcloud CLI instalado)
# echo "Desplegando en Google Cloud Run..."
# gcloud run deploy juan-gubio-service \
#   --image docker.io/juangubio/juan-gubio:1.0.1 \
#   --platform managed \
#   --region us-central1 \
#   --allow-unauthenticated

echo "Despliegue completado."
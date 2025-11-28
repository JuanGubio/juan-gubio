# Imagen base
FROM python:3.9-slim

# Crea el directorio de la app
WORKDIR /app

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copia archivos de dependencias primero (para aprovechar caché de Docker)
COPY requirements.txt .

# Instala dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código fuente
COPY . .

# Expone el puerto (usa el mismo que en tu app)
EXPOSE 3000

# Comando de inicio
CMD ["python", "app/main.py"]

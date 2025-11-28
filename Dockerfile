# Imagen base
FROM python:3.9-slim

# Crea el directorio de la app
WORKDIR /app

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copia archivos de dependencias primero para cache
COPY requirements.txt .

# Instala dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia tu proyecto completo
COPY . .

# Tu aplicación corre en 8080 (gunicorn)
EXPOSE 8080

# Ejecutar main.py directamente
CMD ["python", "main.py"]

# Imagen base
FROM python:3.11-slim

# Directorio de trabajo
WORKDIR /app

# Copiar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código
COPY . .

# Configuración
ENV PORT=8080
EXPOSE 8080

# Comando de inicio
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080", "--workers", "1"]
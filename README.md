# Proyecto Docker de Juan Gubio 🚀

## Descripción
Aplicación en Flask con funcionalidad de IA desplegada como contenedor Docker. Incluye pruebas automatizadas y CI/CD completo.

## Cómo ejecutar localmente
```bash
docker build -t juan-gubio:1.0.5 .
docker run -p 8080:8080 juan-gubio:1.0.5
```

## Imagen pública
- GitHub Packages: ghcr.io/JuanGubio/juan-gubio:1.0.5
- Docker Hub: juanpi38818/juan-gubio:1.0.5

## Despliegue
Desplegado automáticamente en gubio.byronrm.com usando Docker Swarm y Traefik.
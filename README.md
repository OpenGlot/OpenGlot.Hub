# OpenGlot.Hub

Composes OpenGlot.Web and OpenGlot.API in Docker

To Run Locally, Install Docker Compose then the following commands.

git clone https://github.com/TotzkePaul/OpenGlot.Hub.git

cd OpenGlot.Hub

git submodule update --init --recursive

docker-compose up --build
docker-compose down -v

To enable hot reloading for frontend:
docker-compose -f docker-compose.dev.yml up --build

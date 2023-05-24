#!/bin/bash

# Verificar si el sistema es Linux
if [[ "$(uname)" != "Linux" ]]; then
    echo "Este script solo es compatible con sistemas Linux."
    exit 1
fi

# Verificar si el sistema es Ubuntu
if [[ "$(lsb_release -si)" != "Ubuntu" ]]; then
    echo "Este script solo es compatible con sistemas Ubuntu."
    exit 1
fi

# Verificar si Docker está instalado
if ! command -v docker &>/dev/null; then
    echo "Docker no está instalado. Instalando Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER"
    echo "Docker se ha instalado correctamente."
else
    echo "Docker ya está instalado."
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &>/dev/null; then
    echo "Docker Compose no está instalado. Instalando Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
    sudo chmod +x /usr/bin/docker-compose
    echo "Docker Compose se ha instalado correctamente."
else
    echo "Docker Compose ya está instalado."
fi

# Verificar las versiones instaladas
echo "Versiones instaladas:"
docker --version
docker-compose --version

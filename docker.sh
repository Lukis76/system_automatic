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
	echo "Docker se ha instalado correctamente."
else
	echo "Docker ya está instalado."

	# Verificar si hay actualizaciones disponibles para Docker
	if sudo apt-get update -qq --allow-releaseinfo-change && sudo apt-get upgrade -s docker-ce | grep -q 'Inst docker-ce'; then
		echo "Hay actualizaciones disponibles para Docker. Actualizando Docker..."
		sudo apt-get update -qq --allow-releaseinfo-change && sudo apt-get upgrade -y docker-ce
		echo "Docker se ha actualizado correctamente."
	else
		echo "Docker ya está en la última versión."
	fi
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &>/dev/null; then
	echo "Docker Compose no está instalado. Instalando Docker Compose..."
	sudo apt-get install docker-compose -y
	echo "Docker Compose se ha instalado correctamente."
else
	echo "Docker Compose ya está instalado."

	if sudo apt-get update -qq --allow-releaseinfo-change && sudo apt-get upgrade -s docker-compose | grep -q 'Inst docker-compose'; then

		echo "Hay una actualización disponible para Docker Compose. Actualizando Docker Compose..."
		sudo apt-get update -qq --allow-releaseinfo-change && sudo apt-get upgrade -y docker-compose
		echo "Docker Compose se ha actualizado correctamente."
	else
		echo "Docker Compose ya está en la última versión."
	fi
fi

sudo usermod -aG docker "$USER"
sudo ls -la /var/run/docker.sock
sudo chown $USER:$USER /var/run/docker.sock

# Verificar las versiones instaladas
echo "Versiones instaladas:"
docker --version
docker-compose --version

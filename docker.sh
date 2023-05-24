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
	sudo ls -la /var/run/docker.sock
	sudo chown $USER:$USER /var/run/docker.sock
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

# Verificar si pip está instalado
if ! command -v pip &>/dev/null; then
	echo "pip no está instalado. Instalando pip..."
	sudo apt-get install -y python3-pip
	echo "pip se ha instalado correctamente."
else
	echo "pip ya está instalado."
fi

# Verificar si pip está en su última versión
installed_version=$(pip --version | awk '{print $2}')
latest_version=$(pip install --upgrade pip >/dev/null && pip --version | awk '{print $2}')
if [[ $installed_version != $latest_version ]]; then
	echo "Hay una actualización disponible para pip. Actualizando pip..."
	pip install --upgrade pip
	echo "pip se ha actualizado correctamente."
else
	echo "pip ya está en la última versión."
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &>/dev/null; then
	echo "Docker Compose no está instalado. Instalando Docker Compose..."
	sudo pip install docker-compose
	echo "Docker Compose se ha instalado correctamente."
else
	echo "Docker Compose ya está instalado."

	# Verificar si hay actualizaciones disponibles para Docker Compose
	installed_version=$(docker-compose --version | awk '{print $3}')
	latest_version=$(curl -sSL https://api.github.com/repos/docker/compose/releases/latest | grep -oE '([0-9]+\.){2}[0-9]+' | head -n 1)
	if [[ $installed_version != $latest_version ]]; then
		echo "Hay una actualización disponible para Docker Compose. Actualizando Docker Compose..."
		sudo pip install --upgrade docker-compose
		echo "Docker Compose se ha actualizado correctamente."
	else
		echo "Docker Compose ya está en la última versión."
	fi
fi

# Verificar las versiones instaladas
echo "Versiones instaladas:"
docker --version
docker-compose --version

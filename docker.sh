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

	# Obtener la versión actual de Docker
	current_version=$(docker --version | awk '{print $3}')
	echo "Versión actual de Docker: $current_version"

	# Obtener la última versión estable de Docker
	latest_version=$(curl -sSL https://download.docker.com/linux/static/stable/x86_64/ | grep -oE 'docker-[0-9]+\.[0-9]+\.[0-9]+.tgz' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -n 1)
	echo "Última versión estable de Docker: $latest_version"

	# Verificar si se requiere actualizar Docker
	if [[ $current_version != $latest_version ]]; then
		echo "Actualizando Docker a la versión $latest_version..."
		curl -fsSL https://get.docker.com | sh
		sudo usermod -aG docker "$USER"
		echo "Docker se ha actualizado correctamente a la versión $latest_version."
	else
		echo "Docker ya está en la última versión estable."
	fi

fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &>/dev/null; then
	echo "Docker Compose no está instalado. Instalando Docker Compose..."
	sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
	sudo chmod +x /usr/bin/docker-compose
	echo "Docker Compose se ha instalado correctamente."
else
	echo "Docker Compose ya está instalado."

	# Obtener la versión actual de Docker Compose
	current_version=$(docker-compose --version | awk '{print $3}')
	echo "Versión actual de Docker Compose: $current_version"

	# Obtener la última versión estable de Docker Compose
	latest_version=$(curl -sSL https://api.github.com/repos/docker/compose/releases/latest | grep -oE '([0-9]+\.){2}[0-9]+' | head -n 1)
	echo "Última versión estable de Docker Compose: $latest_version"

	# Verificar si se requiere actualizar Docker Compose
	if [[ $current_version != $latest_version ]]; then
		echo "Actualizando Docker Compose a la versión $latest_version..."
		sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
		sudo chmod +x /usr/bin/docker-compose
		echo "Docker Compose se ha actualizado correctamente a la versión $latest_version."
	else
		echo "Docker Compose ya está en la última versión estable."
	fi

fi

# Verificar las versiones instaladas
echo "Versiones instaladas:"
docker --version
docker-compose --version

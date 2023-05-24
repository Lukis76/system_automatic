#!/bin/bash

# Verificar si wget está instalado
if ! command -v wget &>/dev/null; then
	echo "wget no está instalado. Instalando..."
	sudo apt-get update
	sudo apt-get install wget
else
	echo "wget está instalado."
fi

# Descargar el paquete de instalación de Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Instalar Google Chrome utilizando el gestor de paquetes dpkg
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Resolver dependencias faltantes
sudo apt-get -f install

# Eliminar el paquete de instalación descargado
rm google-chrome-stable_current_amd64.deb

#!/bin/bash

# Verificar si Volta está instalado
if ! command -v volta &>/dev/null; then
    echo "Volta no está instalado. Instalando..."
    curl https://get.volta.sh | bash
    export PATH="$HOME/.volta/bin:$PATH"
else
    echo "Volta está instalado."
fi

# Verificar la versión de Node.js
if command -v volta &>/dev/null; then
    volta --version
    volta install node
    node --version
else
    echo "No se puede encontrar Volta. No se puede instalar Node.js."
fi


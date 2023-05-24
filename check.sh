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

# Tu código aquí para Linux y Ubuntu
echo "El sistema es Linux y es Ubuntu."





# # Verificar si Volta está instalado
# if ! command -v volta &>/dev/null; then
#     echo "Volta no está instalado. Instalando..."
#     curl https://get.volta.sh | bash
#     export PATH="$HOME/.volta/bin:$PATH"
# else
#     echo "Volta está instalado."
# fi

# # Verificar la versión de Node.js
# if command -v volta &>/dev/null; then
#     volta --version
#     volta install node
#     node --version
# else
#     echo "No se puede encontrar Volta. No se puede instalar Node.js."
# fi


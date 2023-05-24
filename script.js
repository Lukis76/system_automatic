
// script.js

const fs = require('fs');
const https = require('https');
const { execSync } = require('child_process');

function downloadAndExecuteScript(url) {
  https.get(url, (response) => {
    let data = '';

    response.on('data', (chunk) => {
      data += chunk;
    });

    response.on('end', () => {
      fs.writeFileSync('install.sh', data);
      console.log('Script descargado correctamente.');

      // Ejecutar el script aquí
      // fs.chmodSync('install.sh', '755');
      // execSync('./install.sh');
    });
  }).on('error', (error) => {
    console.error(`Error al descargar el script: ${error}`);
  });
}

function checkAndInstallNodeJS() {
  try {
    execSync('node --version');
    console.log('Node.js ya está instalado.');
  } catch (error) {
    console.log('Node.js no está instalado. Instalando la última versión...');
    execSync('curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -');
    execSync('sudo apt-get install -y nodejs');
    console.log('Node.js instalado correctamente.');
  }
}

// Exportar las funciones para usarlas desde el archivo `main.yml`
module.exports = {
  downloadAndExecuteScript,
  checkAndInstallNodeJS,
};

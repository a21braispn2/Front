#!/bin/bash

set -e

cd /app

if [ ! -f "package.json" ]; then
    echo "Non se atopou proxecto. Creando un novo proxecto Vue + Vite..."

    npm create vite@latest . --y -- --template vue

    echo "Proxecto creado. Instalando dependencias iniciais..."
    npm install

else
    echo "O proxecto xa existe."
    
    if [ ! -d "node_modules" ]; then
        echo "Instalando dependencias..."
        npm install
    fi
fi

echo "Arrancando servidor de desenvolvemento Vite..."
exec npm run dev -- --host
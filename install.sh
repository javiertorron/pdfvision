#!/bin/bash

# Script de instalación para el Convertidor de PDF a PNG

echo "=== Instalador del Convertidor PDF a PNG ==="
echo ""

# Verificar si estamos en Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "Este script está diseñado para Linux"
    exit 1
fi

# Instalar dependencias del sistema
echo "1. Instalando dependencias del sistema..."
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-pyqt5 poppler-utils

# Instalar dependencias de Python
echo ""
echo "2. Instalando dependencias de Python..."
pip3 install -r requirements.txt

# Hacer el script principal ejecutable
chmod +x pdf_converter.py

echo ""
echo "=== Instalación completada ==="
echo ""
echo "Para ejecutar la aplicación:"
echo "  python3 pdf_converter.py"
echo ""
echo "O ejecutar directamente:"
echo "  ./pdf_converter.py"

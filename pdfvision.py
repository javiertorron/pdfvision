#!/usr/bin/env python3
"""
PDF Vision - Convertidor de PDF a PNG
Wrapper para ejecución desde menú de aplicaciones
"""

import sys
import os

# Añadir ruta del script al path si es necesario
script_dir = os.path.dirname(os.path.abspath(__file__))
if script_dir not in sys.path:
    sys.path.insert(0, script_dir)

# Importar y ejecutar la aplicación
from pdf_converter import main

if __name__ == '__main__':
    main()

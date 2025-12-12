#!/bin/bash

echo "╔════════════════════════════════════════════╗"
echo "║  Verificador de instalación de PDF Vision  ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Función para mostrar resultado
check() {
    if eval "$1" > /dev/null 2>&1; then
        echo "✓ $2"
    else
        echo "✗ $2"
        return 1
    fi
}

echo "Verificando instalación..."
echo ""

# Verificaciones
STATUS=0
check "which pdfvision" "Ejecutable instalado" || STATUS=1
check "dpkg -s pdfvision | grep -q 'install ok'" "Paquete registrado en dpkg" || STATUS=1
check "test -f /usr/share/applications/pdfvision.desktop" "Entrada en menú de aplicaciones" || STATUS=1
check "test -f /usr/share/pixmaps/pdfvision.svg" "Icono instalado" || STATUS=1
check "test -f /usr/share/doc/pdfvision/README.md" "Documentación instalada" || STATUS=1
check "command -v python3" "Python 3 disponible" || STATUS=1
check "python3 -c 'import PyQt5'" "PyQt5 instalado" || STATUS=1
check "command -v pdftoppm" "pdftoppm (poppler-utils) instalado" || STATUS=1

echo ""
if [ $STATUS -eq 0 ]; then
    echo "╔════════════════════════════════════════════╗"
    echo "║    ✓ TODO ESTÁ CORRECTAMENTE INSTALADO    ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "Puedes ejecutar la aplicación con:"
    echo "  • pdfvision (desde terminal)"
    echo "  • Buscar 'PDF Vision' en el menú de aplicaciones"
else
    echo "╔════════════════════════════════════════════╗"
    echo "║         ⚠ HAY PROBLEMAS DETECTADOS        ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "Intenta reinstalar:"
    echo "  sudo apt remove pdfvision"
    echo "  sudo dpkg -i build/pdfvision_1.0.0.deb"
fi

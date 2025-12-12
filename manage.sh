#!/bin/bash

# Script de gestión de PDF Vision

show_menu() {
    echo ""
    echo "╔════════════════════════════════════╗"
    echo "║      PDF Vision - Gestor v1.0      ║"
    echo "╚════════════════════════════════════╝"
    echo ""
    echo "1. Construir paquete .deb"
    echo "2. Instalar paquete .deb"
    echo "3. Desinstalar paquete"
    echo "4. Ver información del paquete"
    echo "5. Ejecutar aplicación (desarrollo)"
    echo "6. Limpiar archivos de compilación"
    echo "7. Salir"
    echo ""
}

build_deb() {
    echo "Construyendo paquete .deb..."
    bash build_deb.sh
}

install_deb() {
    DEB_FILE="build/pdfvision_1.0.0.deb"
    if [ -f "$DEB_FILE" ]; then
        sudo dpkg -i "$DEB_FILE"
    else
        echo "❌ El archivo .deb no existe. Primero construye el paquete."
        build_deb
        install_deb
    fi
}

uninstall_deb() {
    echo "Desinstalando PDF Vision..."
    sudo apt remove -y pdfvision
    echo "✓ Desinstalación completada"
}

show_info() {
    echo ""
    echo "=== Información del paquete ==="
    dpkg -s pdfvision 2>/dev/null || echo "El paquete no está instalado"
    echo ""
}

run_app() {
    echo "Ejecutando PDF Vision (modo desarrollo)..."
    python3 pdf_converter.py
}

clean() {
    echo "Limpiando archivos de compilación..."
    rm -rf build/
    echo "✓ Limpieza completada"
}

# Menú principal
while true; do
    show_menu
    read -p "Selecciona una opción: " choice
    
    case $choice in
        1) build_deb ;;
        2) install_deb ;;
        3) uninstall_deb ;;
        4) show_info ;;
        5) run_app ;;
        6) clean ;;
        7) echo "¡Hasta luego!"; exit 0 ;;
        *) echo "❌ Opción inválida" ;;
    esac
done

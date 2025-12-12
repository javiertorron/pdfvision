#!/bin/bash

# Script para construir el paquete .deb

set -e

echo "=== Construcción del paquete DEB ==="
echo ""

# Variables
APP_NAME="pdfvision"
APP_VERSION="1.0.0"
APP_DISPLAY_NAME="PDF Vision"
PACKAGE_NAME="pdfvision"
BUILD_DIR="build"
DEBIAN_DIR="${BUILD_DIR}/${PACKAGE_NAME}_${APP_VERSION}"

# Limpiar directorios anteriores
echo "1. Limpiando directorios de construcción..."
rm -rf "$BUILD_DIR"

# Crear estructura de directorios
echo "2. Creando estructura de directorios..."
mkdir -p "$DEBIAN_DIR/DEBIAN"
mkdir -p "$DEBIAN_DIR/usr/bin"
mkdir -p "$DEBIAN_DIR/usr/share/applications"
mkdir -p "$DEBIAN_DIR/usr/share/pixmaps"
mkdir -p "$DEBIAN_DIR/usr/share/doc/${PACKAGE_NAME}"

# Copiar archivos
echo "3. Copiando archivos..."

# Script principal
cp pdf_converter.py "$DEBIAN_DIR/usr/bin/$APP_NAME"
chmod 755 "$DEBIAN_DIR/usr/bin/$APP_NAME"

# Icono
cp icon.svg "$DEBIAN_DIR/usr/share/pixmaps/${APP_NAME}.svg"
chmod 644 "$DEBIAN_DIR/usr/share/pixmaps/${APP_NAME}.svg"

# Archivo .desktop
cat > "$DEBIAN_DIR/usr/share/applications/${APP_NAME}.desktop" << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=PDF Vision
Comment=Convierte PDFs a imágenes PNG de alta resolución
Exec=pdfvision
Icon=pdfvision
Categories=Utility;Graphics;
Terminal=false
Keywords=pdf;converter;png;image;
EOF

# Documentación
cp README.md "$DEBIAN_DIR/usr/share/doc/${PACKAGE_NAME}/"
cp LICENSE "$DEBIAN_DIR/usr/share/doc/${PACKAGE_NAME}/" 2>/dev/null || echo "# License" > "$DEBIAN_DIR/usr/share/doc/${PACKAGE_NAME}/copyright"

# Crear archivo DEBIAN/control
echo "4. Creando archivo de control..."
cat > "$DEBIAN_DIR/DEBIAN/control" << EOF
Package: ${PACKAGE_NAME}
Version: ${APP_VERSION}
Architecture: all
Maintainer: PDF Vision Development <dev@pdfvision.local>
Depends: python3 (>= 3.6), python3-pyqt5, poppler-utils
Description: Convertidor de PDF a PNG
 PDF Vision es una aplicación de escritorio para Ubuntu que convierte
 archivos PDF a imágenes PNG de alta resolución (300 DPI).
 .
 Características:
  - Interfaz gráfica intuitiva con PyQt5
  - Selector visual de archivos y directorios
  - Barra de progreso en tiempo real
  - Conversión de alta calidad
  - Soporte para múltiples páginas
Homepage: https://github.com/yourusername/pdfvision
EOF

# Crear script postinst
cat > "$DEBIAN_DIR/DEBIAN/postinst" << 'EOF'
#!/bin/bash
set -e

# Actualizar entrada de aplicaciones
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database /usr/share/applications
fi

# Actualizar icono
if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -f /usr/share/pixmaps 2>/dev/null || true
fi

echo "✓ PDF Vision instalado correctamente"
echo "Puedes ejecutarlo desde el menú de aplicaciones o escribiendo: pdfvision"
EOF

chmod 755 "$DEBIAN_DIR/DEBIAN/postinst"

# Crear script prerm
cat > "$DEBIAN_DIR/DEBIAN/prerm" << 'EOF'
#!/bin/bash
set -e
# Limpieza antes de desinstalación
exit 0
EOF

chmod 755 "$DEBIAN_DIR/DEBIAN/prerm"

# Crear archivo changelog
cat > "$DEBIAN_DIR/DEBIAN/changelog" << EOF
${PACKAGE_NAME} (${APP_VERSION}-1) focal; urgency=medium

  * Versión inicial de PDF Vision
  * Interfaz gráfica con PyQt5
  * Conversión a 300 DPI
  * Barra de progreso
  * Cancelación de conversión

 -- PDF Vision <dev@pdfvision.local>  $(date -R)
EOF

chmod 644 "$DEBIAN_DIR/DEBIAN/changelog"

# Crear archivo copyright
cat > "$DEBIAN_DIR/DEBIAN/copyright" << EOF
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: pdfvision
Upstream-Contact: PDF Vision <dev@pdfvision.local>
Source: https://github.com/yourusername/pdfvision

Files: *
Copyright: 2025 PDF Vision
License: MIT
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 .
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
EOF

# Crear paquete DEB
echo "5. Construyendo paquete .deb..."
cd "$BUILD_DIR"
dpkg-deb --build "${PACKAGE_NAME}_${APP_VERSION}"
cd ..

# Información de salida
DEB_FILE="${BUILD_DIR}/${PACKAGE_NAME}_${APP_VERSION}.deb"

echo ""
echo "=== ✓ Construcción completada ==="
echo ""
echo "Paquete creado: $DEB_FILE"
echo "Tamaño: $(du -h "$DEB_FILE" | cut -f1)"
echo ""
echo "Para instalar:"
echo "  sudo dpkg -i $DEB_FILE"
echo ""
echo "Para desinstalar:"
echo "  sudo apt remove ${PACKAGE_NAME}"
echo ""

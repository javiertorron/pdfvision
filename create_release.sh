#!/bin/bash

# Script para crear una release en GitHub usando GitHub CLI
# Requiere: GitHub CLI (gh) instalado y autenticado

set -e

VERSION="1.0.0"
REPO_URL="https://github.com/javiertorron/pdf-vision"
RELEASE_TAG="v${VERSION}"
PACKAGE_NAME="pdfvision_${VERSION}.deb"
PACKAGE_PATH="build/${PACKAGE_NAME}"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         GitHub Release Creator - PDF Vision v${VERSION}            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Verificar que el paquete existe
if [ ! -f "$PACKAGE_PATH" ]; then
    echo "❌ Error: Package file not found: $PACKAGE_PATH"
    echo ""
    echo "Please run: ./build_deb.sh"
    exit 1
fi

echo "✓ Package found: $PACKAGE_PATH"
echo "✓ File size: $(du -h "$PACKAGE_PATH" | cut -f1)"
echo ""

# Verificar que git está configurado
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a Git repository"
    exit 1
fi

echo "✓ Git repository: $(git config --get remote.origin.url)"
echo ""

# Verificar que GitHub CLI está instalado
if ! command -v gh &> /dev/null; then
    echo "⚠️  GitHub CLI (gh) is not installed"
    echo ""
    echo "To create the release manually on GitHub:"
    echo "1. Go to: $REPO_URL/releases"
    echo "2. Click 'Create a new release'"
    echo "3. Tag: $RELEASE_TAG"
    echo "4. Title: PDF Vision v${VERSION}"
    echo "5. Description: (copy from RELEASE_NOTES.md)"
    echo "6. Upload: $PACKAGE_PATH"
    echo "7. Publish release"
    echo ""
    exit 0
fi

echo "✓ GitHub CLI is installed"
echo ""

# Verificar autenticación
if ! gh auth status > /dev/null 2>&1; then
    echo "⚠️  Not authenticated with GitHub"
    echo ""
    echo "To authenticate:"
    echo "  gh auth login"
    echo ""
    exit 0
fi

echo "✓ Authenticated with GitHub"
echo ""

# Crear release usando GitHub CLI
echo "Creating release on GitHub..."
echo ""

# Leer el contenido de RELEASE_NOTES.md
RELEASE_BODY=$(cat RELEASE_NOTES.md)

# Crear la release
gh release create "$RELEASE_TAG" \
    --title "PDF Vision v${VERSION}" \
    --notes "$RELEASE_BODY" \
    "$PACKAGE_PATH"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              ✅ RELEASE CREATED SUCCESSFULLY!                  ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📦 Release Information:"
echo "  Tag: $RELEASE_TAG"
echo "  Package: $PACKAGE_NAME"
echo "  URL: $REPO_URL/releases/tag/$RELEASE_TAG"
echo ""
echo "🔗 Download:"
echo "  wget $REPO_URL/releases/download/$RELEASE_TAG/$PACKAGE_NAME"
echo ""

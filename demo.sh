#!/bin/bash

# Script de demostración de PDF Vision con progreso

echo "╔══════════════════════════════════════════════════════╗"
echo "║   PDF Vision - Demostración de Progreso en Tiempo Real ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# PDF de prueba con 10 páginas
TEST_PDF="/tmp/test_multi_page.pdf"
OUTPUT_DIR="/tmp/pdf_vision_test"

echo "1. Verificando PDF de prueba..."
if [ ! -f "$TEST_PDF" ]; then
    echo "❌ PDF de prueba no encontrado en $TEST_PDF"
    echo "Creando PDF de prueba..."
    python3 << 'EOF'
#!/usr/bin/env python3
pdf_content = b"""%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R 4 0 R 5 0 R 6 0 R 7 0 R 8 0 R 9 0 R 10 0 R 11 0 R 12 0 R] /Count 10 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 13 0 R >>
endobj
4 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 14 0 R >>
endobj
5 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 15 0 R >>
endobj
6 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 16 0 R >>
endobj
7 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 17 0 R >>
endobj
8 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 18 0 R >>
endobj
9 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 19 0 R >>
endobj
10 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 20 0 R >>
endobj
11 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 21 0 R >>
endobj
12 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 22 0 R >>
endobj
13 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 1) Tj ET
endstream
endobj
14 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 2) Tj ET
endstream
endobj
15 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 3) Tj ET
endstream
endobj
16 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 4) Tj ET
endstream
endobj
17 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 5) Tj ET
endstream
endobj
18 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 6) Tj ET
endstream
endobj
19 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 7) Tj ET
endstream
endobj
20 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 8) Tj ET
endstream
endobj
21 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 9) Tj ET
endstream
endobj
22 0 obj
<< >>
stream
BT /F1 36 Tf 50 700 Td (Página 10) Tj ET
endstream
endobj
xref
0 23
0000000000 65535 f 
0000000009 00000 n 
0000000058 00000 n 
0000000124 00000 n 
0000000218 00000 n 
0000000313 00000 n 
0000000409 00000 n 
0000000506 00000 n 
0000000604 00000 n 
0000000703 00000 n 
0000000803 00000 n 
0000000904 00000 n 
0000001006 00000 n 
0000001109 00000 n 
0000001180 00000 n 
0000001251 00000 n 
0000001322 00000 n 
0000001393 00000 n 
0000001464 00000 n 
0000001535 00000 n 
0000001606 00000 n 
0000001677 00000 n 
0000001748 00000 n 
trailer
<< /Size 23 /Root 1 0 R >>
startxref
1819
%%EOF
"""
with open('/tmp/test_multi_page.pdf', 'wb') as f:
    f.write(pdf_content)
print("✓ PDF de prueba creado")
EOF
fi

# Contar páginas
PAGE_COUNT=$(pdfinfo "$TEST_PDF" 2>/dev/null | grep Pages | awk '{print $2}')
echo "✓ PDF: $TEST_PDF"
echo "✓ Páginas: $PAGE_COUNT"

echo ""
echo "2. Creando directorio de salida..."
mkdir -p "$OUTPUT_DIR"
echo "✓ Directorio: $OUTPUT_DIR"

echo ""
echo "3. Iniciando conversión con pdftoppm..."
echo "   (La barra de progreso avanzará con cada página convertida)"
echo ""

# Ejecutar la conversión y mostrar progreso en tiempo real
pdftoppm -png -r 300 "$TEST_PDF" "$OUTPUT_DIR/test" &
PID=$!

echo "Progreso: ["
# Monitorear el progreso
while kill -0 $PID 2>/dev/null; do
    PNG_COUNT=$(ls "$OUTPUT_DIR"/test-*.png 2>/dev/null | wc -l)
    PROGRESS=$((PNG_COUNT * 100 / PAGE_COUNT))
    
    # Mostrar barra de progreso
    BAR_LENGTH=$((PROGRESS / 5))
    BAR=$(printf '#%.0s' {1..$BAR_LENGTH})
    SPACES=$(printf ' %.0s' {1..$((20 - BAR_LENGTH))})
    
    printf "\rProgreso: [%-20s] %3d%% (%d/%d páginas)     " "$BAR" "$PROGRESS" "$PNG_COUNT" "$PAGE_COUNT"
    sleep 0.2
done

wait $PID

echo ""
echo ""
echo "4. Verificando resultados..."
PNG_COUNT=$(ls "$OUTPUT_DIR"/test-*.png 2>/dev/null | wc -l)
echo "✓ Páginas convertidas: $PNG_COUNT"
echo "✓ Ubicación: $OUTPUT_DIR"
echo ""
ls -lh "$OUTPUT_DIR"/test-*.png | head -3
echo "   ... (y más)"

echo ""
echo "╔════════════════════════════════════════════════╗"
echo "║    ✓ DEMOSTRACIÓN COMPLETADA CON ÉXITO        ║"
echo "╚════════════════════════════════════════════════╝"
echo ""
echo "Para probar la aplicación GUI:"
echo "  • pdfvision (si está instalado)"
echo "  • python3 pdf_converter.py"
echo ""
echo "Archivos de prueba:"
echo "  • PDF: $TEST_PDF"
echo "  • PNG: $OUTPUT_DIR"

# Convertidor de PDF a PNG

Aplicación de escritorio GUI para Ubuntu que convierte archivos PDF a imágenes PNG con alta resolución (300 DPI).

## Características

- ✨ Interfaz gráfica intuitiva con PyQt5
- 📁 Selector de archivo PDF con diálogo de archivo
- 📂 Selector de directorio destino
- ⏱️ Barra de progreso visual durante la conversión
- 🎯 Conversión de alta resolución (300 DPI)
- 🛑 Botón para cancelar conversión
- 📊 Indicadores de estado en tiempo real

## Requisitos

- Ubuntu 18.04 o superior
- Python 3.6 o superior
- `pdftoppm` (incluido en el paquete `poppler-utils`)

## Instalación

### ⭐ Opción 1: Paquete .deb (Recomendado para usuarios)

```bash
# Construir el paquete
./build_deb.sh

# Instalar
sudo dpkg -i build/pdfvision_1.0.0.deb
```

O usar el gestor:
```bash
./manage.sh
# Selecciona opción 1 (Construir) y luego opción 2 (Instalar)
```

### Opción 2: Script de instalación

```bash
chmod +x install.sh
./install.sh
```

### Opción 3: Instalación manual

```bash
# Instalar dependencias del sistema
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-pyqt5 poppler-utils

# Instalar dependencias de Python
pip3 install -r requirements.txt

# Hacer el script ejecutable
chmod +x pdf_converter.py
```

## Uso

### Desde el menú de aplicaciones (si está instalado como .deb)

Busca "PDF Vision" en tu menú de aplicaciones y haz clic para ejecutar.

### Desde terminal

```bash
# Si está instalado como paquete .deb:
pdfvision

# Si está en desarrollo:
python3 pdf_converter.py

# O directamente:
./pdf_converter.py
```

### Uso de la aplicación

1. **Seleccionar PDF**: Haz clic en "Examinar" para seleccionar el archivo PDF que deseas convertir
2. **Seleccionar destino**: Haz clic en "Examinar" para elegir dónde guardar las imágenes PNG
3. **Iniciar conversión**: Haz clic en "Iniciar Conversión"
4. **Monitorear progreso**: Observa la barra de progreso y el estado
5. **Resultado**: Se mostrarán los archivos PNG convertidos en el directorio seleccionado

## Cómo funciona

La aplicación utiliza `pdftoppm` con los siguientes parámetros:

```bash
pdftoppm -png -r 300 archivo.pdf directorio_salida/
```

- `-png`: Especifica que el formato de salida es PNG
- `-r 300`: Establece la resolución a 300 DPI (alta calidad)
- Genera un archivo PNG por cada página del PDF

## Instalación de dependencias en caso de error

Si la aplicación no funciona, intenta instalar manualmente las dependencias:

```bash
# Para Debian/Ubuntu
sudo apt-get install poppler-utils
sudo apt-get install python3-pyqt5

# Alternativa con pip
pip3 install PyQt5
```

## Estructura del proyecto

```
pdf_converter/
├── pdf_converter.py       # Aplicación principal
├── pdfvision.py          # Wrapper para menú de aplicaciones
├── icon.svg              # Icono de la aplicación
├── requirements.txt      # Dependencias de Python
├── install.sh            # Script de instalación simple
├── build_deb.sh          # Script para construir .deb
├── manage.sh             # Gestor interactivo
├── LICENSE               # Licencia MIT
├── README.md             # Este archivo
└── build/                # Directorio de compilación
    └── pdfvision_1.0.0.deb
```

## Solución de problemas

### "pdftoppm: command not found"

Instala poppler-utils:
```bash
sudo apt-get install poppler-utils
```

### Error de permisos al ejecutar

Dale permisos de ejecución:
```bash
chmod +x pdf_converter.py
```

### PyQt5 no encontrado

Instala PyQt5:
```bash
pip3 install PyQt5
```

O a través del repositorio del sistema:
```bash
sudo apt-get install python3-pyqt5
```

## Características técnicas

- **Threading**: La conversión se ejecuta en un thread separado para no congelar la GUI
- **Validación**: Verifica la existencia de archivos y dependencias antes de convertir
- **Manejo de errores**: Muestra mensajes de error detallados al usuario
- **Indicadores visuales**: Estados de color para mejor UX (verde=éxito, rojo=error, azul=procesando)

## Información del paquete .deb

**Nombre**: `pdfvision`
**Versión**: 1.0.0
**Dependencias**: python3, python3-pyqt5, poppler-utils
**Licencia**: MIT

### Localización de archivos instalados:

```
/usr/bin/pdfvision              # Ejecutable principal
/usr/share/applications/pdfvision.desktop  # Entrada del menú
/usr/share/pixmaps/pdfvision.svg          # Icono
/usr/share/doc/pdfvision/                 # Documentación
```

### Comandos útiles:

```bash
# Ver información del paquete instalado
dpkg -s pdfvision

# Ver archivos instalados
dpkg -L pdfvision

# Ver dependencias
dpkg -I build/pdfvision_1.0.0.deb

# Desinstalar
sudo apt remove pdfvision

# Limpiar el sistema después de desinstalar
sudo apt autoremove
```

## Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

## Autor

Convertidor PDF a PNG - 2025

## Notas

- Cada página del PDF genera un archivo PNG separado
- Los archivos PNG se nombran como: `nombre_pdf-001.png`, `nombre_pdf-002.png`, etc.
- La resolución de 300 DPI es ideal para impresión y buena legibilidad
- Puedes cambiar la resolución editando el valor en `pdf_converter.py` (línea ~95)

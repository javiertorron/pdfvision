# 🖼️ PDF Vision - Instalación y Distribución

## Distribución del paquete .deb

El paquete **pdfvision_1.0.0.deb** está listo en el directorio `build/`.

### 📥 Para usuarios finales:

#### Instalación rápida:
```bash
wget https://github.com/tu-usuario/pdfvision/releases/download/v1.0.0/pdfvision_1.0.0.deb
sudo dpkg -i pdfvision_1.0.0.deb
```

#### Después de instalar:
1. Busca "PDF Vision" en tu menú de aplicaciones
2. O ejecuta desde terminal: `pdfvision`

### 🛠️ Para desarrolladores:

#### Clonar y construir:
```bash
git clone https://github.com/tu-usuario/pdfvision.git
cd pdfvision
./build_deb.sh
sudo dpkg -i build/pdfvision_1.0.0.deb
```

#### Gestionar con el script interactivo:
```bash
./manage.sh
```

Opciones disponibles:
- Construir paquete .deb
- Instalar/desinstalar
- Ver información
- Ejecutar en modo desarrollo
- Limpiar archivos

### 📋 Requisitos del sistema

- Ubuntu 18.04 LTS o superior (o cualquier distribución Debian basada)
- Espacio en disco: ~50 MB
- RAM: Mínimo 256 MB

### 🚀 Características instaladas

- ✅ Ejecutable `/usr/bin/pdfvision`
- ✅ Entrada en menú de aplicaciones
- ✅ Icono de escritorio
- ✅ Documentación completa

### 📦 Contenido del paquete

```
Paquete: pdfvision
Versión: 1.0.0
Arquitectura: all (compatible con cualquier procesador)
Dependencias: python3, python3-pyqt5, poppler-utils
Tamaño: ~8 KB (+ dependencias)
```

### ❌ Desinstalación

```bash
sudo apt remove pdfvision
```

### 🐛 Problemas comunes

**Error: "pdftoppm: command not found"**
```bash
sudo apt install poppler-utils
```

**Error: "No module named PyQt5"**
```bash
sudo apt install python3-pyqt5
```

**La aplicación no aparece en el menú**
```bash
sudo update-desktop-database /usr/share/applications
```

### 📄 Licencia

MIT License - Véase el archivo LICENSE

### 💬 Soporte

Para reportar problemas o sugerencias, abre un issue en:
https://github.com/tu-usuario/pdfvision/issues

# Changelog - PDF Vision

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.1] - 2025-12-12

### Fixed
- **Critical**: Progress bar now updates in real-time during PDF conversion
  - Root cause: Synchronous monitoring function was blocking the conversion process
  - Solution: Implemented parallel threading worker for non-blocking progress tracking
  - Progress advances 1% per page as PNG files are generated
  - Monitor checks destination folder every 500ms

### Changed
- Switched from `QProcess` to `subprocess.Popen` for better process control
- Replaced `QThread`-based monitoring with `threading.Thread` for parallel execution
- Improved thread synchronization and cleanup on completion

### Technical Details
- **Architecture**: Dual-thread design
  - Main QThread: Handles PDF conversion with pdftoppm
  - Worker Thread: Monitors PNG file generation in parallel
- **Progress Calculation**: `(PNG_files_count / total_pages) × 100`
- **File Monitoring**: Real-time scanning of destination directory every 500ms

---

## [1.0.0] - 2025-12-12

### Added
- **GUI Application**: Full desktop interface with PyQt5
  - File selection dialog for PDF input
  - Directory selection dialog for output path
  - Real-time progress bar (0-100%)
  - Status indicator showing conversion progress
  - Professional styling with color-coded buttons

- **PDF Conversion**:
  - High-quality PNG output at 300 DPI
  - Automatic page detection using pdfinfo
  - Batch processing for all PDF pages
  - Error handling and user feedback

- **System Integration**:
  - Ubuntu .deb package (12KB, installable)
  - Desktop menu integration with custom icon
  - Command-line launcher: `pdfvision`
  - Proper dependency management

- **Documentation**:
  - Comprehensive README.md
  - Contributing guidelines
  - MIT License
  - Setup instructions

- **Build System**:
  - Automated .deb package builder
  - Post-install scripts for system integration
  - Version management

### Requirements
- Python 3.6+
- PyQt5 5.12+
- poppler-utils (pdftoppm, pdfinfo)
- Ubuntu 18.04 LTS or later

---

## Planned Features

### v1.1.0 (Upcoming)
- [ ] Batch conversion (multiple PDFs)
- [ ] Format options (JPEG, TIFF)
- [ ] Quality/resolution settings
- [ ] Recent files history
- [ ] Drag & drop support

### v1.2.0 (Future)
- [ ] Advanced image processing
- [ ] Watermark support
- [ ] Page range selection
- [ ] Output filename customization

---

## Support

- **Issues**: https://github.com/javiertorron/pdfvision/issues
- **Contributing**: See CONTRIBUTING.md
- **License**: MIT - See LICENSE file

```bash
./CHECK_DEB.sh
```

O manualmente:
```bash
pdfvision --help  # Ejecutar la aplicación
dpkg -s pdfvision # Ver información del paquete
```

## 📝 Notas técnicas

- **Thread safety**: El monitoreo de progreso se ejecuta en un thread separado
- **No bloquea la GUI**: La conversión y monitoreo no interfieren con la interfaz
- **Cancración en cualquier momento**: El botón "Cancelar" sigue siendo funcional
- **Manejo de errores**: Si algo falla, se muestra un mensaje claro al usuario

## 🚀 Funcionalidades completas

✅ Selector visual de PDF con diálogo de archivo
✅ Selector de directorio destino
✅ **Progreso dinámico** (NUEVA)
✅ Conversión a 300 DPI
✅ Botón para cancelar conversión
✅ Interfaz gráfica intuitiva con PyQt5
✅ Paquete instalable `.deb` para Ubuntu
✅ Entrada en menú de aplicaciones
✅ Icono profesional

## 📋 Archivos incluidos

- `pdf_converter.py` - Aplicación principal (actualizada)
- `pdfvision.py` - Wrapper para menú
- `build_deb.sh` - Script de construcción
- `manage.sh` - Gestor interactivo
- `CHECK_DEB.sh` - Verificador de instalación
- `demo.sh` - Script de demostración
- `README.md` - Documentación
- `DISTRIBUTION.md` - Guía de distribución
- `icon.svg` - Icono de la aplicación
- `LICENSE` - Licencia MIT

¡Disfrutar la aplicación mejorada!

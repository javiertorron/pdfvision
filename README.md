# PDF Vision

> A professional desktop application for converting PDF documents to high-quality PNG images on Ubuntu/Linux.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/python-3.6+-blue.svg)](https://www.python.org/downloads/)
[![Ubuntu 18.04+](https://img.shields.io/badge/ubuntu-18.04+-orange.svg)](https://ubuntu.com/)

## 🌟 Features

- **Intuitive GUI** - User-friendly interface built with PyQt5
- **Visual File Selection** - Dialog-based PDF file picker
- **Directory Selection** - Choose custom output location for PNG files
- **Real-time Progress Bar** - Dynamic progress tracking (1% per page)
- **High-Quality Output** - Converts to PNG at 300 DPI resolution
- **Batch Processing** - Converts all PDF pages to individual PNG images
- **Cancellation Support** - Stop conversion at any time
- **Live Status Indicators** - Color-coded status updates (green/red/blue)
- **Professional Icon** - Custom SVG icon for desktop integration
- **Installable Package** - Ubuntu-ready .deb package

## 📋 Requirements

- **OS**: Ubuntu 18.04 LTS or later (or any Debian-based distribution)
- **Python**: 3.6 or higher
- **Dependencies**:
  - `python3-pyqt5` - GUI framework
  - `poppler-utils` - PDF processing tools (pdftoppm, pdfinfo)

## 🚀 Installation

### Option 1: DEB Package (Recommended for Users)

```bash
# Download the latest release
wget https://github.com/javiertorron/pdf-vision/releases/download/v1.0.0/pdfvision_1.0.0.deb

# Install the package
sudo dpkg -i pdfvision_1.0.0.deb

# Install dependencies if needed
sudo apt-get install python3-pyqt5 poppler-utils
```

### Option 2: Build from Source

```bash
# Clone the repository
git clone https://github.com/javiertorron/pdf-vision.git
cd pdf-vision

# Make scripts executable
chmod +x build_deb.sh manage.sh

# Build the package
./build_deb.sh

# Install
sudo dpkg -i build/pdfvision_1.0.0.deb
```

### Option 3: Manual Installation

```bash
# Install system dependencies
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-pyqt5 poppler-utils

# Install Python dependencies
pip3 install -r requirements.txt

# Make the application executable
chmod +x pdf_converter.py

# Run the application
python3 pdf_converter.py
```

## 💻 Usage

### Launch the Application

**From Applications Menu:**
- Search for "PDF Vision" in your application launcher
- Click to run

**From Terminal:**
```bash
# If installed as .deb package
pdfvision

# If running from source
python3 pdf_converter.py
```

### Converting PDFs

1. **Select PDF File**
   - Click "Browse" next to "Select PDF File"
   - Choose your PDF document
   - The file path will appear in the input field

2. **Choose Output Directory**
   - Click "Browse" next to "Select Output Directory"
   - Select where to save the PNG images
   - The path will appear in the input field

3. **Start Conversion**
   - Click "Start Conversion" button
   - The progress bar will update as pages are processed
   - Each page = 1% progress for accurate tracking

4. **Monitor Progress**
   - Watch the progress bar advance in real-time
   - Status shows current percentage and page count
   - Conversion details appear when complete

5. **View Results**
   - PNG files are saved with names: `filename-001.png`, `filename-002.png`, etc.
   - Each PDF page becomes a separate PNG image
   - All files are stored in your chosen output directory

## 🔧 Technical Details

### How It Works

PDF Vision uses `pdftoppm` from the Poppler utilities with these parameters:

```bash
pdftoppm -png -r 300 input.pdf output_directory/
```

- **-png** - Output format is PNG
- **-r 300** - Resolution of 300 DPI (professional print quality)
- Creates one PNG file per PDF page

### Architecture

- **Multi-threading** - Conversion runs in separate thread (no GUI freezing)
- **Real-time Monitoring** - Progress tracking every 500ms
- **Dynamic Calculation** - Progress = (pages_converted / total_pages) × 100
- **Error Handling** - Comprehensive validation and user feedback
- **Resource Efficient** - Minimal memory footprint

### Key Components

1. **ConvertThread** - Handles PDF to PNG conversion
2. **PDFConverterApp** - Main GUI application window
3. **Progress Monitor** - Tracks file generation in real-time
4. **Dependency Checker** - Validates system requirements

## 📦 Package Details

| Property | Value |
|----------|-------|
| **Package Name** | pdfvision |
| **Version** | 1.0.0 |
| **Architecture** | all (universal) |
| **Size** | ~8.5 KB |
| **Maintainer** | PDF Vision Development |
| **License** | MIT |

### Installed Files

```
/usr/bin/pdfvision                           # Main executable
/usr/share/applications/pdfvision.desktop    # Application menu entry
/usr/share/pixmaps/pdfvision.svg            # Desktop icon
/usr/share/doc/pdfvision/README.md          # Documentation
/usr/share/doc/pdfvision/LICENSE            # License
```

## 🛠️ Project Structure

```
pdf-vision/
├── pdf_converter.py          # Main application (PyQt5)
├── pdfvision.py             # Application launcher
├── icon.svg                 # Professional SVG icon
├── build_deb.sh             # DEB package builder
├── manage.sh                # Interactive manager
├── demo.sh                  # Demo script with sample PDF
├── CHECK_DEB.sh             # Installation verifier
├── requirements.txt         # Python dependencies
├── install.sh               # Quick install script
├── LICENSE                  # MIT License
├── README.md                # This file
├── CHANGELOG.md             # Version history
├── DISTRIBUTION.md          # Distribution guide
└── build/                   # Build output directory
    └── pdfvision_1.0.0.deb  # Installable package
```

## ⚙️ Configuration & Customization

### Change Output Resolution

Edit `pdf_converter.py` and modify this line:

```python
'-r', '300',  # Change 300 to your desired DPI (e.g., 150, 200, 400)
```

### Modify Application Name

Edit `build_deb.sh` and change:

```bash
APP_NAME="pdfvision"
APP_DISPLAY_NAME="PDF Vision"
```

## 🧪 Testing

### Demo Script

Test the application with a sample PDF:

```bash
./demo.sh
```

This creates a 10-page test PDF and demonstrates real-time progress tracking.

### Installation Verification

```bash
./CHECK_DEB.sh
```

Verifies all components are correctly installed.

## 🐛 Troubleshooting

### Error: "pdftoppm: command not found"

```bash
sudo apt-get install poppler-utils
```

### Error: "No module named PyQt5"

```bash
sudo apt-get install python3-pyqt5
```

Or install via pip:
```bash
pip3 install PyQt5
```

### Application not appearing in menu

```bash
sudo update-desktop-database /usr/share/applications
```

### Permission denied errors

```bash
# Make scripts executable
chmod +x pdf_converter.py build_deb.sh manage.sh

# Or reinstall the package
sudo dpkg -i --force-all build/pdfvision_1.0.0.deb
```

### Slow conversion on large PDFs

- Close other applications to free up resources
- PDFs with complex graphics may take longer to convert
- 300 DPI resolution is intentionally high-quality

## 🗑️ Uninstallation

```bash
# Remove the package
sudo apt remove pdfvision

# Clean up system
sudo apt autoremove

# Remove build artifacts (if cloned from source)
cd pdf-vision
rm -rf build/
```

## 📊 Progress Tracking Example

For a 100-page PDF:

```
Starting conversion...
[0%] Analyzing PDF...
[10%] Converting... 10/100 pages
[20%] Converting... 20/100 pages
[50%] Converting... 50/100 pages
[100%] Conversion complete! ✓
```

Each page advances the progress bar by exactly 1%.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request with:

- Bug fixes
- Feature enhancements
- Documentation improvements
- Translation support

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 PDF Vision

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

## 🔗 Links

- **Repository**: https://github.com/javiertorron/pdf-vision
- **Issues**: https://github.com/javiertorron/pdf-vision/issues
- **Releases**: https://github.com/javiertorron/pdf-vision/releases
- **PyQt5**: https://www.riverbankcomputing.com/software/pyqt/
- **Poppler**: https://poppler.freedesktop.org/

## ⭐ Show Your Support

If you find this project useful, please consider:

- ⭐ Starring the repository
- 🐛 Reporting bugs and suggesting features
- 📢 Sharing with others
- 🤝 Contributing to the project

## 📧 Support

For issues, questions, or suggestions:

1. **Check existing issues** - Your question may already be answered
2. **Create an issue** - Describe your problem in detail
3. **Use discussions** - Ask questions and share ideas

## 🎯 Roadmap

Future enhancements planned:

- [ ] Support for additional output formats (JPEG, TIFF, WebP)
- [ ] Configurable resolution and quality settings
- [ ] Batch processing with drag-and-drop
- [ ] Conversion history and recent files
- [ ] Theme customization (dark/light mode)
- [ ] Multi-language support
- [ ] Advanced image processing (crop, rotate, enhance)

## 🙏 Acknowledgments

- Built with [PyQt5](https://www.riverbankcomputing.com/software/pyqt/)
- Uses [Poppler](https://poppler.freedesktop.org/) for PDF processing
- Icon inspired by modern design principles

---

**Made with ❤️ for the Linux community**

Last Updated: December 2025 | Version: 1.0.0

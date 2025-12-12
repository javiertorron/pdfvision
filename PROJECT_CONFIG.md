# Project Configuration

## Repository Information

**Project**: PDF Vision
**Description**: Professional desktop application for converting PDF documents to high-quality PNG images
**License**: MIT
**Language**: Python 3.6+
**Framework**: PyQt5
**Platform**: Ubuntu/Linux (Debian-based)

## GitHub Repository Setup

### Repository Settings

1. **General**
   - Repository type: Public
   - Default branch: main
   - Description: "A professional desktop application for converting PDF documents to high-quality PNG images on Ubuntu/Linux."
   - Website: https://github.com/javiertorron/pdf-vision

2. **Topics** (add these for discoverability)
   - pdf
   - converter
   - pyqt5
   - ubuntu
   - linux
   - python
   - desktop-application
   - image-processing
   - gui
   - pdf-to-image

3. **Social preview**
   - Use a screenshot of the application interface

### Protect Main Branch

1. Go to Settings > Branches
2. Add protection rule for `main` branch
3. Require pull request reviews: 1
4. Require status checks to pass
5. Require branches to be up to date before merging

### Release Configuration

Create releases using semantic versioning:
- v1.0.0 (major.minor.patch)
- Include compiled .deb file
- Add changelog to release notes
- Mark as pre-release for betas

### Package Configuration

The package is available as:
- Ubuntu .deb file: `pdfvision_1.0.0.deb`
- Source: Complete GitHub repository

## Version Management

### Current Version: 1.0.0

- **Release Date**: December 12, 2025
- **Status**: Stable
- **Features**:
  - PDF to PNG conversion at 300 DPI
  - Real-time progress tracking
  - PyQt5 GUI
  - System tray integration ready

### Version Numbering Scheme

- **Major** (X.0.0): Breaking changes, major features
- **Minor** (X.Y.0): New features, backward compatible
- **Patch** (X.Y.Z): Bug fixes, minor improvements

Example progression:
- 1.0.0 → 1.1.0 (new feature)
- 1.1.0 → 1.1.1 (bug fix)
- 1.1.1 → 2.0.0 (major feature, breaking change)

## Contributing Guidelines

See CONTRIBUTING.md for detailed information on:
- Code style (PEP 8)
- Commit message conventions
- Pull request process
- Issue reporting

## Installation Sources

Users can install from:

1. **Official Releases** (GitHub)
   ```bash
   wget https://github.com/javiertorron/pdf-vision/releases/download/v1.0.0/pdfvision_1.0.0.deb
   sudo dpkg -i pdfvision_1.0.0.deb
   ```

2. **Source Code**
   ```bash
   git clone https://github.com/javiertorron/pdf-vision.git
   cd pdf-vision
   ./build_deb.sh
   sudo dpkg -i build/pdfvision_1.0.0.deb
   ```

3. **Manual Installation**
   ```bash
   sudo apt-get install python3-pyqt5 poppler-utils
   python3 pdf_converter.py
   ```

## Documentation Structure

- **README.md**: Quick start and overview
- **CHANGELOG.md**: Version history and changes
- **CONTRIBUTING.md**: How to contribute
- **LICENSE**: MIT License
- **DISTRIBUTION.md**: Distribution guide
- **docs/**: Additional documentation (if created)

## Continuous Integration

Recommended CI/CD tools:
- GitHub Actions (recommended for GitHub projects)
- Travis CI
- CircleCI

Basic GitHub Actions workflow:
```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y python3-pyqt5 poppler-utils
      - name: Run tests
        run: python3 -m py_compile pdf_converter.py
```

## Packaging and Distribution

### DEB Package Details

- **Name**: pdfvision
- **Version**: 1.0.0
- **Architecture**: all
- **Size**: ~8.5 KB
- **Dependencies**: python3, python3-pyqt5, poppler-utils

### Building

```bash
./build_deb.sh
```

Package location: `build/pdfvision_1.0.0.deb`

### Testing Package

```bash
./CHECK_DEB.sh
```

## Future Releases

### v1.1.0 (Planned)
- Customizable output resolution
- Additional output formats (JPEG, TIFF)
- Batch processing improvements

### v2.0.0 (Long-term)
- WebP support
- Cloud storage integration
- Advanced image processing

## Support Channels

- **Issues**: GitHub Issues for bug reports and feature requests
- **Discussions**: GitHub Discussions for questions and ideas
- **Releases**: GitHub Releases for stable versions

## Community Standards

- Code of Conduct: Contributor Covenant
- Pull Request: Must pass tests and review
- Issues: Should be specific and include reproduction steps
- Documentation: Updated with code changes

## Media and Assets

- **Logo**: icon.svg (included in project)
- **Screenshots**: Store in `docs/screenshots/` (if created)
- **Demo**: demo.sh for live demonstration

## Contact and Maintenance

- **Repository Owner**: [Your GitHub Username]
- **Maintainer**: [Your Name/Email]
- **Status**: Actively Maintained

## Related Projects

- Poppler: https://poppler.freedesktop.org/
- PyQt5: https://www.riverbankcomputing.com/software/pyqt/
- Ubuntu: https://ubuntu.com/

---

Last Updated: December 2025

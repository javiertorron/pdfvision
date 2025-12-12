# Contributing to PDF Vision

Thank you for your interest in contributing to PDF Vision! We appreciate your help in making this project better.

## Code of Conduct

This project adheres to the Contributor Covenant code of conduct. By participating, you are expected to uphold this code.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps which reproduce the problem**
- **Provide specific examples to demonstrate the steps**
- **Describe the behavior you observed after following the steps**
- **Explain which behavior you expected to see instead and why**
- **Include screenshots or animated GIFs if possible**
- **Include your environment details** (Ubuntu version, Python version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a step-by-step description of the suggested enhancement**
- **Provide specific examples to demonstrate the steps**
- **Describe the current behavior and expected behavior**
- **Explain why this enhancement would be useful**
- **List some other applications where this enhancement exists, if applicable**

### Pull Requests

- Follow the Python style guide (PEP 8)
- Include appropriate test cases
- Update documentation accordingly
- End all files with a newline
- Avoid platform-specific code when possible

## Development Setup

1. Fork and clone the repository:
```bash
git clone https://github.com/javiertorron/pdf-vision.git
cd pdf-vision
```

2. Create a virtual environment (optional but recommended):
```bash
python3 -m venv venv
source venv/bin/activate
```

3. Install dependencies:
```bash
sudo apt-get install python3-pyqt5 poppler-utils
pip3 install -r requirements.txt
```

4. Run the application:
```bash
python3 pdf_converter.py
```

## Making Changes

1. Create a new branch for your changes:
```bash
git checkout -b feature/your-feature-name
```

2. Make your changes and commit them:
```bash
git commit -am 'Add some feature'
```

3. Push to the branch:
```bash
git push origin feature/your-feature-name
```

4. Create a Pull Request on GitHub

## Style Guide

### Python Code Style

- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/)
- Use 4 spaces for indentation
- Use descriptive variable and function names
- Add docstrings to classes and functions
- Use type hints when possible

Example:
```python
def convert_pdf_to_png(pdf_path: str, output_dir: str) -> bool:
    """
    Convert a PDF file to PNG images.
    
    Args:
        pdf_path: Path to the PDF file
        output_dir: Directory to save PNG files
        
    Returns:
        True if conversion was successful, False otherwise
    """
    pass
```

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

Example:
```
Add real-time progress tracking

- Detect PDF page count with pdfinfo
- Monitor file generation every 500ms
- Display percentage in status label
- Fixes #123
```

## Testing

Before submitting a pull request:

1. Test with multiple PDF files
2. Test on different Ubuntu versions if possible
3. Run the demo script to verify functionality:
```bash
./demo.sh
```

4. Check the installation:
```bash
./CHECK_DEB.sh
```

## Documentation

- Keep README.md up to date
- Update CHANGELOG.md with your changes
- Add comments for complex logic
- Include examples in docstrings

## Licensing

By contributing to PDF Vision, you agree that your contributions will be licensed under its MIT License.

## Questions?

Feel free to open an issue to ask questions about contributing.

Thank you for contributing to PDF Vision! 🎉

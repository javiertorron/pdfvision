# GitHub Configuration Files

## Issue Templates

### Bug Report (ISSUE_TEMPLATE/bug_report.md)

```markdown
---
name: Bug report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''

---

## Describe the bug
A clear and concise description of what the bug is.

## Steps to reproduce
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '...'
3. See error

## Expected behavior
A clear and concise description of what you expected to happen.

## Screenshots
If applicable, add screenshots to help explain your problem.

## Environment
- **OS**: (e.g., Ubuntu 20.04)
- **Python version**: (e.g., 3.8)
- **Installation method**: (DEB/Source/Manual)

## Additional context
Add any other context about the problem here.
```

### Feature Request (ISSUE_TEMPLATE/feature_request.md)

```markdown
---
name: Feature request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: enhancement
assignees: ''

---

## Is your feature request related to a problem?
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

## Describe the solution you'd like
A clear and concise description of what you want to happen.

## Describe alternatives you've considered
A clear and concise description of any alternative solutions or features you've considered.

## Additional context
Add any other context or screenshots about the feature request here.
```

## Pull Request Template

### PULL_REQUEST_TEMPLATE.md

```markdown
## Description
Please include a summary of the changes and related context.

## Type of change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [ ] Documentation update

## How has this been tested?
Please describe the tests that you ran to verify your changes.

## Testing checklist:
- [ ] New feature tested
- [ ] Existing tests pass
- [ ] Added new tests if applicable
- [ ] No new warnings generated

## Checklist:
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes

## Breaking changes
Describe any breaking changes here. If there are no breaking changes, type: None

## Related Issues
- Fixes #(issue number)
```

## Workflow Files

### .github/workflows/tests.yml

```yaml
name: Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        sudo apt-get update
        sudo apt-get install -y python3-pyqt5 poppler-utils
        pip install -r requirements.txt
    
    - name: Run application
      run: |
        python3 -m py_compile pdf_converter.py
        python3 -m py_compile pdfvision.py
```

## Community Profile

Add the following to make your repository more discoverable:

- **Description**: A professional desktop application for converting PDF documents to high-quality PNG images
- **Website**: https://github.com/javiertorron/pdf-vision
- **Topics**: pdf, converter, pyqt5, ubuntu, linux, python, desktop-application, image-processing
- **License**: MIT
- **Community**: Enable discussions

## Badges for README.md

Add these badges to your README:

```markdown
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.6+](https://img.shields.io/badge/python-3.6+-blue.svg)](https://www.python.org/downloads/)
[![Ubuntu 18.04+](https://img.shields.io/badge/ubuntu-18.04+-orange.svg)](https://ubuntu.com/)
[![GitHub Release](https://img.shields.io/github/v/release/javiertorron/pdf-vision.svg)](https://github.com/javiertorron/pdf-vision/releases)
[![GitHub Issues](https://img.shields.io/github/issues/javiertorron/pdf-vision.svg)](https://github.com/javiertorron/pdf-vision/issues)
[![GitHub Stars](https://img.shields.io/github/stars/javiertorron/pdf-vision.svg)](https://github.com/javiertorron/pdf-vision)
```

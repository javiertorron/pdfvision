# Changelog - PDF Vision v1.0.1

## v1.0.1 - Progress Bar Fix (2025-12-12)

### 🐛 Bug Fixes
- **Progress Bar Not Moving**: Fixed critical issue where progress bar remained at 0% during conversion
  - Root cause: Synchronous `monitor_progress()` was blocking the main conversion process
  - Solution: Implemented separate threading worker for real-time progress monitoring
  
### 🔧 Technical Improvements
- **Parallel Progress Monitoring**: Progress bar now updates in real-time via separate Python thread
  - Monitor checks destination folder every 500ms
  - Counts generated PNG files dynamically
  - Calculates progress as: `(PNG_files_count / total_pages) * 100`
  
- **Process Management**: Switched from QProcess to subprocess.Popen
  - Better control over process lifecycle
  - More reliable process termination on cancel
  
- **Threading Architecture**:
  - Main QThread: Handles PDF conversion with pdftoppm
  - Worker Thread: Monitors PNG file generation in parallel
  - Proper thread synchronization and cleanup

### 📊 Progress Tracking Details
- Progress starts at **0%** when conversion begins
- Advances **1% per page** as PNG files are created
- Reaches **100%** when all pages are converted
- Updates every **500ms** to reflect real-time conversion status
- Prevents premature 100% by capping at 99% during conversion

### ✅ Testing Performed
- Tested with multi-page PDFs (10+ pages)
- Progress bar advances smoothly during conversion
- Final percentage accurately reflects converted pages
- No blocking of GUI during conversion

### 📦 Package Information
- Version: **1.0.1**
- Size: 12KB
- Installation: `sudo dpkg -i pdfvision_1.0.1.deb`

### 🔄 Migration from 1.0.0
Simply install the new package:
```bash
sudo dpkg -i pdfvision_1.0.1.deb
```

The old version will be automatically replaced.

---

**Note**: This is a minor version bump focusing on bug fixes to the progress bar functionality.

#!/usr/bin/env python3
"""
Convertidor de PDF a PNG - Aplicación de Escritorio
Convierte PDFs a PNG usando pdftoppm con barra de progreso visual
"""

import sys
import subprocess
import os
import re
from pathlib import Path
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QLabel, QLineEdit, QProgressBar, QFileDialog, QMessageBox
)
from PyQt5.QtCore import Qt, QThread, pyqtSignal, QProcess
from PyQt5.QtGui import QFont, QIcon


class ConvertThread(QThread):
    """Thread para ejecutar la conversión sin bloquear la GUI"""
    progress_update = pyqtSignal(int)
    conversion_finished = pyqtSignal(bool, str)
    
    def __init__(self, pdf_path, output_dir):
        super().__init__()
        self.pdf_path = pdf_path
        self.output_dir = output_dir
        self.process = None
        self.should_stop = False
        
    def get_pdf_pages(self):
        """Obtener el número de páginas del PDF"""
        try:
            result = subprocess.run(
                ['pdfinfo', self.pdf_path],
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode == 0:
                for line in result.stdout.split('\n'):
                    if line.startswith('Pages:'):
                        pages_str = line.split(':')[1].strip()
                        return int(pages_str)
            return 0
        except (subprocess.CalledProcessError, FileNotFoundError, ValueError):
            return 0
    
    def monitor_progress(self, pdf_name, total_pages):
        """Monitorear el progreso de conversión contando archivos PNG generados"""
        from time import sleep
        
        output_dir_path = Path(self.output_dir)
        
        while not self.should_stop and self.process.state() == QProcess.Running:
            try:
                # Contar archivos PNG generados
                png_files = list(output_dir_path.glob(f"{pdf_name}-*.png"))
                pages_converted = len(png_files)
                
                if total_pages > 0:
                    progress = int((pages_converted / total_pages) * 100)
                    # Limitar a 99% mientras se está convirtiendo
                    progress = min(progress, 99)
                    self.progress_update.emit(progress)
                
                sleep(0.5)  # Verificar cada 500ms
            except Exception:
                sleep(0.5)
        
    def run(self):
        try:
            # Validar que el PDF existe
            if not os.path.exists(self.pdf_path):
                self.conversion_finished.emit(False, "El archivo PDF no existe")
                return
            
            # Validar que el directorio destino existe
            if not os.path.exists(self.output_dir):
                self.conversion_finished.emit(False, "El directorio de destino no existe")
                return
            
            # Obtener el nombre del archivo sin extensión
            pdf_name = Path(self.pdf_path).stem
            output_path = os.path.join(self.output_dir, pdf_name)
            
            # Obtener número de páginas del PDF
            total_pages = self.get_pdf_pages()
            
            if total_pages <= 0:
                self.conversion_finished.emit(False, "No se pudo determinar el número de páginas del PDF")
                return
            
            # Emitir progreso inicial
            self.progress_update.emit(0)
            
            # Ejecutar el comando
            self.process = QProcess()
            self.process.start('pdftoppm', [
                '-png',
                '-r', '300',
                self.pdf_path,
                output_path
            ])
            
            # Iniciar monitoreo de progreso en paralelo
            self.should_stop = False
            self.monitor_progress(pdf_name, total_pages)
            
            # Esperar a que se complete
            if not self.process.waitForFinished(-1):
                self.conversion_finished.emit(False, "Error durante la conversión")
                return
            
            self.should_stop = True
            
            # Verificar si la conversión fue exitosa
            if self.process.exitCode() != 0:
                error_msg = self.process.readAllStandardError().data().decode()
                self.conversion_finished.emit(False, f"Error: {error_msg}")
                return
            
            # Verificar archivos generados finales
            output_dir_path = Path(self.output_dir)
            png_files = list(output_dir_path.glob(f"{pdf_name}-*.png"))
            
            if png_files:
                self.progress_update.emit(100)
                msg = f"Conversión exitosa!\n\nPáginas convertidas: {len(png_files)}\nUbicación: {self.output_dir}"
                self.conversion_finished.emit(True, msg)
            else:
                self.conversion_finished.emit(False, "No se generaron archivos PNG")
                
        except Exception as e:
            self.conversion_finished.emit(False, f"Error: {str(e)}")
    
    def stop(self):
        """Detener el proceso"""
        self.should_stop = True
        if self.process and self.process.state() == QProcess.Running:
            self.process.kill()


class PDFConverterApp(QMainWindow):
    """Aplicación principal del convertidor de PDF a PNG"""
    
    def __init__(self):
        super().__init__()
        self.convert_thread = None
        self.init_ui()
        
    def init_ui(self):
        """Inicializar la interfaz de usuario"""
        self.setWindowTitle("Convertidor PDF a PNG")
        self.setGeometry(100, 100, 700, 400)
        
        # Widget central
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Layout principal
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(20, 20, 20, 20)
        
        # Título
        title = QLabel("Convertidor de PDF a PNG")
        title_font = QFont()
        title_font.setPointSize(14)
        title_font.setBold(True)
        title.setFont(title_font)
        main_layout.addWidget(title)
        
        # Sección: Seleccionar PDF
        main_layout.addSpacing(10)
        main_layout.addWidget(QLabel("1. Selecciona el archivo PDF:"))
        
        pdf_layout = QHBoxLayout()
        self.pdf_input = QLineEdit()
        self.pdf_input.setPlaceholderText("Ruta del archivo PDF...")
        self.pdf_input.setReadOnly(True)
        pdf_layout.addWidget(self.pdf_input)
        
        self.pdf_button = QPushButton("Examinar")
        self.pdf_button.clicked.connect(self.select_pdf)
        self.pdf_button.setMaximumWidth(100)
        pdf_layout.addWidget(self.pdf_button)
        main_layout.addLayout(pdf_layout)
        
        # Sección: Seleccionar directorio destino
        main_layout.addSpacing(10)
        main_layout.addWidget(QLabel("2. Selecciona el directorio destino:"))
        
        output_layout = QHBoxLayout()
        self.output_input = QLineEdit()
        self.output_input.setPlaceholderText("Ruta del directorio de destino...")
        self.output_input.setReadOnly(True)
        output_layout.addWidget(self.output_input)
        
        self.output_button = QPushButton("Examinar")
        self.output_button.clicked.connect(self.select_output_dir)
        self.output_button.setMaximumWidth(100)
        output_layout.addWidget(self.output_button)
        main_layout.addLayout(output_layout)
        
        # Barra de progreso
        main_layout.addSpacing(10)
        main_layout.addWidget(QLabel("Progreso:"))
        self.progress_bar = QProgressBar()
        self.progress_bar.setMinimum(0)
        self.progress_bar.setMaximum(100)
        self.progress_bar.setValue(0)
        main_layout.addWidget(self.progress_bar)
        
        # Estado
        self.status_label = QLabel("Listo para convertir")
        self.status_label.setStyleSheet("color: #666;")
        main_layout.addWidget(self.status_label)
        
        # Botones de acción
        main_layout.addSpacing(10)
        button_layout = QHBoxLayout()
        
        self.convert_button = QPushButton("Iniciar Conversión")
        self.convert_button.setMinimumHeight(40)
        self.convert_button.setStyleSheet("""
            QPushButton {
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                font-weight: bold;
                font-size: 12px;
            }
            QPushButton:hover {
                background-color: #45a049;
            }
            QPushButton:pressed {
                background-color: #3d8b40;
            }
            QPushButton:disabled {
                background-color: #cccccc;
            }
        """)
        self.convert_button.clicked.connect(self.start_conversion)
        button_layout.addWidget(self.convert_button)
        
        self.cancel_button = QPushButton("Cancelar")
        self.cancel_button.setMinimumHeight(40)
        self.cancel_button.setMaximumWidth(120)
        self.cancel_button.setStyleSheet("""
            QPushButton {
                background-color: #f44336;
                color: white;
                border: none;
                border-radius: 4px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #da190b;
            }
            QPushButton:pressed {
                background-color: #ba0000;
            }
            QPushButton:disabled {
                background-color: #cccccc;
            }
        """)
        self.cancel_button.clicked.connect(self.cancel_conversion)
        self.cancel_button.setEnabled(False)
        button_layout.addWidget(self.cancel_button)
        
        main_layout.addLayout(button_layout)
        main_layout.addStretch()
    
    def select_pdf(self):
        """Abrir diálogo para seleccionar archivo PDF"""
        file_path, _ = QFileDialog.getOpenFileName(
            self,
            "Seleccionar archivo PDF",
            os.path.expanduser("~"),
            "Archivos PDF (*.pdf);;Todos los archivos (*.*)"
        )
        
        if file_path:
            self.pdf_input.setText(file_path)
            self.update_status()
    
    def select_output_dir(self):
        """Abrir diálogo para seleccionar directorio destino"""
        dir_path = QFileDialog.getExistingDirectory(
            self,
            "Seleccionar directorio de destino",
            os.path.expanduser("~")
        )
        
        if dir_path:
            self.output_input.setText(dir_path)
            self.update_status()
    
    def update_status(self):
        """Actualizar estado y habilitar botón si es necesario"""
        pdf_path = self.pdf_input.text()
        output_dir = self.output_input.text()
        
        if pdf_path and output_dir:
            self.convert_button.setEnabled(True)
            self.status_label.setText("✓ Listo para convertir")
            self.status_label.setStyleSheet("color: #4CAF50;")
        else:
            self.convert_button.setEnabled(False)
            self.status_label.setText("✗ Selecciona PDF y directorio destino")
            self.status_label.setStyleSheet("color: #f44336;")
    
    def start_conversion(self):
        """Iniciar la conversión en un thread separado"""
        pdf_path = self.pdf_input.text()
        output_dir = self.output_input.text()
        
        # Validaciones
        if not pdf_path:
            QMessageBox.warning(self, "Error", "Por favor selecciona un archivo PDF")
            return
        
        if not output_dir:
            QMessageBox.warning(self, "Error", "Por favor selecciona un directorio destino")
            return
        
        # Verificar si pdftoppm está instalado
        try:
            subprocess.run(['which', 'pdftoppm'], check=True, capture_output=True)
        except subprocess.CalledProcessError:
            QMessageBox.critical(
                self,
                "Error",
                "pdftoppm no está instalado.\n\nInstala con:\nsudo apt-get install poppler-utils"
            )
            return
        
        # Verificar si pdfinfo está instalado
        try:
            subprocess.run(['which', 'pdfinfo'], check=True, capture_output=True)
        except subprocess.CalledProcessError:
            QMessageBox.critical(
                self,
                "Error",
                "pdfinfo no está instalado.\n\nInstala con:\nsudo apt-get install poppler-utils"
            )
            return
        
        # Deshabilitar controles
        self.pdf_button.setEnabled(False)
        self.output_button.setEnabled(False)
        self.convert_button.setEnabled(False)
        self.cancel_button.setEnabled(True)
        
        # Resetear barra de progreso
        self.progress_bar.setValue(0)
        self.status_label.setText("Analizando PDF...")
        self.status_label.setStyleSheet("color: #2196F3;")
        
        # Crear y iniciar thread
        self.convert_thread = ConvertThread(pdf_path, output_dir)
        self.convert_thread.progress_update.connect(self.update_progress)
        self.convert_thread.conversion_finished.connect(self.on_conversion_finished)
        self.convert_thread.start()
    
    def update_progress(self, value):
        """Actualizar barra de progreso"""
        self.progress_bar.setValue(value)
        
        # Actualizar etiqueta de estado con porcentaje
        if 0 <= value < 100:
            self.status_label.setText(f"Convirtiendo... {value}%")
            self.status_label.setStyleSheet("color: #2196F3;")
        elif value == 100:
            self.status_label.setText("Conversión completada...")
            self.status_label.setStyleSheet("color: #4CAF50;")
    
    def on_conversion_finished(self, success, message):
        """Manejar cuando la conversión termina"""
        self.pdf_button.setEnabled(True)
        self.output_button.setEnabled(True)
        self.cancel_button.setEnabled(False)
        
        if success:
            self.progress_bar.setValue(100)
            self.status_label.setText("✓ Conversión completada")
            self.status_label.setStyleSheet("color: #4CAF50;")
            QMessageBox.information(self, "Éxito", message)
            self.convert_button.setEnabled(True)
        else:
            self.progress_bar.setValue(0)
            self.status_label.setText("✗ Error en la conversión")
            self.status_label.setStyleSheet("color: #f44336;")
            QMessageBox.critical(self, "Error", message)
            self.convert_button.setEnabled(True)
    
    def cancel_conversion(self):
        """Cancelar la conversión en progreso"""
        if self.convert_thread and self.convert_thread.isRunning():
            self.convert_thread.stop()
            self.convert_thread.wait()
            
            self.pdf_button.setEnabled(True)
            self.output_button.setEnabled(True)
            self.convert_button.setEnabled(True)
            self.cancel_button.setEnabled(False)
            
            self.progress_bar.setValue(0)
            self.status_label.setText("✗ Conversión cancelada")
            self.status_label.setStyleSheet("color: #f44336;")


def main():
    app = QApplication(sys.argv)
    window = PDFConverterApp()
    window.show()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()

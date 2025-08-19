import sys, json
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QPushButton, QFileDialog,
    QVBoxLayout, QWidget, QMessageBox, QTreeWidget, QTreeWidgetItem,
    QTabWidget, QTextEdit
)
import luacparser


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("LuaC Decoder & Decompiler")
        self.resize(1000, 700)

        # Tabs
        self.tabs = QTabWidget()
        self.tree = QTreeWidget()
        self.tree.setHeaderLabels(["Key", "Value"])
        self.json_text = QTextEdit()
        self.json_text.setReadOnly(True)
        self.source_text = QTextEdit()  # editable Lua source

        self.tabs.addTab(self.tree, "Tree View")
        self.tabs.addTab(self.json_text, "Raw JSON")
        self.tabs.addTab(self.source_text, "Lua Source")

        # Buttons
        self.btn_open = QPushButton("Open .luac file")
        self.btn_open.clicked.connect(self.open_file)

        self.btn_export_json = QPushButton("Export JSON")
        self.btn_export_json.clicked.connect(self.export_json)
        self.btn_export_json.setEnabled(False)

        self.btn_export_lua = QPushButton("Export Lua Source")
        self.btn_export_lua.clicked.connect(self.export_lua)
        self.btn_export_lua.setEnabled(False)

        layout = QVBoxLayout()
        layout.addWidget(self.btn_open)
        layout.addWidget(self.btn_export_json)
        layout.addWidget(self.btn_export_lua)
        layout.addWidget(self.tabs)

        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)

        self.current_result = None
        self.current_source = None

    def open_file(self):
        file_name, _ = QFileDialog.getOpenFileName(
            self, "Open Lua Bytecode", "", "LuaC Files (*.luac);;All Files (*)"
        )
        if not file_name:
            return
        try:
            with open(file_name, "rb") as f:
                data = f.read()

            # Parse JSON AST
            result_json = luacparser.parse_luac(data)
            parsed = json.loads(result_json)
            self.current_result = parsed

            # Populate tree
            self.tree.clear()
            self.populate_tree(parsed, self.tree.invisibleRootItem())

            # Show JSON
            self.json_text.setPlainText(json.dumps(parsed, indent=4, ensure_ascii=False))

            # Decompile Lua source
            lua_code = luacparser.decompile_luac(data)
            self.current_source = lua_code
            self.source_text.setPlainText(lua_code)

            self.btn_export_json.setEnabled(True)
            self.btn_export_lua.setEnabled(True)

        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))

    def populate_tree(self, value, parent):
        """Đệ quy hiển thị JSON trong TreeView"""
        if isinstance(value, dict):
            for key, val in value.items():
                item = QTreeWidgetItem([str(key), ""])
                parent.addChild(item)
                self.populate_tree(val, item)
        elif isinstance(value, list):
            for i, val in enumerate(value):
                item = QTreeWidgetItem([f"[{i}]", ""])
                parent.addChild(item)
                self.populate_tree(val, item)
        else:
            item = QTreeWidgetItem(["", str(value)])
            parent.addChild(item)

    def export_json(self):
        if not self.current_result:
            return
        file_name, _ = QFileDialog.getSaveFileName(
            self, "Save JSON", "decoded.json", "JSON Files (*.json)"
        )
        if not file_name:
            return
        try:
            with open(file_name, "w", encoding="utf-8") as f:
                json.dump(self.current_result, f, indent=4, ensure_ascii=False)
            QMessageBox.information(self, "Success", f"Exported to {file_name}")
        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))

    def export_lua(self):
        lua_code = self.source_text.toPlainText()
        if not lua_code:
            return
        file_name, _ = QFileDialog.getSaveFileName(
            self, "Save Lua Source", "decoded.lua", "Lua Files (*.lua)"
        )
        if not file_name:
            return
        try:
            with open(file_name, "w", encoding="utf-8") as f:
                f.write(lua_code)
            QMessageBox.information(self, "Success", f"Exported to {file_name}")
        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())

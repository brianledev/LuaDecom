import sys, json, re
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QPushButton, QFileDialog,
    QVBoxLayout, QWidget, QMessageBox, QTreeWidget, QTreeWidgetItem,
    QTabWidget, QTextEdit
)
import luacparser


# --------- Refactorer ---------
class LuaRefactorer:
    def __init__(self, mapping_file="rename_map.json"):
        self.var_map = {}
        self.var_counter = {}
        self.rename_map = {}
        try:
            with open(mapping_file, "r", encoding="utf-8") as f:
                self.rename_map = json.load(f)
        except FileNotFoundError:
            self.rename_map = {}  # fallback nếu chưa có file

    def _get_new_name(self, old, hint="var"):
        if old not in self.var_map:
            idx = self.var_counter.get(hint, 0) + 1
            self.var_counter[hint] = idx
            self.var_map[old] = f"{hint}{idx}"
        return self.var_map[old]

    def refactor_code(self, code: str) -> str:
        lines = code.splitlines()
        new_lines = []

        for line in lines:
            # thay tên function API theo mapping file
            for k, v in self.rename_map.items():
                line = re.sub(rf"\b{k}\b", v, line)

            # function định nghĩa
            func_match = re.search(r"function\s+([a-zA-Z0-9_]+)\s*[:.]?\s*([a-zA-Z0-9_]*)?\((.*?)\)", line)
            if func_match:
                obj = func_match.group(1)
                method = func_match.group(2)
                params = func_match.group(3).split(",") if func_match.group(3).strip() else []

                new_params = []
                for i, p in enumerate(params):
                    p = p.strip()
                    if i == 0:
                        new_params.append("self")
                        self.var_map[p] = "self"
                    else:
                        new_params.append(f"arg{i}")
                        self.var_map[p] = f"arg{i}"

                params_str = ", ".join(new_params)
                if method:
                    newline = f"function {self._get_new_name(obj, 'obj')}:{method}({params_str})"
                else:
                    newline = f"function {self._get_new_name(obj, 'fn')}({params_str})"
                new_lines.append(newline)
                continue

            # assignment function obj.method = function(...)
            assign_func = re.search(r"(\w+)\.(\w+)\s*=\s*function\s*\((.*?)\)", line)
            if assign_func:
                obj = assign_func.group(1)
                method = assign_func.group(2)
                params = assign_func.group(3).split(",") if assign_func.group(3).strip() else []

                new_params = []
                for i, p in enumerate(params):
                    p = p.strip()
                    if i == 0:
                        new_params.append("self")
                        self.var_map[p] = "self"
                    else:
                        new_params.append(f"arg{i}")
                        self.var_map[p] = f"arg{i}"

                params_str = ", ".join(new_params)
                newline = f"{self._get_new_name(obj,'obj')}.{method} = function({params_str})"
                new_lines.append(newline)
                continue

            # refactor variables
            tokens = re.split(r"(\W+)", line)
            replaced = []
            for t in tokens:
                if re.match(r"r\d+_[a-z]+\d*", t):  # biến obfuscated
                    replaced.append(self._get_new_name(t, "var"))
                else:
                    replaced.append(self.var_map.get(t, t))
            new_lines.append("".join(replaced))

        return "\n".join(new_lines)


# --------- GUI ---------
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("LuaC Decoder & Refactor")
        self.resize(1100, 750)

        # Tabs
        self.tabs = QTabWidget()
        self.tree = QTreeWidget()
        self.tree.setHeaderLabels(["Key", "Value"])
        self.json_text = QTextEdit()
        self.json_text.setReadOnly(True)
        self.source_text = QTextEdit()        # decompiled
        self.refactored_text = QTextEdit()    # refactored

        self.tabs.addTab(self.tree, "Tree View")
        self.tabs.addTab(self.json_text, "Raw JSON")
        self.tabs.addTab(self.source_text, "Lua Source")
        self.tabs.addTab(self.refactored_text, "Refactored Lua")

        # Buttons
        self.btn_open = QPushButton("Open .luac file")
        self.btn_open.clicked.connect(self.open_file)

        self.btn_export_json = QPushButton("Export JSON")
        self.btn_export_json.clicked.connect(self.export_json)
        self.btn_export_json.setEnabled(False)

        self.btn_export_lua = QPushButton("Export Lua Source")
        self.btn_export_lua.clicked.connect(self.export_lua)
        self.btn_export_lua.setEnabled(False)

        self.btn_export_refactored = QPushButton("Export Refactored Lua")
        self.btn_export_refactored.clicked.connect(self.export_refactored)
        self.btn_export_refactored.setEnabled(False)

        layout = QVBoxLayout()
        layout.addWidget(self.btn_open)
        layout.addWidget(self.btn_export_json)
        layout.addWidget(self.btn_export_lua)
        layout.addWidget(self.btn_export_refactored)
        layout.addWidget(self.tabs)

        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)

        self.current_result = None
        self.current_source = None
        self.current_refactored = None

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

            # Decompiled Lua
            lua_code = luacparser.decompile_luac(data)
            self.current_source = lua_code
            self.source_text.setPlainText(lua_code)

            # Refactored Lua
            ref = LuaRefactorer()
            ref_code = ref.refactor_code(lua_code)
            self.current_refactored = ref_code
            self.refactored_text.setPlainText(ref_code)

            self.btn_export_json.setEnabled(True)
            self.btn_export_lua.setEnabled(True)
            self.btn_export_refactored.setEnabled(True)

        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))

    def populate_tree(self, value, parent):
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

    def export_refactored(self):
        ref_code = self.refactored_text.toPlainText()
        if not ref_code:
            return
        file_name, _ = QFileDialog.getSaveFileName(
            self, "Save Refactored Lua", "refactored.lua", "Lua Files (*.lua)"
        )
        if not file_name:
            return
        try:
            with open(file_name, "w", encoding="utf-8") as f:
                f.write(ref_code)
            QMessageBox.information(self, "Success", f"Exported to {file_name}")
        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())

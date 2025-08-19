# file: test_parse_improved.py

import sys, json, re, shutil
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QPushButton, QFileDialog,
    QVBoxLayout, QWidget, QMessageBox, QTreeWidget, QTreeWidgetItem,
    QTabWidget, QTextEdit, QHBoxLayout, QLabel, QLineEdit, QCheckBox,
    QSplitter, QGroupBox, QComboBox
)
import subprocess
import tempfile
import pathlib
import os
import luacparser


# --------- Enhanced Refactorer ---------
class LuaRefactorer:
    def __init__(self, mapping_file="rename_map.json", formatter: str = "auto"):
        self.var_map: dict[str, str] = {}
        self.var_counter: dict[str, int] = {}
        self.rename_map: dict[str, str] = {}
        self.function_map: dict[str, str] = {}
        self.local_scope: dict[str, str] = {}
        self.global_vars: set[str] = set()
        self.formatter = formatter  # "auto" | "stylua" | "luafmt" | "none"

        self.load_mapping(mapping_file)

    # ---------- Formatting pipeline ----------
    def format_lua(self, code: str) -> str:
        """
        Stable formatting pipeline:
        1) Normalize line breaks with heuristics to undo bad splits from decompiler.
        2) Run preferred formatter: stylua > luafmt (configurable).
        3) Fallback to code as-is on failure.
        """
        code = self._normalize_newlines(code)
        if self.formatter == "none":
            return code

        # Decide engine
        engine_order = []
        if self.formatter == "auto":
            if shutil.which("stylua"):
                engine_order = [self._format_with_stylua]
            elif shutil.which("luafmt"):
                engine_order = [self._format_with_luafmt]
        elif self.formatter == "stylua":
            engine_order = [self._format_with_stylua]
        elif self.formatter == "luafmt":
            engine_order = [self._format_with_luafmt]

        for fmt in engine_order:
            try:
                formatted = fmt(code)
                if formatted and isinstance(formatted, str):
                    return formatted
            except Exception:
                pass
        return code

    def _format_with_stylua(self, code: str) -> str:
        """Use stylua if present; preserves comments and does robust layout."""
        if not shutil.which("stylua"):
            raise RuntimeError("stylua not found")
        with tempfile.NamedTemporaryFile(delete=False, suffix=".lua", mode="w", encoding="utf-8") as tmp:
            tmp.write(code)
            tmp_path = tmp.name
        try:
            # --search-parent-directories makes it respect a project stylua.toml if available
            subprocess.run(["stylua", "--search-parent-directories", tmp_path], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            with open(tmp_path, "r", encoding="utf-8") as f:
                return f.read()
        finally:
            try:
                os.unlink(tmp_path)
            except Exception:
                pass

    def _format_with_luafmt(self, code: str) -> str:
        if not shutil.which("luafmt"):
            raise RuntimeError("luafmt not found")
        with tempfile.NamedTemporaryFile(delete=False, suffix=".lua", mode="w", encoding="utf-8") as tmp:
            tmp.write(code)
            tmp_path = tmp.name
        try:
            subprocess.run(["luafmt", "--write-mode", "replace", tmp_path], check=True)
            with open(tmp_path, "r", encoding="utf-8") as f:
                return f.read()
        finally:
            try:
                os.unlink(tmp_path)
            except Exception:
                pass

    # ---------- Heuristics to undo bad line breaks ----------
    def _normalize_newlines(self, code: str) -> str:
        # Always normalize line endings first
        code = code.replace("\r\n", "\n").replace("\r", "\n")

        # 1) Join broken method chains: obj.\nmethod(  or  obj:\nmethod(
        code = re.sub(r"([\w\]\)\}]+)\s*[\.:]\s*\n\s*([a-zA-Z_]\w*\s*\()", r"\1.\2", code)
        code = re.sub(r"([\w\]\)\}]+)\s*:\s*\n\s*([a-zA-Z_]\w*\s*\()", r"\1:\2", code)

        # 2) Join function call where string arg is put on a new line then closed
        code = re.sub(r"(\w+\([^\)]*?)\s*\n\s*(\"[^\"]*\"|'[^']*')\s*\n\s*\)", r"\1 \2)", code)

        # 3) Join if the previous line ends with an operator or concatenation
        binary_ops = [r"\+", r"-", r"\*", r"/", r"\^", r"\.\.", r"==", r"~=", r">=", r"<=", r">", r"<", r"and", r"or"]
        op_alt = "|".join(binary_ops)
        code = re.sub(rf"\s*\n\s*(?=({op_alt})\s*)", " ", code)  # operator at line start
        code = re.sub(rf"\s*({op_alt})\s*\n\s*", r" \1 ", code)   # operator at line end

        # 4) Join trailing comma or opening paren that was split before a simple token
        code = re.sub(r"\(\s*\n\s*([\w\{\'\"])", r"( \1", code)
        code = re.sub(r",\s*\n\s*", ", ", code)

        # 5) Avoid joining across Lua long strings [[...]] or comments
        # (minimal guard by not touching lines that start with --)
        lines = code.split("\n")
        cleaned = []
        open_block_comment = False
        for ln in lines:
            if ln.strip().startswith("--"):
                cleaned.append(ln)
                continue
            cleaned.append(ln)
        return "\n".join(cleaned)

    # ---------- Mapping & renaming ----------
    def load_mapping(self, mapping_file):
        try:
            with open(mapping_file, "r", encoding="utf-8") as f:
                self.rename_map = json.load(f)
        except FileNotFoundError:
            self.rename_map = {}
        except json.JSONDecodeError:
            self.rename_map = {}

    def _get_new_name(self, old, hint="var"):
        if old in self.var_map:
            return self.var_map[old]
        if self._is_meaningful_name(old):
            self.var_map[old] = old
            return old
        new_name = self._generate_better_name(old, hint)
        self.var_map[old] = new_name
        return new_name

    def _is_meaningful_name(self, name):
        if len(name) < 2:
            return False
        obfuscated_patterns = [
            r'^[a-z]\d*$', r'^r\d+_\w*$', r'^\w{1,2}\d+$', r'^[A-Z]{1,2}\d*$', r'^_+\w*$', r'.*\d{3,}.*'
        ]
        if any(re.match(p, name) for p in obfuscated_patterns):
            return False
        if name.lower() in ['tmp', 'temp', 'val', 'ret', 'res', 'var', 'obj', 'str', 'num']:
            return False
        return True

    def _generate_better_name(self, old, hint):
        if re.match(r'^r\d+_(\w+)', old):
            m = re.match(r'^r\d+_(\w+)', old)
            if m:
                hint = self._improve_hint(m.group(1))
        letter_meanings = {
            'a': 'array','b': 'button','c': 'config','d': 'data','e': 'event','f': 'function','g': 'game','h': 'handler','i': 'index','j': 'json','k': 'key','l': 'list','m': 'manager','n': 'number','o': 'object','p': 'player','q': 'query','r': 'result','s': 'string','t': 'table','u': 'user','v': 'value','w': 'widget','x': 'x_pos','y': 'y_pos','z': 'z_pos'
        }
        if len(old) <= 2 and old[0].lower() in letter_meanings:
            hint = letter_meanings[old[0].lower()]
        idx = self.var_counter.get(hint, 0) + 1
        self.var_counter[hint] = idx
        return hint if idx == 1 else f"{hint}_{idx}"

    def _improve_hint(self, hint):
        improvements = {
            'btn':'button','txt':'text','lbl':'label','lst':'list','img':'image','pic':'picture','win':'window','dlg':'dialog','pnl':'panel','frm':'form','tbl':'table','col':'column','row':'row','idx':'index','cnt':'count','len':'length','pos':'position','coord':'coordinate','rect':'rectangle','pt':'point','sz':'size','clr':'color','bg':'background','fg':'foreground','min':'minimum','max':'maximum','avg':'average','sum':'total','diff':'difference','calc':'calculate','proc':'process','init':'initialize','dest':'destination','src':'source','cfg':'config','pref':'preference','opt':'option','param':'parameter','arg':'argument','ret':'result','err':'error','msg':'message','info':'information','warn':'warning'
        }
        return improvements.get(hint.lower(), hint)

    def _detect_variable_context(self, line, var_name):
        contexts = {
            (r'for\s+' + re.escape(var_name) + r'\s*=', 'index'),
            (r'for\s+\w+\s*,\s*' + re.escape(var_name), 'value'),
            (r'while\s+.*' + re.escape(var_name), 'condition'),
            (r'if\s+.*' + re.escape(var_name), 'flag'),
            (r'function.*' + re.escape(var_name), 'callback'),
            (r'local\s+.*' + re.escape(var_name) + r'.*=.*{', 'table'),
            (r'local\s+.*' + re.escape(var_name) + r'.*=.*"', 'text'),
            (r'local\s+.*' + re.escape(var_name) + r'.*=.*\d', 'number'),
            (r'.*' + re.escape(var_name) + r'.*:.*\(', 'object'),
            (r'.*' + re.escape(var_name) + r'.*\[.*\]', 'array'),
        }
        for pattern, context in contexts:
            if re.search(pattern, line, re.IGNORECASE):
                return context
        return 'var'

    # ---------- Refactor main ----------
    def refactor_code(self, code: str) -> str:
        lines = code.splitlines()
        new_lines: list[str] = []
        self._analyze_code_structure(lines)
        for line_num, line in enumerate(lines):
            if not line.strip() or line.strip().startswith('--'):
                new_lines.append(line)
                continue
            refactored_line = line
            refactored_line = self._apply_api_mappings(refactored_line)
            refactored_line = self._refactor_functions(refactored_line, line_num)
            refactored_line = self._refactor_variables(refactored_line, line_num)
            refactored_line = self._refactor_table_operations(refactored_line)
            new_lines.append(refactored_line)

        result = "\n".join(new_lines)
        result = re.sub(r"%S", "%s", result)
        # Keep the specific string-arg call fixer as an extra safety net
        result = re.sub(r"(\w+\([^\)]*?)\s*\n\s*(\"[^\"]*\"|'[^']*')\s*\n\s*\)", r"\1 \2)", result)
        result = self.format_lua(result)
        return result

    def _analyze_code_structure(self, lines):
        for i, line in enumerate(lines):
            func_match = re.search(r'function\s+([a-zA-Z_]\w*)(?:[:.])?\w*\s*\((.*?)\)', line)
            if func_match:
                params = func_match.group(2).split(',') if func_match.group(2) else []
                for j, param in enumerate(params):
                    param = param.strip()
                    if param and not param == 'self':
                        context = 'param' if j > 0 else 'self_param'
                        self._get_new_name(param, context)

    def _apply_api_mappings(self, line):
        for old_api, new_api in self.rename_map.items():
            patterns = [
                (rf'\b{re.escape(old_api)}\s*\(', f'{new_api}('),
                (rf'(\w+[.:]){re.escape(old_api)}\s*\(', rf'\1{new_api}('),
                (rf'=\s*{re.escape(old_api)}\b', f'= {new_api}'),
                (rf'\b{re.escape(old_api)}\b(?!\w)', new_api),
            ]
            for pattern, replacement in patterns:
                line = re.sub(pattern, replacement, line)
        return line

    def _refactor_functions(self, line, line_num):
        func_match = re.search(r'function\s+([a-zA-Z_]\w*)([.:])?([a-zA-Z_]\w*)?\s*\((.*?)\)', line)
        if func_match:
            obj_name = func_match.group(1)
            separator = func_match.group(2) or ''
            method_name = func_match.group(3) or ''
            params = func_match.group(4) or ''
            new_obj_name = self._get_new_name(obj_name, 'class' if separator == ':' else 'module')
            new_params = self._refactor_parameters(params)
            if method_name:
                return re.sub(r'function\s+[a-zA-Z_]\w*[.:]?[a-zA-Z_]\w*\s*\([^)]*\)', f'function {new_obj_name}{separator}{method_name}({new_params})', line)
            else:
                return re.sub(r'function\s+[a-zA-Z_]\w*\s*\([^)]*\)', f'function {new_obj_name}({new_params})', line)
        anon_match = re.search(r'(\w+)\s*=\s*function\s*\((.*?)\)', line)
        if anon_match:
            var_name = anon_match.group(1)
            params = anon_match.group(2)
            new_var_name = self._get_new_name(var_name, 'handler')
            new_params = self._refactor_parameters(params)
            return re.sub(r'\w+\s*=\s*function\s*\([^)]*\)', f'{new_var_name} = function({new_params})', line)
        return line

    def _refactor_parameters(self, params_str):
        if not params_str.strip():
            return ''
        params = [p.strip() for p in params_str.split(',')]
        new_params = []
        for i, param in enumerate(params):
            if not param:
                continue
            if param in ('self', '...'):
                new_params.append(param)
            else:
                new_param = self._get_new_name(param, 'self_param' if i == 0 and 'self' not in params else f'arg_{i+1}')
                new_params.append(new_param)
        return ', '.join(new_params)

    def _refactor_variables(self, line, line_num):
        local_match = re.search(r'local\s+([^=]+)(?:\s*=.*)?', line)
        if local_match:
            vars_part = local_match.group(1).strip()
            var_names = [v.strip() for v in vars_part.split(',')]
            for var_name in var_names:
                if var_name and self._is_valid_identifier(var_name):
                    context = self._detect_variable_context(line, var_name)
                    new_name = self._get_new_name(var_name, context)
                    line = re.sub(rf'\b{re.escape(var_name)}\b', new_name, line)
        assign_match = re.search(r'^(\s*)([a-zA-Z_]\w*)\s*=(?!=)', line)
        if assign_match and not line.strip().startswith('local'):
            var_name = assign_match.group(2)
            if self._is_valid_identifier(var_name):
                context = self._detect_variable_context(line, var_name)
                new_name = self._get_new_name(var_name, context)
                line = re.sub(rf'\b{re.escape(var_name)}\b', new_name, line)
        words = re.findall(r'\b[a-zA-Z_]\w*\b', line)
        for word in set(words):
            if word in self.var_map and word != self.var_map[word]:
                line = re.sub(rf'\b{re.escape(word)}\b', self.var_map[word], line)
        return line

    def _refactor_table_operations(self, line):
        if '{' in line and '}' in line:
            table_match = re.search(r'(\w+)\s*=\s*{', line)
            if table_match:
                var_name = table_match.group(1)
                new_name = self._get_new_name(var_name, 'config')
                line = re.sub(rf'\b{re.escape(var_name)}\b', new_name, line)
        return line

    def _is_valid_identifier(self, name):
        if not name:
            return False
        lua_keywords = {'and','break','do','else','elseif','end','false','for','function','if','in','local','nil','not','or','repeat','return','then','true','until','while'}
        return re.match(r'^[a-zA-Z_]\w*$', name) and name not in lua_keywords

    def save_mapping_to_file(self, filename="generated_mapping.json"):
        mapping_data = {
            "api_mappings": self.rename_map,
            "variable_mappings": self.var_map,
            "statistics": {
                "total_variables_renamed": len(self.var_map),
                "api_functions_mapped": len(self.rename_map),
            },
        }
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(mapping_data, f, indent=4, ensure_ascii=False)
            return True
        except Exception:
            return False


# --------- Enhanced GUI ---------
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Advanced LuaC Decoder & Refactor Tool")
        self.resize(1400, 900)

        main_widget = QWidget()
        self.setCentralWidget(main_widget)
        layout = QVBoxLayout(main_widget)

        control_panel = self._create_control_panel()
        layout.addWidget(control_panel)

        splitter = QSplitter()
        layout.addWidget(splitter)

        left_tabs = QTabWidget()
        self.tree = QTreeWidget()
        self.tree.setHeaderLabels(["Key", "Value", "Type"])
        self.json_text = QTextEdit()
        self.json_text.setReadOnly(True)
        left_tabs.addTab(self.tree, "AST Tree")
        left_tabs.addTab(self.json_text, "Raw JSON")

        right_tabs = QTabWidget()
        self.source_text = QTextEdit(); self.source_text.setReadOnly(True)
        self.refactored_text = QTextEdit()
        self.mapping_text = QTextEdit()
        self.mapping_text.setPlainText('{'\
            '\n\t"Edt_SetTxt": "SetTextBox",'\
            '\n\t"Btn_Check": "CheckButton",'\
            '\n\t"Txt_SetTxt": "SetLabelText",'\
            '\n\t"Lst_SetCell": "SetListCell",'\
            '\n\t"Lst_SetLineData": "SetListLineData"\n}')

        right_tabs.addTab(self.source_text, "Original Lua")
        right_tabs.addTab(self.refactored_text, "Refactored Lua")
        right_tabs.addTab(self.mapping_text, "API Mapping (JSON)")

        splitter.addWidget(left_tabs)
        splitter.addWidget(right_tabs)
        splitter.setStretchFactor(0, 1)
        splitter.setStretchFactor(1, 2)

        self.current_result = None
        self.current_source = None
        self.current_refactored = None
        self.refactorer: LuaRefactorer | None = None

    def _create_control_panel(self):
        panel = QGroupBox("Control Panel")
        layout = QVBoxLayout(panel)

        # File ops
        file_row = QHBoxLayout()
        self.btn_open = QPushButton("📂 Open .luac File"); self.btn_open.clicked.connect(self.open_file)
        self.btn_load_mapping = QPushButton("📥 Load Mapping JSON"); self.btn_load_mapping.clicked.connect(self.load_mapping_file)
        self.btn_save_mapping = QPushButton("💾 Save Mapping"); self.btn_save_mapping.clicked.connect(self.save_mapping_file); self.btn_save_mapping.setEnabled(False)
        file_row.addWidget(self.btn_open); file_row.addWidget(self.btn_load_mapping); file_row.addWidget(self.btn_save_mapping)

        # Export ops
        export_row = QHBoxLayout()
        self.btn_export_json = QPushButton("📤 Export JSON"); self.btn_export_json.clicked.connect(self.export_json); self.btn_export_json.setEnabled(False)
        self.btn_export_lua = QPushButton("📤 Export Original Lua"); self.btn_export_lua.clicked.connect(self.export_lua); self.btn_export_lua.setEnabled(False)
        self.btn_export_refactored = QPushButton("🚀 Export Refactored Lua"); self.btn_export_refactored.clicked.connect(self.export_refactored); self.btn_export_refactored.setEnabled(False)
        export_row.addWidget(self.btn_export_json); export_row.addWidget(self.btn_export_lua); export_row.addWidget(self.btn_export_refactored)

        # Options
        options_row = QHBoxLayout()
        self.cb_preserve_comments = QCheckBox("Preserve Comments"); self.cb_preserve_comments.setChecked(True)
        self.cb_smart_naming = QCheckBox("Smart Variable Naming"); self.cb_smart_naming.setChecked(True)
        self.combo_formatter = QComboBox(); self.combo_formatter.addItems(["auto (stylua > luafmt)", "stylua", "luafmt", "none"])
        options_row.addWidget(QLabel("Formatter:")); options_row.addWidget(self.combo_formatter)
        options_row.addStretch(); options_row.addWidget(self.cb_preserve_comments); options_row.addWidget(self.cb_smart_naming)

        layout.addLayout(file_row); layout.addLayout(export_row); layout.addLayout(options_row)
        return panel

    def load_mapping_file(self):
        file_name, _ = QFileDialog.getOpenFileName(self, "Load Mapping File", "", "JSON Files (*.json);;All Files (*)")
        if file_name:
            try:
                with open(file_name, "r", encoding="utf-8") as f:
                    mapping_data = json.load(f)
                self.mapping_text.setPlainText(json.dumps(mapping_data, indent=4, ensure_ascii=False))
                QMessageBox.information(self, "Success", f"Mapping loaded from {file_name}")
            except Exception as e:
                QMessageBox.critical(self, "Error", f"Failed to load mapping: {str(e)}")

    def save_mapping_file(self):
        if not self.refactorer:
            return
        file_name, _ = QFileDialog.getSaveFileName(self, "Save Mapping File", "variable_mapping.json", "JSON Files (*.json)")
        if file_name:
            if self.refactorer.save_mapping_to_file(file_name):
                QMessageBox.information(self, "Success", f"Mapping saved to {file_name}")
            else:
                QMessageBox.critical(self, "Error", "Failed to save mapping")

    def open_file(self):
        file_name, _ = QFileDialog.getOpenFileName(self, "Open Lua Bytecode", "", "LuaC Files (*.luac);;All Files (*)")
        if not file_name:
            return
        try:
            with open(file_name, "rb") as f:
                data = f.read()
            result_json = luacparser.parse_luac(data)
            parsed = json.loads(result_json)
            self.current_result = parsed
            self.tree.clear(); self.populate_tree(parsed, self.tree.invisibleRootItem())
            self.json_text.setPlainText(json.dumps(parsed, indent=4, ensure_ascii=False))
            lua_code = luacparser.decompile_luac(data)
            self.current_source = lua_code
            self.source_text.setPlainText(lua_code)

            mapping_text = self.mapping_text.toPlainText()
            try:
                temp_mapping = json.loads(mapping_text)
            except Exception:
                temp_mapping = {}
            with open("temp_mapping.json", "w", encoding="utf-8") as f:
                json.dump(temp_mapping, f, indent=4, ensure_ascii=False)

            # Map combo -> refactorer.formatter
            choice = self.combo_formatter.currentText()
            if choice.startswith("auto"):
                fmt = "auto"
            elif choice == "stylua":
                fmt = "stylua"
            elif choice == "luafmt":
                fmt = "luafmt"
            else:
                fmt = "none"
            self.refactorer = LuaRefactorer("temp_mapping.json", formatter=fmt)

            refactored_code = self.refactorer.refactor_code(lua_code)
            self.current_refactored = refactored_code
            self.refactored_text.setPlainText(refactored_code)

            self.btn_export_json.setEnabled(True)
            self.btn_export_lua.setEnabled(True)
            self.btn_export_refactored.setEnabled(True)
            self.btn_save_mapping.setEnabled(True)

            stats_msg = f"""Processing Complete!

                Original Functions: {lua_code.count('function')}
                Variables Renamed: {len(self.refactorer.var_map)}
                API Functions Mapped: {len(self.refactorer.rename_map)}
                Lines of Code: {len(lua_code.splitlines())}"""
            QMessageBox.information(self, "Processing Complete", stats_msg)
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process file: {str(e)}")

    def populate_tree(self, value, parent, key="root"):
        if isinstance(value, dict):
            for k, v in value.items():
                item = QTreeWidgetItem([str(k), "", "dict"])
                parent.addChild(item)
                self.populate_tree(v, item, k)
        elif isinstance(value, list):
            for i, v in enumerate(value):
                item = QTreeWidgetItem([f"[{i}]", "", "list"])
                parent.addChild(item)
                self.populate_tree(v, item, f"{key}[{i}]")
        else:
            value_str = str(value)
            if len(value_str) > 100:
                value_str = value_str[:100] + "..."
            item = QTreeWidgetItem(["", value_str, type(value).__name__])
            parent.addChild(item)

    def export_json(self):
        if not self.current_result:
            return
        file_name, _ = QFileDialog.getSaveFileName(self, "Save JSON", "decoded.json", "JSON Files (*.json)")
        if file_name:
            try:
                with open(file_name, "w", encoding="utf-8") as f:
                    json.dump(self.current_result, f, indent=4, ensure_ascii=False)
                QMessageBox.information(self, "Success", f"JSON exported to {file_name}")
            except Exception as e:
                QMessageBox.critical(self, "Error", str(e))

    def export_lua(self):
        lua_code = self.source_text.toPlainText()
        if not lua_code:
            return
        file_name, _ = QFileDialog.getSaveFileName(self, "Save Original Lua", "original.lua", "Lua Files (*.lua)")
        if file_name:
            try:
                with open(file_name, "w", encoding="utf-8") as f:
                    f.write(lua_code.replace('\r\n','\n'))  # normalize EOL
                QMessageBox.information(self, "Success", f"Original Lua exported to {file_name}")
            except Exception as e:
                QMessageBox.critical(self, "Error", str(e))

    def export_refactored(self):
        ref_code = self.refactored_text.toPlainText()
        if not ref_code:
            return
        file_name, _ = QFileDialog.getSaveFileName(self, "Save Refactored Lua", "refactored.lua", "Lua Files (*.lua)")
        if file_name:
            try:
                with open(file_name, "w", encoding="utf-8") as f:
                    f.write(ref_code.replace('\r\n','\n'))  # normalize EOL
                QMessageBox.information(self, "Success", f"Refactored Lua exported to {file_name}")
            except Exception as e:
                QMessageBox.critical(self, "Error", str(e))


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())

import sys, json, re
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QPushButton, QFileDialog,
    QVBoxLayout, QWidget, QMessageBox, QTreeWidget, QTreeWidgetItem,
    QTabWidget, QTextEdit, QHBoxLayout, QLabel, QLineEdit, QCheckBox,
    QSplitter, QGroupBox
)
import luacparser
import subprocess
import tempfile
import pathlib


# --------- Enhanced Refactorer ---------
class LuaRefactorer:
    def __init__(self, mapping_file="rename_map.json"):
        self.var_map = {}
        self.var_counter = {}
        self.rename_map = {}
        self.function_map = {}
        self.local_scope = {}
        self.global_vars = set()
        
        # Load mapping file
        self.load_mapping(mapping_file)

    def format_lua(self, code: str) -> str:
        """
        Format code bằng CLI luafmt (yêu cầu: npm install -g lua-fmt).
        """
        import subprocess, tempfile, os
        with tempfile.NamedTemporaryFile(delete=False, suffix=".lua", mode="w", encoding="utf-8") as tmp:
            tmp.write(code)
            tmp_path = tmp.name
        try:
            subprocess.run(["luafmt", "--write-mode", "replace", tmp_path], check=True)
            with open(tmp_path, "r", encoding="utf-8") as f:
                return f.read()
        except Exception as e:
            print(f"[WARN] luafmt failed: {e}")
            return code
        finally:
            os.unlink(tmp_path)
    


    def load_mapping(self, mapping_file):
        """Load API mapping from JSON file"""
        try:
            with open(mapping_file, "r", encoding="utf-8") as f:
                self.rename_map = json.load(f)
            print(f"Loaded {len(self.rename_map)} mappings from {mapping_file}")
        except FileNotFoundError:
            print(f"Mapping file {mapping_file} not found, using empty mappings")
            self.rename_map = {}
        except json.JSONDecodeError as e:
            print(f"Error parsing JSON: {e}")
            self.rename_map = {}

    def _get_new_name(self, old, hint="var"):
        """Generate new meaningful variable names"""
        if old in self.var_map:
            return self.var_map[old]
            
        # Check if it's already a good name (don't rename good names)
        if self._is_meaningful_name(old):
            self.var_map[old] = old
            return old
        
        # Detect obfuscated patterns and generate better names
        new_name = self._generate_better_name(old, hint)
        self.var_map[old] = new_name
        return new_name

    def _is_meaningful_name(self, name):
        """Check if variable name is already meaningful"""
        if len(name) < 2:
            return False
        
        # Obfuscated patterns to rename
        obfuscated_patterns = [
            r'^[a-z]\d*$',           # a, b1, c2
            r'^r\d+_\w*$',           # r123_abc
            r'^\w{1,2}\d+$',         # ab1, x23
            r'^[A-Z]{1,2}\d*$',      # A, B1, AB
            r'^_+\w*$',              # __var, ___temp
            r'.*\d{3,}.*',           # var123456
        ]
        
        for pattern in obfuscated_patterns:
            if re.match(pattern, name):
                return False
                
        # Short meaningless names
        meaningless = ['tmp', 'temp', 'val', 'ret', 'res', 'var', 'obj', 'str', 'num']
        if name.lower() in meaningless:
            return False
            
        return True

    def _generate_better_name(self, old, hint):
        """Generate meaningful names based on context"""
        # Pattern-based name generation
        if re.match(r'^r\d+_(\w+)', old):
            match = re.match(r'^r\d+_(\w+)', old)
            if match:
                base = match.group(1)
                hint = self._improve_hint(base)
        
        # Single letter improvements
        letter_meanings = {
            'a': 'array', 'b': 'button', 'c': 'config', 'd': 'data', 'e': 'event',
            'f': 'function', 'g': 'game', 'h': 'handler', 'i': 'index', 'j': 'json',
            'k': 'key', 'l': 'list', 'm': 'manager', 'n': 'number', 'o': 'object',
            'p': 'player', 'q': 'query', 'r': 'result', 's': 'string', 't': 'table',
            'u': 'user', 'v': 'value', 'w': 'widget', 'x': 'x_pos', 'y': 'y_pos', 'z': 'z_pos'
        }
        
        if len(old) <= 2 and old[0].lower() in letter_meanings:
            hint = letter_meanings[old[0].lower()]
        
        # Generate unique name
        idx = self.var_counter.get(hint, 0) + 1
        self.var_counter[hint] = idx
        
        if idx == 1:
            return hint
        else:
            return f"{hint}_{idx}"

    def _improve_hint(self, hint):
        """Improve hint based on common abbreviations"""
        improvements = {
            'btn': 'button', 'txt': 'text', 'lbl': 'label', 'lst': 'list',
            'img': 'image', 'pic': 'picture', 'win': 'window', 'dlg': 'dialog',
            'pnl': 'panel', 'frm': 'form', 'tbl': 'table', 'col': 'column',
            'row': 'row', 'idx': 'index', 'cnt': 'count', 'len': 'length',
            'pos': 'position', 'coord': 'coordinate', 'rect': 'rectangle',
            'pt': 'point', 'sz': 'size', 'clr': 'color', 'bg': 'background',
            'fg': 'foreground', 'min': 'minimum', 'max': 'maximum',
            'avg': 'average', 'sum': 'total', 'diff': 'difference',
            'calc': 'calculate', 'proc': 'process', 'init': 'initialize',
            'dest': 'destination', 'src': 'source', 'cfg': 'config',
            'pref': 'preference', 'opt': 'option', 'param': 'parameter',
            'arg': 'argument', 'ret': 'result', 'err': 'error',
            'msg': 'message', 'info': 'information', 'warn': 'warning'
        }
        return improvements.get(hint.lower(), hint)

    def _detect_variable_context(self, line, var_name):
        """Detect variable context for better naming"""
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

    def refactor_code(self, code: str) -> str:
        """Main refactoring function with enhanced patterns"""
        lines = code.splitlines()
        new_lines = []
    
        # First pass: collect all variables and their contexts
        self._analyze_code_structure(lines)
    
        # Second pass: refactor
        for line_num, line in enumerate(lines):
            if not line.strip() or line.strip().startswith('--'):
                new_lines.append(line)
                continue

            refactored_line = line
        
            # Apply API mappings first (most important)
            refactored_line = self._apply_api_mappings(refactored_line)
        
            # Refactor function definitions
            refactored_line = self._refactor_functions(refactored_line, line_num)
        
            # Refactor variable assignments and usage
            refactored_line = self._refactor_variables(refactored_line, line_num)
        
            # Refactor table operations
            refactored_line = self._refactor_table_operations(refactored_line)
        
            new_lines.append(refactored_line)

        # --- Step 4: cleanup định dạng ---
        result = "\n".join(new_lines)

        # fix %S -> %s
        result = re.sub(r"%S", "%s", result)

        # fix xuống hàng vô lý trong chuỗi gọi hàm
        result = re.sub(
            r'(\w+\([^)]*?)\s*\n\s*("[^"]*")\s*\n\s*\)',
            r'\1\2)',
            result
        )

        # --- Format Lua bằng luafmt ---
        result = self.format_lua(result)

        return result


    def _analyze_code_structure(self, lines):
        """Analyze code structure to understand variable contexts"""
        for i, line in enumerate(lines):
            # Find function definitions to understand parameter contexts
            func_match = re.search(r'function\s+([a-zA-Z_]\w*)(?:[:.])?\w*\s*\((.*?)\)', line)
            if func_match:
                params = func_match.group(2).split(',') if func_match.group(2) else []
                for j, param in enumerate(params):
                    param = param.strip()
                    if param and not param == 'self':
                        context = 'param' if j > 0 else 'self_param'
                        self._get_new_name(param, context)

    def _apply_api_mappings(self, line):
        """Apply API function mappings"""
        for old_api, new_api in self.rename_map.items():
            # More precise matching to avoid partial replacements
            patterns = [
                # Function calls: old_api(...)
                (rf'\b{re.escape(old_api)}\s*\(', f'{new_api}('),
                # Method calls: obj.old_api(...) or obj:old_api(...)
                (rf'(\w+[.:]){re.escape(old_api)}\s*\(', rf'\1{new_api}('),
                # Assignment: var = old_api
                (rf'=\s*{re.escape(old_api)}\b', f'= {new_api}'),
                # Standalone references
                (rf'\b{re.escape(old_api)}\b(?!\w)', new_api),
            ]
            
            for pattern, replacement in patterns:
                line = re.sub(pattern, replacement, line)
                
        return line





    def _refactor_functions(self, line, line_num):
        """Enhanced function refactoring"""
        # Function definition: function obj:method(params) or function obj.method(params)
        func_match = re.search(r'function\s+([a-zA-Z_]\w*)([.:])?([a-zA-Z_]\w*)?\s*\((.*?)\)', line)
        if func_match:
            obj_name = func_match.group(1)
            separator = func_match.group(2) or ''
            method_name = func_match.group(3) or ''
            params = func_match.group(4) or ''
            
            new_obj_name = self._get_new_name(obj_name, 'class' if separator == ':' else 'module')
            new_params = self._refactor_parameters(params)
            
            if method_name:
                return re.sub(
                    r'function\s+[a-zA-Z_]\w*[.:]?[a-zA-Z_]\w*\s*\([^)]*\)',
                    f'function {new_obj_name}{separator}{method_name}({new_params})',
                    line
                )
            else:
                return re.sub(
                    r'function\s+[a-zA-Z_]\w*\s*\([^)]*\)',
                    f'function {new_obj_name}({new_params})',
                    line
                )

        # Anonymous function assignment: var = function(params)
        anon_match = re.search(r'(\w+)\s*=\s*function\s*\((.*?)\)', line)
        if anon_match:
            var_name = anon_match.group(1)
            params = anon_match.group(2)
            
            new_var_name = self._get_new_name(var_name, 'handler')
            new_params = self._refactor_parameters(params)
            
            return re.sub(
                r'\w+\s*=\s*function\s*\([^)]*\)',
                f'{new_var_name} = function({new_params})',
                line
            )

        return line

    def _refactor_parameters(self, params_str):
        """Refactor function parameters"""
        if not params_str.strip():
            return ''
            
        params = [p.strip() for p in params_str.split(',')]
        new_params = []
        
        for i, param in enumerate(params):
            if not param:
                continue
            if param == 'self' or param == '...':
                new_params.append(param)
            else:
                if i == 0 and 'self' not in params:
                    new_param = self._get_new_name(param, 'self_param')
                else:
                    new_param = self._get_new_name(param, f'arg_{i+1}')
                new_params.append(new_param)
        
        return ', '.join(new_params)

    def _refactor_variables(self, line, line_num):
        """Refactor variable names in the line"""
        # Local variable declarations: local var1, var2 = ...
        local_match = re.search(r'local\s+([^=]+)(?:\s*=.*)?', line)
        if local_match:
            vars_part = local_match.group(1).strip()
            var_names = [v.strip() for v in vars_part.split(',')]
            
            for var_name in var_names:
                if var_name and self._is_valid_identifier(var_name):
                    context = self._detect_variable_context(line, var_name)
                    new_name = self._get_new_name(var_name, context)
                    line = re.sub(rf'\b{re.escape(var_name)}\b', new_name, line)
        
        # Global variable assignments: var = ...
        assign_match = re.search(r'^(\s*)([a-zA-Z_]\w*)\s*=(?!=)', line)
        if assign_match and not line.strip().startswith('local'):
            var_name = assign_match.group(2)
            if self._is_valid_identifier(var_name):
                context = self._detect_variable_context(line, var_name)
                new_name = self._get_new_name(var_name, context)
                line = re.sub(rf'\b{re.escape(var_name)}\b', new_name, line)

        # Replace other variable references
        words = re.findall(r'\b[a-zA-Z_]\w*\b', line)
        for word in set(words):
            if word in self.var_map and word != self.var_map[word]:
                line = re.sub(rf'\b{re.escape(word)}\b', self.var_map[word], line)

        return line

    def _refactor_table_operations(self, line):
        """Refactor table operations and array access"""
        # Table constructor: {key = value, ...}
        if '{' in line and '}' in line:
            # Find table assignments
            table_match = re.search(r'(\w+)\s*=\s*{', line)
            if table_match:
                var_name = table_match.group(1)
                new_name = self._get_new_name(var_name, 'config')
                line = re.sub(rf'\b{re.escape(var_name)}\b', new_name, line)

        return line

    def _is_valid_identifier(self, name):
        """Check if string is a valid Lua identifier"""
        if not name:
            return False
        # Lua keywords to avoid
        lua_keywords = {
            'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for',
            'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat',
            'return', 'then', 'true', 'until', 'while'
        }
        return re.match(r'^[a-zA-Z_]\w*$', name) and name not in lua_keywords

    def save_mapping_to_file(self, filename="generated_mapping.json"):
        """Save the current variable mapping to a file"""
        mapping_data = {
            "api_mappings": self.rename_map,
            "variable_mappings": self.var_map,
            "statistics": {
                "total_variables_renamed": len(self.var_map),
                "api_functions_mapped": len(self.rename_map)
            }
        }
        
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(mapping_data, f, indent=4, ensure_ascii=False)
            return True
        except Exception as e:
            print(f"Error saving mapping: {e}")
            return False


# --------- Enhanced GUI ---------
class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Advanced LuaC Decoder & Refactor Tool")
        self.resize(1400, 900)

        # Main layout
        main_widget = QWidget()
        self.setCentralWidget(main_widget)
        layout = QVBoxLayout(main_widget)

        # Control panel
        control_panel = self._create_control_panel()
        layout.addWidget(control_panel)

        # Create splitter for better layout
        splitter = QSplitter()
        layout.addWidget(splitter)

        # Left side: Tree and JSON
        left_tabs = QTabWidget()
        self.tree = QTreeWidget()
        self.tree.setHeaderLabels(["Key", "Value", "Type"])
        self.json_text = QTextEdit()
        self.json_text.setReadOnly(True)
        left_tabs.addTab(self.tree, "AST Tree")
        left_tabs.addTab(self.json_text, "Raw JSON")

        # Right side: Source codes
        right_tabs = QTabWidget()
        self.source_text = QTextEdit()
        self.source_text.setReadOnly(True)
        self.refactored_text = QTextEdit()
        self.mapping_text = QTextEdit()
        self.mapping_text.setPlainText('{\n\t"Edt_SetTxt": "SetTextBox",\n\t"Btn_Check": "CheckButton",\n\t"Txt_SetTxt": "SetLabelText",\n\t"Lst_SetCell": "SetListCell",\n\t"Lst_SetLineData": "SetListLineData"\n}')
        
        right_tabs.addTab(self.source_text, "Original Lua")
        right_tabs.addTab(self.refactored_text, "Refactored Lua")
        right_tabs.addTab(self.mapping_text, "API Mapping (JSON)")

        splitter.addWidget(left_tabs)
        splitter.addWidget(right_tabs)
        splitter.setStretchFactor(0, 1)
        splitter.setStretchFactor(1, 2)

        # Data storage
        self.current_result = None
        self.current_source = None
        self.current_refactored = None
        self.refactorer = None

    def _create_control_panel(self):
        """Create the control panel with buttons and options"""
        panel = QGroupBox("Control Panel")
        layout = QVBoxLayout(panel)

        # File operations row
        file_row = QHBoxLayout()
        
        self.btn_open = QPushButton("📂 Open .luac File")
        self.btn_open.clicked.connect(self.open_file)
        
        self.btn_load_mapping = QPushButton("📥 Load Mapping JSON")
        self.btn_load_mapping.clicked.connect(self.load_mapping_file)
        
        self.btn_save_mapping = QPushButton("💾 Save Mapping")
        self.btn_save_mapping.clicked.connect(self.save_mapping_file)
        self.btn_save_mapping.setEnabled(False)

        file_row.addWidget(self.btn_open)
        file_row.addWidget(self.btn_load_mapping)
        file_row.addWidget(self.btn_save_mapping)

        # Export operations row
        export_row = QHBoxLayout()
        
        self.btn_export_json = QPushButton("📤 Export JSON")
        self.btn_export_json.clicked.connect(self.export_json)
        self.btn_export_json.setEnabled(False)

        self.btn_export_lua = QPushButton("📤 Export Original Lua")
        self.btn_export_lua.clicked.connect(self.export_lua)
        self.btn_export_lua.setEnabled(False)

        self.btn_export_refactored = QPushButton("🚀 Export Refactored Lua")
        self.btn_export_refactored.clicked.connect(self.export_refactored)
        self.btn_export_refactored.setEnabled(False)

        export_row.addWidget(self.btn_export_json)
        export_row.addWidget(self.btn_export_lua)
        export_row.addWidget(self.btn_export_refactored)

        # Options row
        options_row = QHBoxLayout()
        self.cb_preserve_comments = QCheckBox("Preserve Comments")
        self.cb_preserve_comments.setChecked(True)
        
        self.cb_smart_naming = QCheckBox("Smart Variable Naming")
        self.cb_smart_naming.setChecked(True)
        
        options_row.addWidget(self.cb_preserve_comments)
        options_row.addWidget(self.cb_smart_naming)
        options_row.addStretch()

        layout.addLayout(file_row)
        layout.addLayout(export_row)
        layout.addLayout(options_row)

        return panel

    def load_mapping_file(self):
        """Load custom mapping file"""
        file_name, _ = QFileDialog.getOpenFileName(
            self, "Load Mapping File", "", "JSON Files (*.json);;All Files (*)"
        )
        if file_name:
            try:
                with open(file_name, "r", encoding="utf-8") as f:
                    mapping_data = json.load(f)
                
                # Update the mapping text editor
                self.mapping_text.setPlainText(json.dumps(mapping_data, indent=4, ensure_ascii=False))
                QMessageBox.information(self, "Success", f"Mapping loaded from {file_name}")
                
            except Exception as e:
                QMessageBox.critical(self, "Error", f"Failed to load mapping: {str(e)}")

    def save_mapping_file(self):
        """Save current mappings"""
        if not self.refactorer:
            return
            
        file_name, _ = QFileDialog.getSaveFileName(
            self, "Save Mapping File", "variable_mapping.json", "JSON Files (*.json)"
        )
        if file_name:
            if self.refactorer.save_mapping_to_file(file_name):
                QMessageBox.information(self, "Success", f"Mapping saved to {file_name}")
            else:
                QMessageBox.critical(self, "Error", "Failed to save mapping")

    def open_file(self):
        """Open and process .luac file"""
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

            # Populate tree view
            self.tree.clear()
            self.populate_tree(parsed, self.tree.invisibleRootItem())

            # Show raw JSON
            self.json_text.setPlainText(json.dumps(parsed, indent=4, ensure_ascii=False))

            # Decompile to Lua
            lua_code = luacparser.decompile_luac(data)
            self.current_source = lua_code
            self.source_text.setPlainText(lua_code)

            # Create refactorer with current mapping
            mapping_text = self.mapping_text.toPlainText()
            temp_mapping = {}
            try:
                temp_mapping = json.loads(mapping_text)
            except:
                temp_mapping = {}

            # Save temp mapping to file and create refactorer
            with open("temp_mapping.json", "w", encoding="utf-8") as f:
                json.dump(temp_mapping, f, indent=4, ensure_ascii=False)
            
            self.refactorer = LuaRefactorer("temp_mapping.json")
            
            # Refactor the code
            refactored_code = self.refactorer.refactor_code(lua_code)
            self.current_refactored = refactored_code
            self.refactored_text.setPlainText(refactored_code)

            # Enable export buttons
            self.btn_export_json.setEnabled(True)
            self.btn_export_lua.setEnabled(True)
            self.btn_export_refactored.setEnabled(True)
            self.btn_save_mapping.setEnabled(True)

            # Show statistics
            stats_msg = f"""Processing Complete!
            
                Original Functions: {lua_code.count('function')}
                Variables Renamed: {len(self.refactorer.var_map)}
                API Functions Mapped: {len(self.refactorer.rename_map)}
                Lines of Code: {len(lua_code.splitlines())}"""
            
            QMessageBox.information(self, "Processing Complete", stats_msg)

        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process file: {str(e)}")

    def populate_tree(self, value, parent, key="root"):
        """Populate tree widget with AST data"""
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
        """Export JSON AST"""
        if not self.current_result:
            return
        file_name, _ = QFileDialog.getSaveFileName(
            self, "Save JSON", "decoded.json", "JSON Files (*.json)"
        )
        if file_name:
            try:
                with open(file_name, "w", encoding="utf-8") as f:
                    json.dump(self.current_result, f, indent=4, ensure_ascii=False)
                QMessageBox.information(self, "Success", f"JSON exported to {file_name}")
            except Exception as e:
                QMessageBox.critical(self, "Error", str(e))

    def export_lua(self):
        """Export original Lua source"""
        lua_code = self.source_text.toPlainText()
        if not lua_code:
            return
        file_name, _ = QFileDialog.getSaveFileName(
            self, "Save Original Lua", "original.lua", "Lua Files (*.lua)"
        )
        if file_name:
            try:
                with open(file_name, "w", encoding="utf-8") as f:
                    f.write(lua_code)
                QMessageBox.information(self, "Success", f"Original Lua exported to {file_name}")
            except Exception as e:
                QMessageBox.critical(self, "Error", str(e))

    def export_refactored(self):
        """Export refactored Lua source"""
        ref_code = self.refactored_text.toPlainText()
        if not ref_code:
            return
        file_name, _ = QFileDialog.getSaveFileName(
            self, "Save Refactored Lua", "refactored.lua", "Lua Files (*.lua)"
        )
        if file_name:
            try:
                with open(file_name, "w", encoding="utf-8") as f:
                    f.write(ref_code)
                QMessageBox.information(self, "Success", f"Refactored Lua exported to {file_name}")
            except Exception as e:
                QMessageBox.critical(self, "Error", str(e))


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())
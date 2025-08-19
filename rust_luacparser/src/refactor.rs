use serde_json::Value;

/// Refactor toàn bộ AST (JSON sau khi parse từ .luac)
pub fn refactor_lua(ast_json: &Value) -> String {
    let mut output = String::new();

    if let Some(protos) = ast_json.get("prototypes").and_then(|v| v.as_array()) {
        for (i, proto) in protos.iter().enumerate() {
            output.push_str(&refactor_proto(proto, i));
            output.push_str("\n");
        }
    }

    output
}

/// Refactor 1 function/proto
fn refactor_proto(proto: &Value, proto_index: usize) -> String {
    let mut code = String::new();

    // Tên function
    let func_name = format!("function_proto_{}", proto_index);

    // Lấy danh sách parameters
    let mut params: Vec<String> = Vec::new();
    if let Some(upvals) = proto.get("upvalue_names").and_then(|v| v.as_array()) {
        for (i, p) in upvals.iter().enumerate() {
            let new_name = rename_param(p.as_str().unwrap_or(&format!("param{}", i)), i);
            params.push(new_name);
        }
    }

    code.push_str(&format!("{} = function({})\n", func_name, params.join(", ")));

    // Duyệt qua instructions để gợi ý biến local
    if let Some(instructions) = proto.get("instructions").and_then(|v| v.as_array()) {
        for inst in instructions {
            let line = pretty_instruction(inst);
            code.push_str(&format!("    {}\n", line));
        }
    }

    code.push_str("end\n");
    code
}

/// Rename parameter theo rule
fn rename_param(param: &str, index: usize) -> String {
    if param.starts_with("r0") {
        if index == 0 {
            "self".to_string()
        } else {
            format!("arg{}", index)
        }
    } else {
        param.to_string()
    }
}

/// Pretty print 1 instruction từ JSON
fn pretty_instruction(inst: &Value) -> String {
    if let Some(op) = inst.get("op").and_then(|v| v.as_str()) {
        match op {
            "MOVE" => format!("-- move {}", inst),
            "LOADK" => format!("-- load const {}", inst),
            "CALL" => format!("-- call function {}", inst),
            "RETURN" => "return".to_string(),
            _ => format!("-- {}", op),
        }
    } else {
        "-- unknown".to_string()
    }
}

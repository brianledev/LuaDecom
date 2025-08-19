use pyo3::prelude::*;
use pyo3::wrap_pyfunction;
use luac_parser::parse;
use serde_json;
use luadec::LuaDecompiler;
pub mod refactor;

/// Parse LuaC và trả về JSON AST
#[pyfunction]
fn parse_luac(data: &[u8]) -> PyResult<String> {
    match parse(data) {
        Ok(result) => {
            let json = serde_json::to_string_pretty(&result)
                .unwrap_or_else(|_| "{}".to_string());
            Ok(json)
        }
        Err(e) => Err(pyo3::exceptions::PyValueError::new_err(
            format!("Parse error: {:?}", e),
        )),
    }
}

/// Decompile LuaC -> Lua source code
#[pyfunction]
fn decompile_luac(data: &[u8]) -> PyResult<String> {
    let mut decompiler = LuaDecompiler::new();
    match decompiler.decompile(data) {
        Ok(lua_code) => Ok(lua_code),
        Err(e) => Err(pyo3::exceptions::PyValueError::new_err(
            format!("Decompile error: {:?}", e),
        )),
    }
}

/// Module Python `luacparser`
#[pymodule]
fn luacparser(_py: Python, m: &Bound<'_, pyo3::types::PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(parse_luac, m)?)?;
    m.add_function(wrap_pyfunction!(decompile_luac, m)?)?;
    Ok(())
}

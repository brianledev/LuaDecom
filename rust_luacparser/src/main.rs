mod refactor;

use eframe::egui;
use serde_json::Value;
use std::fs;

struct AppState {
    tab: Tab,
    ast_json: Option<Value>,
    lua_source: Option<String>,
}

#[derive(PartialEq)]
enum Tab {
    Tree,
    Json,
    Lua,
    Refactored,
}

impl Default for AppState {
    fn default() -> Self {
        Self {
            tab: Tab::Tree,
            ast_json: None,
            lua_source: None,
        }
    }
}

impl eframe::App for AppState {
    fn update(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
        egui::TopBottomPanel::top("top_panel").show(ctx, |ui| {
            if ui.button("Open .luac file").clicked() {
                // TODO: gọi parser Rust (rust_luacparser) để lấy JSON
                let raw = fs::read_to_string("decoded.json").unwrap_or_default();
                self.ast_json = serde_json::from_str(&raw).ok();
                self.lua_source = fs::read_to_string("decoded.lua").ok();
            }

            if ui.button("Export Refactored Lua").clicked() {
                if let Some(ast_json) = &self.ast_json {
                    let refactored = refactor::refactor_lua(ast_json);
                    fs::write("refactored.lua", refactored).unwrap();
                }
            }
        });

        egui::CentralPanel::default().show(ctx, |ui| {
            ui.horizontal(|ui| {
                ui.selectable_value(&mut self.tab, Tab::Tree, "Tree View");
                ui.selectable_value(&mut self.tab, Tab::Json, "Raw JSON");
                ui.selectable_value(&mut self.tab, Tab::Lua, "Lua Source");
                ui.selectable_value(&mut self.tab, Tab::Refactored, "Refactored Lua");
            });

            match self.tab {
                Tab::Tree => {
                    ui.label("Tree view here...");
                }
                Tab::Json => {
                    if let Some(json) = &self.ast_json {
                        let mut s = serde_json::to_string_pretty(json).unwrap();
                        ui.text_edit_multiline(&mut s);
                    }
                }
                Tab::Lua => {
                    if let Some(src) = &self.lua_source {
                        let mut text = src.clone();
                        ui.text_edit_multiline(&mut text);
                    }
                }
                Tab::Refactored => {
                    if let Some(ast_json) = &self.ast_json {
                        let mut code = refactor::refactor_lua(ast_json);
                        ui.text_edit_multiline(&mut code);
                    }
                }
            }
        });
    }
}

fn main() -> eframe::Result<()> {
    let options = eframe::NativeOptions::default();
    eframe::run_native(
        "LuaC Decoder & Refactor",
        options,
        Box::new(|_cc| Box::new(AppState::default())),
    )
}

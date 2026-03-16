#!/usr/bin/env python3
"""
OpenClaw Config Backend API
提供读写 openclaw.json 的接口，运行在本地 127.0.0.1，无认证，仅允许本地访问。
"""
import json
import os
import sys
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
from pathlib import Path

app = Flask(__name__)
CORS(app)  # 允许前端跨域，本地开发用

CONFIG_PATH = Path.home() / ".openclaw" / "openclaw.json"
BACKUP_PATH = Path.home() / ".openclaw" / "openclaw.backup.json"

@app.route('/')
def index():
    return send_from_directory('.', 'index.html')

@app.route('/<path:filename>')
def static_file(filename):
    if os.path.exists(filename):
        return send_from_directory('.', filename)
    return '', 404

@app.route('/api/config', methods=['GET'])
def get_config():
    """读取 openclaw.json"""
    if not CONFIG_PATH.exists():
        return jsonify({"error": "Config file not found"}), 404
    try:
        with open(CONFIG_PATH, 'r') as f:
            data = json.load(f)
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/config', methods=['PUT'])
def save_config():
    """保存 openclaw.json"""
    if not request.is_json:
        return jsonify({"error": "Content-Type must be application/json"}), 400
    new_config = request.get_json()
    # 备份原文件
    if CONFIG_PATH.exists():
        import shutil
        shutil.copy2(CONFIG_PATH, BACKUP_PATH)
    # 写入新配置
    try:
        with open(CONFIG_PATH, 'w') as f:
            json.dump(new_config, f, indent=2, ensure_ascii=False)
        return jsonify({"success": True, "message": "Configuration saved"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/test', methods=['POST'])
def test_connection():
    """测试模型/频道连接（简化）"""
    data = request.get_json()
    # TODO: 实际做连通测试
    return jsonify({"success": True, "message": "Test endpoint works", "input": data})

@app.route('/api/backup', methods=['GET'])
def list_backups():
    """查看备份文件"""
    if BACKUP_PATH.exists():
        with open(BACKUP_PATH, 'r') as f:
            content = json.load(f)
        return jsonify({"backup": content})
    return jsonify({"backup": None})

@app.route('/api/restore', methods=['POST'])
def restore_backup():
    """恢复备份"""
    if not BACKUP_PATH.exists():
        return jsonify({"error": "No backup found"}), 404
    try:
        with open(BACKUP_PATH, 'r') as src, open(CONFIG_PATH, 'w') as dst:
            content = src.read()
            dst.write(content)
        return jsonify({"success": True, "message": "Restored from backup"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/system/info', methods=['GET'])
def system_info():
    """获取系统相关信息"""
    import platform
    return jsonify({
        "platform": platform.system(),
        "python": sys.version,
        "config_path": str(CONFIG_PATH),
        "exists": CONFIG_PATH.exists(),
        "size": CONFIG_PATH.stat().st_size if CONFIG_PATH.exists() else 0,
    })

if __name__ == '__main__':
    PORT = 18799
    print("🚀 OpenClaw 配置后端启动")
    print(f"📁 配置文件路径: {CONFIG_PATH}")
    print(f"🌐 访问 http://127.0.0.1:{PORT}")
    print("📌 按 Ctrl+C 退出")
    app.run(host='127.0.0.1', port=PORT, debug=False)

#!/bin/bash
set -e

echo "🦞 OpenClaw 配置助手部署脚本"
echo "==========================="

# 检查是否在 OpenClaw 环境
if [ ! -f "$HOME/.openclaw/openclaw.json" ]; then
    echo "❌ 未找到 OpenClaw 配置文件，请先初始化 OpenClaw。"
    exit 1
fi

# 安装依赖（如果需要）
if ! command -v python3 &> /dev/null; then
    echo "Python3 未安装，请先安装。"
    exit 1
fi

# 下载页面文件到本地
TARGET_DIR="$HOME/.openclaw/config-web"
mkdir -p "$TARGET_DIR"

curl -s -o "$TARGET_DIR/index.html" \
    "https://raw.githubusercontent.com/YOUR_GITHUB_USER/openclaw-config/main/index.html"

if [ $? -ne 0 ]; then
    echo "⚠️  下载失败，使用本地备份页面。"
    # 如果下载失败，写入一个静态页面（可替换为上面写的 openclaw-config.html）
    cat > "$TARGET_DIR/index.html" << 'EOF'
<!DOCTYPE html>
<html><head><title>OpenClaw Config</title></head><body>
<h1>配置页面</h1>
<p>请确保在 GitHub 发布页面内容。</p>
</body></html>
EOF
fi

# 可选：写一个简易服务器脚本
cat > "$TARGET_DIR/server.py" << 'EOF'
#!/usr/bin/env python3
import http.server
import socketserver
import os

PORT = 8080
DIR = os.path.dirname(os.path.abspath(__file__))

class ConfigHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIR, **kwargs)

with socketserver.TCPServer(("", PORT), ConfigHandler) as httpd:
    print(f"🦞 OpenClaw 配置助手运行在 http://127.0.0.1:{PORT}")
    print("按 Ctrl+C 退出")
    httpd.serve_forever()
EOF

chmod +x "$TARGET_DIR/server.py"

# 启动服务器的选项
if [ "$1" = "--serve" ]; then
    cd "$TARGET_DIR"
    python3 server.py
else
    echo ""
    echo "✅ 页面已安装到 $TARGET_DIR"
    echo ""
    echo "🧪 启动配置助手："
    echo "    cd $TARGET_DIR"
    echo "    python3 server.py"
    echo ""
    echo "🌐 然后在浏览器访问："
    echo "    http://127.0.0.1:8080"
    echo ""
    echo "📋 如需开机自启，可添加到 crontab 或 systemd。"
fi
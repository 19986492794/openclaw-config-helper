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

echo "📥 下载文件..."
curl -s -o "$TARGET_DIR/index.html" \
    "https://raw.githubusercontent.com/19986492794/openclaw-config-helper/main/index.html"
curl -s -o "$TARGET_DIR/backend.py" \
    "https://raw.githubusercontent.com/19986492794/openclaw-config-helper/main/backend.py"
curl -s -o "$TARGET_DIR/requirements.txt" \
    "https://raw.githubusercontent.com/19986492794/openclaw-config-helper/main/requirements.txt"

if [ $? -ne 0 ]; then
    echo "⚠️  下载失败，请检查网络或 GitHub 可访问性。"
    exit 1
fi

# 安装 Python 依赖
if [ -f "$TARGET_DIR/requirements.txt" ]; then
    echo "🔧 安装 Python 依赖..."
    pip3 install -r "$TARGET_DIR/requirements.txt" 2>/dev/null || \
    pip install -r "$TARGET_DIR/requirements.txt" 2>/dev/null || \
    echo "⚠️  依赖安装失败，请手动执行：pip install -r $TARGET_DIR/requirements.txt"
fi

echo ""
echo "✅ 安装完成！"
echo ""
echo "🧪 启动配置助手："
echo "    cd $TARGET_DIR"
echo "    python3 backend.py"
echo ""
echo "🌐 然后在浏览器访问："
echo "    http://127.0.0.1:18799"
echo ""
echo "📌 按 Ctrl+C 停止服务。"
echo ""
echo "💡 如需开机自启，可添加到 crontab 或 systemd。"

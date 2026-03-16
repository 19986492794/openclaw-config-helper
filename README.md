# 🦞 OpenClaw 配置助手

一个本地 Web 配置工具，用于编辑 OpenClaw 的配置文件 `openclaw.json`。

## 功能特点

- 可视化编辑模型、频道、技能
- 实时保存，自动备份
- 本地运行，无需外网
- 支持移动端访问
- 一键恢复备份

## 快速开始

### 1. 一键安装（在有 OpenClaw 的环境中）

```bash
curl -s https://raw.githubusercontent.com/YOUR_USER/openclaw-config/main/install.sh | bash
```

### 2. 启动配置服务

```bash
cd ~/.openclaw/config-web
python3 backend.py
```

### 3. 访问配置页面

浏览器打开 [http://127.0.0.1:5000](http://127.0.0.1:5000)

## 本地手动部署

1. 下载所有文件到本地一个目录
2. 安装依赖: `pip install -r requirements.txt`
3. 运行: `python3 backend.py`
4. 访问: http://127.0.0.1:5000

## 文件说明

- `index.html` — 前端页面
- `backend.py` — Flask 后端 API
- `install.sh` — 快速安装脚本
- `requirements.txt` — Python 依赖
- `demo-openclaw.json` — 示例配置

## 注意事项

- 请确保本地已安装 OpenClaw 并存在 `~/.openclaw/openclaw.json`
- 仅在 localhost 运行，不开放外部端口
- 配置保存前会自动备份原文件

## 开发

欢迎提交 Issue 和 Pull Request。

## 许可证

MIT

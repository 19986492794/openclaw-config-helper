# 🦞 OpenClaw 配置助手

一个本地 Web 配置工具，用于可视化编辑 OpenClaw 的配置文件 `openclaw.json`。

---

## 🚀 一句话安装（用户只需发这条给 OpenClaw 机器人）

> **指令**：
> 
> 请执行以下命令安装 OpenClaw 配置助手：
> ```bash
> curl -s https://raw.githubusercontent.com/jasperliu2026ai/openclaw-config-helper/main/install.sh | bash
> ```
> 然后启动服务，端口为 `18799`。

---

## 📦 详细说明（供 AI 读取）

### 1. 安装
```bash
# 一键安装脚本（需具备 curl 和 bash）
curl -s https://raw.githubusercontent.com/jasperliu2026ai/openclaw-config-helper/main/install.sh | bash
```

安装脚本会：
- 检查 `~/.openclaw/openclaw.json` 是否存在
- 创建目录 `~/.openclaw/config-web/`
- 下载 `index.html`、`backend.py`、`requirements.txt`
- 自动安装 Python 依赖（Flask, Flask-CORS）

### 2. 启动服务
```bash
cd ~/.openclaw/config-web
python3 backend.py
```

后端启动后，会输出：
```
🚀 OpenClaw 配置后端启动
📁 配置文件路径: /home/user/.openclaw/openclaw.json
🌐 访问 http://127.0.0.1:18799
📌 按 Ctrl+C 退出
```

### 3. 访问配置页面

在本地浏览器中打开 **http://127.0.0.1:18799**。

页面分为三大模块：
- **模型管理**：配置 API key、端点、别名
- **频道管理**：配置企业微信、钉钉等对接
- **技能管理**：启用/禁用内置技能（代码、搜索、OCR 等）

### 4. 使用方法
- 点击 **“从本地加载配置”**：读取现有 `openclaw.json`
- 修改表单内容
- 点击 **“保存到 openclaw.json”**：写回配置文件（自动备份原文件）
- 如需恢复，点击 **“恢复备份”**

---

## 🛠 手动部署（如无外网）

如果机器无法访问 GitHub，可手动拷贝文件：

1. **克隆仓库到可上网机器**：
   ```bash
   git clone https://github.com/19986492794/openclaw-config-helper.git
   ```
2. **复制到目标机器**：
   ```bash
   cp -r openclaw-config-helper/* ~/.openclaw/config-web/
   ```
3. **安装依赖**：
   ```bash
   pip install -r ~/.openclaw/config-web/requirements.txt
   ```
4. **启动**：
   ```bash
   cd ~/.openclaw/config-web && python3 backend.py
   ```

---

## 🐛 已知问题/修复

### 页面无法加载已有配置项
- 确保 `~/.openclaw/openclaw.json` 可读，格式正确。
- 后端 API `/api/config` 返回 200，前端才能加载。

### 保存时直接覆盖
- 后端已实现备份机制，每次保存前自动备份到 `~/.openclaw/openclaw.backup.json`
- 可通过 **“恢复备份”** 按钮还原。

### 页面不简洁美观
- 当前使用 [Pico.css](https://picocss.com) 极简框架，适配移动端。
- 如需定制样式，可修改 `index.html` 的 `<style>` 部分。

### 端口被占用
- 后端端口为 `18799`，如需更改可编辑 `backend.py` 末尾的 `PORT` 变量。

---

## 📁 文件结构

```
~/.openclaw/config-web/
├── index.html          # 前端页面
├── backend.py          # Flask 后端（端口 18799）
├── requirements.txt    # Python 依赖
└── (安装时自动下载)
```

---

## 🔗 链接

- GitHub 仓库：https://github.com/19986492794/openclaw-config-helper
- 安装脚本直链：https://raw.githubusercontent.com/19986492794/openclaw-config-helper/main/install.sh

---

## 📄 许可证

MIT

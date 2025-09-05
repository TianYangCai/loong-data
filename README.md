# Loong Data

## 快速开始

### 环境准备

1. 创建虚拟环境：
```bash
uv venv
```

2. 激活虚拟环境：
```bash
source .venv/bin/activate
```

3. 安装项目依赖：
```bash
uv sync --group dev
```

### 安装 WebUI 组件

WebUI 组件提供了可视化界面，支持通过浏览器与 AI 代理进行交互。

#### 方法一：一键构建和安装（推荐）

使用提供的 Makefile 进行一键构建和安装：

```bash
# 构建并安装前端（假设前端依赖已安装）
make build-all

# 或者分步执行
make build-frontend    # 重新构建前端项目（跳过 npm install）
make install-frontend  # 安装 wheel 包
```

#### 方法二：安装预构建的 wheel 文件

如果已有预构建的 wheel 文件，可以直接安装：

```bash
uv pip install utu/ui/frontend/build/utu_agent_ui-0.1.6-py3-none-any.whl
```

#### 方法三：手动编译前端项目

如果需要自定义前端界面，可以按照以下步骤手动编译：

1. 确保前端依赖已安装（首次运行需要执行）：
```bash
cd utu/ui/frontend
npm install  # 仅首次运行需要
```

2. 编译前端项目：
```bash
# 安装 Python 构建工具
uv pip install build

# 运行构建脚本
bash ./build.sh
```

3. 安装生成的 wheel 文件：
```bash
uv pip install utu/ui/frontend/build/utu_agent_ui-0.1.6-py3-none-any.whl
```

编译完成后，wheel 文件将保存在 `utu/ui/frontend/build/` 目录中。

#### 其他有用的 Makefile 命令

```bash
make help              # 显示帮助信息
make clean-frontend    # 清理前端构建产物
make check-tools       # 检查必要的工具是否已安装
```

### 运行示例

进入后端目录并运行 WebUI：

```bash
cd backend
python main.py
```
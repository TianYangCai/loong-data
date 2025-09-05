# Makefile for Loong Data Project

.PHONY: help build-frontend install-frontend clean-frontend build-all

# 默认目标
help:
	@echo "Available targets:"
	@echo "  build-frontend    - Rebuild frontend project and create wheel package (assumes npm install already done)"
	@echo "  install-frontend  - Install the built frontend wheel package"
	@echo "  clean-frontend    - Clean frontend build artifacts"
	@echo "  build-all         - Build and install frontend in one command"
	@echo "  help              - Show this help message"

# 构建前端项目
build-frontend:
	@echo "Building frontend project..."
	@cd utu/ui/frontend && \
		echo "Installing Python build tools..." && \
		uv pip install build && \
		echo "Building frontend..." && \
		bash ./build.sh && \
		echo "Frontend build completed successfully!"

# 安装前端 wheel 包
install-frontend:
	@echo "Installing frontend wheel package..."
	@if [ -f "utu/ui/frontend/build/utu_agent_ui-0.1.6-py3-none-any.whl" ]; then \
		uv pip install utu/ui/frontend/build/utu_agent_ui-0.1.6-py3-none-any.whl && \
		echo "Frontend wheel package installed successfully!"; \
	else \
		echo "Error: Wheel file not found. Please run 'make build-frontend' first."; \
		exit 1; \
	fi

# 清理前端构建产物
clean-frontend:
	@echo "Cleaning frontend build artifacts..."
	@cd utu/ui/frontend && \
		rm -rf dist build utu_agent_ui.egg-info && \
		rm -f package-lock.json && \
		echo "Frontend build artifacts cleaned."

# 一键构建并安装前端
build-all: clean-frontend build-frontend install-frontend
	@source .venv/bin/activate && \
	@echo "Frontend build and installation completed successfully!"

# 确保必要的工具存在
check-tools:
	@echo "Checking required tools..."
	@command -v node >/dev/null 2>&1 || { echo "Error: Node.js is not installed. Please install Node.js first."; exit 1; }
	@command -v npm >/dev/null 2>&1 || { echo "Error: npm is not installed. Please install npm first."; exit 1; }
	@command -v uv >/dev/null 2>&1 || { echo "Error: uv is not installed. Please install uv first."; exit 1; }
	@echo "All required tools are available."

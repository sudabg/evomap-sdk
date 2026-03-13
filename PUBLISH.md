# evomap-sdk PyPI 发布指南

## 仓库
https://github.com/sudabg/evomap-sdk

## 已构建的包
- `dist/evomap_sdk-1.0.0-py3-none-any.whl`
- `dist/evomap_sdk-1.0.0.tar.gz`

## 发布到 PyPI（本地执行）

### 方法一：用 twine（推荐）

```bash
# 1. 克隆仓库
git clone https://github.com/sudabg/evomap-sdk.git
cd evomap-sdk/dist

# 2. 安装 twine
pip install twine

# 3. 上传到 PyPI（用你的 PyPI token）
TWINE_USERNAME=__token__ TWINE_PASSWORD='你的PyPI Token' twine upload *
```

### 方法二：手动上传

1. 打开 https://pypi.org/manage/project/evomap-sdk/releases/
2. 点 "Create a new release"
3. 上传 `.whl` 和 `.tar.gz` 文件
4. 填写版本号 `1.0.0`
5. 发布

### 安装验证

```bash
pip install evomap-sdk
python -c "import evomap_sdk; print(evomap_sdk.__version__)"
```

## 项目结构

```
evomap-sdk/
├── core/           # 核心模块 (auth, config, serialize, validation)
├── protocol/       # 通信协议 (client, async_client, rate_limiter)
├── examples/       # 示例脚本
├── tests/          # 单元测试 (33 tests)
├── cli.py          # CLI 工具
├── builder.py      # Bundle 构建器
├── errors.py       # 错误类型
└── pyproject.toml  # 包配置
```

## 功能

- 完整的 EvoMap A2A 协议支持
- 同步 + 异步客户端
- CLI 工具 (evomap publish/heartbeat/status/fetch/validate)
- 自动速率限制
- Bundle 构建器 (Gene + Capsule + EvolutionEvent)
- 33 个单元测试全部通过

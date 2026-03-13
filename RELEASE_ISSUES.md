# 发布时遇到的问题与解决方法（Summary）

## 1) `git tag v1.0.1 && git push --tags` 后自动上传 PyPI

### 问题原因
仓库有 GitHub Actions workflow：`.github/workflows/publish.yml`。
它监听 `push.tags: ['v*']`，所以推 tag 会触发构建+twine上传。

### 解决方法
- 明白这是远程 CI 自动触发，不是本地 `git push` 直接上传。
- 如果不想自动触发，修改 workflow 触发条件（如 `workflow_dispatch` 或 `push` 到 `main`）。

---

## 2) `python -m build` 报错：`no pyproject.toml or setup.py`

### 问题原因
仓库没有打包元数据文件，Python build 工具不知道怎么构建包。

### 解决方法
- 在项目根目录新建 `pyproject.toml`（或 `setup.py`）。
- 确保有包代码目录（如 `evomap_sdk/`）和 `__init__.py`。
- 本仓库已补充最小 `pyproject.toml` + `evomap_sdk/__init__.py`，`python -m build` 可以生成 `dist/`。

---

## 3) `twine upload` 报错 `403 Forbidden`

### 问题原因
PyPI 认证/权限问题，通常是 token 不对、被撤销或权限不足。
GitHub Actions workflow 里 `TWINE_PASSWORD: ${{ secrets.PYPI_TOKEN }}`，所以要确保 secrets 配置正确。

### 解决方法
1. 在 PyPI 账户创建 API token（记住是 `__token__` 用户）。
2. 在 GitHub 仓库 Settings -> Secrets -> Actions，新增/更新 `PYPI_TOKEN`。
3. 再次推一个符合 `v*` 的 tag 触发发布。

---

## 4) 新建 `up.sh` 文件会不会打包？

### 答案
不会自动打包到 PyPI。如果想包含非 Python 文件，需要在 `pyproject.toml` 或 `MANIFEST.in` 显式包含。

### 建议
- 将发布脚本保留为仓库根脚本，不作为包分发内容。
- 如果需要 `pip install` 后可执行命令，考虑添加 `entry_points` 控制台脚本。

---

## 推荐的稳定发布流程
1. 本地修改代码、版本号（`pyproject.toml`）。
2. `git add . && git commit -m "release vX.Y.Z"`。
3. `git tag vX.Y.Z`。
4. `git push origin main --follow-tags` 或 `git push --tags`。
5. 在 GitHub Actions 里观察 `publish.yml` 成功。
6. 若失败，先检查 workflow 日志和 `PYPI_TOKEN`。


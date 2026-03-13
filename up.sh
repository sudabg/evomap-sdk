#!/bin/bash
set -e

# 从 pyproject.toml 读取版本号
VERSION=$(grep '^version' pyproject.toml | sed 's/.*"\(.*\)"//')
TAG="v$VERSION"

echo "当前版本: $VERSION"
echo "打标签: $TAG"

git tag "$TAG"
git push --tags

echo "✅ 已推送 $TAG，GitHub Actions 将自动发布到 PyPI"

#!/usr/bin/env bash
set -euo pipefail

mkdir -p /tmp/vscode-runtime
chmod 700 /tmp/vscode-runtime

echo "==> Go"
go version
go env GOPATH GOMODCACHE

echo "==> Node"
node --version
npm --version

echo "==> Wails"
wails version

echo "==> Download Go modules"
go mod download

echo "==> Install main frontend dependencies"
npm --prefix frontend install

echo "==> Install AI assistant web frontend dependencies"
npm --prefix ai-assistant-web/frontend install

echo "==> Wails doctor"
wails doctor || true

cat <<'EOF'

Devcontainer ready.

Useful commands:
  wails dev
  wails build --platform linux/amd64 --clean
  npm --prefix frontend run dev
  npm --prefix ai-assistant-web/frontend run dev
  go test ./...

Note: Running the desktop GUI from inside a container requires a working X11/Wayland display bridge on the host.
EOF

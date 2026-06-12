# go-stock Dev Container

Open this repository in VS Code and run **Dev Containers: Reopen in Container**.

The container installs:

- Go 1.26
- Node.js 22 and npm
- Wails CLI v2.11
- Linux GTK/WebKit build dependencies
- Vue/Vite frontend dependencies for `frontend`
- Vue/Vite frontend dependencies for `ai-assistant-web/frontend`
- Go tools: `gopls`, `dlv`, `golangci-lint`

Useful commands:

```bash
wails dev
wails build --platform linux/amd64 --clean
npm --prefix frontend run dev
npm --prefix ai-assistant-web/frontend run dev
go test ./...
```

Running the Wails desktop GUI from a container needs a display bridge.
On a Linux host, you can add these mounts locally if needed:

```json
"mounts": [
  "source=/tmp/.X11-unix,target=/tmp/.X11-unix,type=bind",
  "source=${localEnv:HOME}/.Xauthority,target=/home/vscode/.Xauthority,type=bind,consistency=cached"
]
```

Then allow local Docker clients to connect to X11 on the host:

```bash
xhost +local:docker
```

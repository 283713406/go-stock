FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ARG GO_VERSION=1.26.0
ARG NODE_MAJOR=22
ARG WAILS_VERSION=v2.11.0
ARG UBUNTU_MIRROR=https://mirrors.aliyun.com/ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV GOPATH=/go
ENV GOBIN=/go/bin
ENV GOPROXY=https://goproxy.cn,direct
ENV GOSUMDB=sum.golang.google.cn
ENV NPM_CONFIG_REGISTRY=https://registry.npmmirror.com
ENV PATH=/usr/local/go/bin:/go/bin:/usr/local/share/npm-global/bin:${PATH}

RUN sed -i "s|http://archive.ubuntu.com/ubuntu|${UBUNTU_MIRROR}|g; s|http://security.ubuntu.com/ubuntu|${UBUNTU_MIRROR}|g" /etc/apt/sources.list \
    && printf 'Acquire::Retries "5";\nAcquire::http::Timeout "30";\nAcquire::https::Timeout "30";\n' > /etc/apt/apt.conf.d/80-retries

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        git \
        build-essential \
        pkg-config \
        gcc \
        g++ \
        make \
        libc6-dev \
        libgtk-3-dev \
        libwebkit2gtk-4.0-dev \
        libayatana-appindicator3-dev \
        libnotify-dev \
        libnss3 \
        libxss1 \
        libasound2 \
        libgbm1 \
        libxkbcommon0 \
        xdg-utils \
        dbus-x11 \
        xvfb \
        fonts-wqy-zenhei \
        fonts-wqy-microhei \
        sqlite3 \
        jq \
        unzip \
        zip \
        vim \
        nano \
        less \
        ripgrep \
        fd-find \
        shellcheck \
    && rm -rf /var/lib/apt/lists/*

RUN arch="$(dpkg --print-architecture)" \
    && case "$arch" in \
        amd64) go_arch="amd64" ;; \
        arm64) go_arch="arm64" ;; \
        *) echo "unsupported architecture: $arch" >&2; exit 1 ;; \
    esac \
    && curl -fsSL "https://mirrors.aliyun.com/golang/go${GO_VERSION}.linux-${go_arch}.tar.gz" -o /tmp/go.tgz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf /tmp/go.tgz \
    && rm /tmp/go.tgz

RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g npm@latest \
    && npm config set registry "${NPM_CONFIG_REGISTRY}" \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /go /usr/local/share/npm-global /tmp/vscode-runtime \
    && chown -R vscode:vscode /go /usr/local/share/npm-global /tmp/vscode-runtime

USER vscode

RUN go install github.com/wailsapp/wails/v2/cmd/wails@${WAILS_VERSION}

WORKDIR /workspaces/go-stock

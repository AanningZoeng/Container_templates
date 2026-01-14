# ==============================
# SkyRL 训练镜像（Yotta 扩展版）
# 底座：novaskyai/skyrl-train-ray-2.51.1-py3.12-cu12.8
# 用途：NovaSky SkyRL 强化学习训练环境
# ==============================
ARG BASE_IMAGE="novaskyai/skyrl-train-ray-2.51.1-py3.12-cu12.8"

FROM ${BASE_IMAGE} AS base

SHELL ["/bin/bash","-o","pipefail","-c"]


# ==============================
# runtime: Yotta标准化扩展
# ==============================
FROM base AS runtime

USER root
WORKDIR /workspace

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      htop \
      nano \
      vim \
      curl \
      wget \
      git \
      jq \
      net-tools \
      iputils-ping \
      tree \
      lsof \
      ncdu \
      screen \
      tmux \
      dstat \
      iotop \
      iftop && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#工具目录+check是否正常安装
RUN mkdir -p /yotta/tools && \
    echo "#!/usr/bin/env bash" > /yotta/tools/info.sh && \
    
    echo "echo '[Yotta] GPU:'; nvidia-smi || true" >> /yotta/tools/info.sh && \
    echo "echo '[Yotta] Python:'; python -V" >> /yotta/tools/info.sh && \
    echo "echo '[Yotta] SkyRL import test:'" >> /yotta/tools/info.sh && \
    echo "python - << 'PY'" >> /yotta/tools/info.sh && \
    echo "import skyrl" >> /yotta/tools/info.sh && \
    echo "print('  module:', skyrl)" >> /yotta/tools/info.sh && \
    echo "print('  version:', getattr(skyrl, '__version__', 'unknown'))" >> /yotta/tools/info.sh && \
    echo "PY" >> /yotta/tools/info.sh && \

ENV PATH="/yotta/tools:${PATH}"


# Branding 文案
RUN echo "YottaLabs AI - Unsloth Training Platform" > /etc/yotta.txt


# 检查Ray是否可用
if command -v ray &> /dev/null; then
    ray --version > /dev/null 2>&1 || {
        echo "Ray check failed"
        exit 1
    }
fi

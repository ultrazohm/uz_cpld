# syntax=docker/dockerfile:1
FROM ubuntu:22.04 AS toolchain
ARG DEBIAN_FRONTEND=noninteractive
RUN test "$(dpkg --print-architecture)" = amd64 || { echo 'This toolchain requires linux/amd64 (native or emulated).' >&2; exit 1; }
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash ca-certificates curl git make python3 python3-pip python3-tk libpython3.10 yosys graphviz \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://github.com/ghdl/ghdl/releases/download/v4.1.0/ghdl-gha-ubuntu-22.04-mcode.tgz -o /tmp/ghdl.tgz \
    && echo '1ffa567ad50f54529140108ab45b974829ca134d47d095b0ed704d35cd2ff1d6  /tmp/ghdl.tgz' | sha256sum -c - \
    && mkdir -p /opt/ghdl && tar -xzf /tmp/ghdl.tgz -C /opt/ghdl \
    && rm /tmp/ghdl.tgz
ENV PATH="/opt/ghdl/bin:${PATH}" \
    CPLD_TOOLCHAIN_CONTAINER=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1
COPY requirements.txt /tmp/dependencies/requirements.txt
COPY docs/requirements.txt /tmp/dependencies/docs/requirements.txt
COPY toolchain/simulation/requirements.txt /tmp/dependencies/toolchain/simulation/requirements.txt
COPY toolchain/analysis/requirements.txt /tmp/dependencies/toolchain/analysis/requirements.txt
RUN python3 -m pip install --no-cache-dir -r /tmp/dependencies/docs/requirements.txt \
    && python3 -m pip check && ghdl --version && python3 -m sphinx --version
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} vscode \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash vscode
USER vscode
WORKDIR /work
CMD ["sleep", "infinity"]

FROM toolchain AS development
USER root
RUN apt-get update && apt-get install -y --no-install-recommends gtkwave ripgrep sudo iproute2 net-tools file procps \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'vscode ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode
USER vscode
ENV PATH="/home/vscode/.local/bin:${PATH}"
ARG CODEX_VERSION=latest
RUN curl -fsSL https://chatgpt.com/codex/install.sh -o /tmp/install-codex.sh \
    && CODEX_NON_INTERACTIVE=1 sh /tmp/install-codex.sh --release "${CODEX_VERSION}" \
    && rm /tmp/install-codex.sh \
    && codex --version

FROM development AS diamond
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfontconfig1 libfreetype6 libglib2.0-0 libice6 libsm6 \
    libx11-6 libxext6 libxft2 libxi6 libxrandr2 libxrender1 libxt6 libxtst6 \
    libncurses5 libtinfo5 libusb-0.1-4 libusb-1.0-0 libuuid1 zlib1g \
    && rm -rf /var/lib/apt/lists/*
COPY .devcontainer/diamond-cli /usr/local/bin/diamond-cli
COPY .devcontainer/check-diamond /usr/local/bin/check-diamond
COPY .devcontainer/smoke.tcl /usr/local/share/diamond/smoke.tcl
RUN chmod 0755 /usr/local/bin/diamond-cli /usr/local/bin/check-diamond
ENV DIAMOND_ROOT=/opt/diamond
USER vscode

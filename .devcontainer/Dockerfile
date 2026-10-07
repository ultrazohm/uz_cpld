# syntax=docker/dockerfile:1
ARG UBUNTU_VERSION=22.04
# Default: host-mounted Diamond. Override to inherit an image with Diamond installed.
ARG TOOLCHAIN_BASE=ubuntu:${UBUNTU_VERSION}
# Shared Python environment; the same manifest, interpreter pin and lock are used natively.
FROM ubuntu:${UBUNTU_VERSION} AS python-environment
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates python3 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/python-project
COPY pyproject.toml setup.cfg uv.lock .python-version ./
COPY cpld_toolchain/__init__.py cpld_toolchain/bootstrap.py cpld_toolchain/uv-bootstrap.json cpld_toolchain/README.md ./cpld_toolchain/
RUN python3 -c 'from pathlib import Path; import shutil; from cpld_toolchain.bootstrap import ensure_uv; shutil.copy2(ensure_uv(Path("/tmp/uv-bootstrap")), "/usr/local/bin/uv")' \
    && rm -rf /tmp/uv-bootstrap
ENV UV_PYTHON_INSTALL_DIR=/opt/uv-python \
    UV_PROJECT_ENVIRONMENT=/opt/uz-cpld-env \
    UV_LINK_MODE=copy
# Source code is supplied by the mounted checkout, not baked into the environment.
RUN uv sync --locked --all-groups --no-install-project --managed-python --python "$(cat .python-version)" \
    && uv cache clean

FROM ubuntu:${UBUNTU_VERSION} AS foss-builder
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl python3 python3-dev build-essential \
    libboost-filesystem-dev libboost-program-options-dev libboost-iostreams-dev libboost-thread-dev \
    libeigen3-dev pybind11-dev pkg-config patch libftdi1-dev libusb-1.0-0-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
COPY --from=python-environment /usr/local/bin/uv /usr/local/bin/uv
RUN uv tool install --python /usr/bin/python3 cmake==3.31.6
ENV PATH="/root/.local/bin:${PATH}"
COPY cpld_toolchain/toolchain/foss/ /tmp/foss-setup/
ARG FOSS_BUILD_JOBS=2
RUN python3 /tmp/foss-setup/install.py --prefix /opt/oss-cad-suite \
    && python3 /tmp/foss-setup/build_nextpnr.py --suite /opt/oss-cad-suite --jobs ${FOSS_BUILD_JOBS} \
    && python3 /tmp/foss-setup/flasher.py --output /opt/oss-cad-suite/native/openfpgaloader --jobs ${FOSS_BUILD_JOBS} \
    && /opt/oss-cad-suite/bin/yosys -V \
    && /opt/oss-cad-suite/native/nextpnr-machxo2 --version \
    && /opt/oss-cad-suite/bin/ecppack --version \
    && /opt/oss-cad-suite/bin/openFPGALoader --Version \
    && /opt/oss-cad-suite/native/openfpgaloader/openFPGALoader --Version \
    && /opt/oss-cad-suite/bin/openocd --version

FROM ${TOOLCHAIN_BASE} AS toolchain
ARG DEBIAN_FRONTEND=noninteractive
RUN test "$(dpkg --print-architecture)" = amd64 || { echo 'This toolchain requires linux/amd64 (native or emulated).' >&2; exit 1; }
# Synplify batch mode also loads Qt OpenGL and GStreamer runtime libraries.
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash ca-certificates curl git openssh-client make python3 graphviz \
    gtkwave ripgrep sudo iproute2 net-tools file procps \
    libfontconfig1 libfreetype6 libglib2.0-0 libgl1 libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 libice6 libsm6 \
    libx11-6 libxext6 libxft2 libxi6 libxrandr2 libxrender1 libxt6 libxtst6 \
    libncurses5 libtinfo5 libusb-0.1-4 libusb-1.0-0 libftdi1-2 libuuid1 zlib1g \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'vscode ALL=(root) NOPASSWD:ALL' > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode
RUN curl -fsSL https://github.com/ghdl/ghdl/releases/download/v4.1.0/ghdl-gha-ubuntu-22.04-mcode.tgz -o /tmp/ghdl.tgz \
    && echo '1ffa567ad50f54529140108ab45b974829ca134d47d095b0ed704d35cd2ff1d6  /tmp/ghdl.tgz' | sha256sum -c - \
    && mkdir -p /opt/ghdl && tar -xzf /tmp/ghdl.tgz -C /opt/ghdl \
    && rm /tmp/ghdl.tgz
ENV PATH="/opt/uz-cpld-env/bin:/opt/diamond/bin/lin64:/opt/ghdl/bin:/home/vscode/.local/bin:${PATH}" \
    CPLD_TOOLCHAIN_CONTAINER=1 \
    UV_PROJECT_ENVIRONMENT=/opt/uz-cpld-env \
    UV_PYTHON_INSTALL_DIR=/opt/uv-python \
    UV_CACHE_DIR=/tmp/uv-cache \
    UV_NO_SYNC=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    FOSS_ROOT=/opt/oss-cad-suite \
    DIAMOND_ROOT=/opt/diamond
COPY --from=python-environment /usr/local/bin/uv /usr/local/bin/uv
COPY --from=python-environment /opt/uv-python /opt/uv-python
COPY --from=python-environment /opt/uz-cpld-env /opt/uz-cpld-env
COPY .devcontainer/uz_cpld /usr/local/bin/uz_cpld
RUN chmod 0755 /usr/local/bin/uz_cpld \
    && uv pip check --python /opt/uz-cpld-env/bin/python \
    && ghdl --version && python3 -m sphinx --version \
    && python3 -c 'import tkinter'
COPY --from=foss-builder /opt/oss-cad-suite /opt/oss-cad-suite
COPY .devcontainer/diamond-cli /usr/local/bin/diamond-cli
COPY .devcontainer/check-diamond /usr/local/bin/check-diamond
COPY .devcontainer/container-entrypoint /usr/local/bin/toolchain-entrypoint
COPY .devcontainer/smoke.tcl /usr/local/share/diamond/smoke.tcl
RUN chmod 0755 /usr/local/bin/diamond-cli /usr/local/bin/check-diamond /usr/local/bin/toolchain-entrypoint
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} vscode \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash vscode
USER vscode
RUN python3 -c 'import json; from pathlib import Path; p = Path("/opt/oss-cad-suite/native/openfpgaloader/usercode-support.json"); json.loads(p.read_text())' \
    && /opt/oss-cad-suite/native/openfpgaloader/openFPGALoader --Version
WORKDIR /work
ENTRYPOINT ["/usr/local/bin/toolchain-entrypoint"]
CMD ["sleep", "infinity"]

# Same glibc floor and pinned validation image as ultrazohm_sw/develop.
FROM quay.io/pypa/manylinux_2_28_x86_64@sha256:55a36963bc0504cdf004011001c1072306402f0b8b83be5a5eba7068f93eec53
RUN dnf install -y epel-release && dnf install -y libftdi-devel libusb1-devel zlib-devel pkgconf-pkg-config dnf-plugins-core && dnf clean all
ENV PATH="/opt/python/cp312-cp312/bin:$PATH"
RUN python -m pip install build==1.3.0
WORKDIR /work

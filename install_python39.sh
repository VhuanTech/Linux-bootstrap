#!/usr/bin/env bash
set -euo pipefail

PYTHON_VERSION="${PYTHON_VERSION:-3.9}"
PYTHON_MAJOR=$(echo "$PYTHON_VERSION" | cut -d. -f1)
PYTHON_MINOR=$(echo "$PYTHON_VERSION" | cut -d. -f2)

echo "=== Installing Python ${PYTHON_VERSION} ==="

detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_ID="$ID"
        OS_VERSION_ID="$VERSION_ID"
    else
        echo "ERROR: Cannot detect OS. /etc/os-release not found." >&2
        exit 1
    fi
}

install_ubuntu_debian() {
    echo "Detected: ${OS_ID} ${OS_VERSION_ID} (Ubuntu/Debian)"

    if command -v python${PYTHON_VERSION} &>/dev/null; then
        echo "Python ${PYTHON_VERSION} is already installed."
        python${PYTHON_VERSION} --version
        return
    fi

    echo "Adding deadsnakes PPA..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq software-properties-common

    if ! sudo add-apt-repository -y ppa:deadsnakes/ppa; then
        echo "WARNING: Could not add deadsnakes PPA. Trying to build from source..."
        build_from_source
        return
    fi

    sudo apt-get update -qq
    sudo apt-get install -y -qq \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-venv \
        python${PYTHON_VERSION}-dev

    echo "Python ${PYTHON_VERSION} installed successfully."
    python${PYTHON_VERSION} --version
}

install_rhel_centos() {
    echo "Detected: ${OS_ID} ${OS_VERSION_ID} (RHEL/CentOS)"

    if command -v python${PYTHON_MAJOR}.${PYTHON_MINOR} &>/dev/null; then
        echo "Python ${PYTHON_VERSION} is already installed."
        python${PYTHON_VERSION} --version
        return
    fi

    OS_MAJOR=$(echo "$OS_VERSION_ID" | cut -d. -f1)

    if [ "$OS_MAJOR" -ge 8 ]; then
        # RHEL/CentOS 8+, Rocky, Alma
        sudo dnf install -y python${PYTHON_MINOR} python${PYTHON_MINOR}-devel 2>/dev/null || {
            echo "dnf method failed, trying build from source..."
            build_from_source
            return
        }
    else
        # RHEL/CentOS 7
        echo "Installing IUS repo for RHEL/CentOS 7..."
        sudo yum install -y \
            "https://repo.ius.io/ius-release-el7.rpm" 2>/dev/null || {
            echo "IUS repo failed, trying build from source..."
            build_from_source
            return
        }
        sudo yum install -y \
            "python${PYTHON_MAJOR}${PYTHON_MINOR}" \
            "python${PYTHON_MAJOR}${PYTHON_MINOR}-devel"
    fi

    echo "Python ${PYTHON_VERSION} installed successfully."
    python${PYTHON_VERSION} --version
}

build_from_source() {
    echo "Building Python ${PYTHON_VERSION} from source..."

    local FULL_VER
    case "$PYTHON_VERSION" in
        3.9)  FULL_VER="3.9.21" ;;
        3.10) FULL_VER="3.10.16" ;;
        3.11) FULL_VER="3.11.11" ;;
        3.12) FULL_VER="3.12.9" ;;
        *)    echo "ERROR: Unknown Python version $PYTHON_VERSION for source build." >&2; exit 1 ;;
    esac

    local BUILD_DIR="/tmp/python-build-${FULL_VER}"

    # install build deps
    if command -v apt-get &>/dev/null; then
        sudo apt-get update -qq
        sudo apt-get install -y -qq \
            build-essential libssl-dev zlib1g-dev libbz2-dev \
            libreadline-dev libsqlite3-dev wget curl llvm \
            libncursesw5-dev xz-utils tk-dev libxml2-dev \
            libxmlsec1-dev libffi-dev liblzma-dev
    elif command -v yum &>/dev/null; then
        sudo yum groupinstall -y "Development Tools"
        sudo yum install -y \
            openssl-devel bzip2-devel libffi-devel \
            readline-devel sqlite-devel wget xz-devel
    elif command -v dnf &>/dev/null; then
        sudo dnf groupinstall -y "Development Tools"
        sudo dnf install -y \
            openssl-devel bzip2-devel libffi-devel \
            readline-devel sqlite-devel wget xz-devel
    fi

    if [ ! -f "$BUILD_DIR/Python-${FULL_VER}.tgz" ]; then
        mkdir -p "$BUILD_DIR"
        wget -q "https://www.python.org/ftp/python/${FULL_VER}/Python-${FULL_VER}.tgz" \
            -O "$BUILD_DIR/Python-${FULL_VER}.tgz"
    fi

    tar -xzf "$BUILD_DIR/Python-${FULL_VER}.tgz" -C "$BUILD_DIR"
    cd "$BUILD_DIR/Python-${FULL_VER}"
    ./configure --enable-optimizations --prefix="/usr/local" 2>&1 | tail -5
    make -j"$(nproc)" 2>&1 | tail -5
    sudo make altinstall 2>&1 | tail -5

    cd /
    rm -rf "$BUILD_DIR"

    echo "Python ${PYTHON_VERSION} built and installed successfully."
    /usr/local/bin/python${PYTHON_VERSION} --version
}

main() {
    detect_os

    case "$OS_ID" in
        ubuntu|debian|linuxmint|pop|elementary|zorin|neon)
            install_ubuntu_debian
            ;;
        rhel|centos|fedora|rocky|alma|ol|scientific|amzn)
            install_rhel_centos
            ;;
        *)
            echo "Unsupported OS: $OS_ID. Attempting source build..."
            build_from_source
            ;;
    esac

    # verify
    if ! command -v python${PYTHON_VERSION} &>/dev/null; then
        if [ -x /usr/local/bin/python${PYTHON_VERSION} ]; then
            export PATH="/usr/local/bin:$PATH"
        else
            echo "ERROR: Python ${PYTHON_VERSION} installation failed." >&2
            exit 1
        fi
    fi

    echo ""
    echo "=== Python ${PYTHON_VERSION} ready at: $(command -v python${PYTHON_VERSION}) ==="
    python${PYTHON_VERSION} --version
    echo "Now run:  bash setup.sh"
}

main "$@"

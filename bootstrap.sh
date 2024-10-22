#!/bin/bash

# Define a common list of packages
PACKAGES=(
    git
    zsh
)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to execute all tool-specific install.sh scripts
run_tool_install_scripts() {
    for dir in */; do
        if [ -f "$dir/install.sh" ]; then
            echo -e "${BLUE}Running ${dir}install.sh...${NC}"
            (cd "$dir" && ./install.sh)
        fi
    done
}

# Install packages using Homebrew on macOS
install_homebrew_packages() {
    for package in "${PACKAGES[@]}"; do
        if ! brew list -1 | grep -q "^$package\$"; then
            echo "Installing $package..."
            brew install "$package" --quiet
        else
            echo -e "${GREEN}$package is already installed, skipping.${NC}"
        fi
    done
}

# Install packages using APT on Linux
install_apt_packages() {
    for package in "${PACKAGES[@]}"; do
        if ! dpkg -l | grep -q "^ii  $package"; then
            echo -e "${YELLOW}Installing $package...${ND}"
            sudo apt install -y "$package" -qq
        else
            echo -e "${GREEN}$package is already installed, skipping.${NC}"
        fi
    done
}

# Function to install common packages
install_common_packages() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Install Xcode Command Line Tools
        if ! xcode-select -p &>/dev/null; then
            echo -e "${BLUE}Installing Xcode Command Line Tools...${NC}"
            sudo xcode-select --install
        fi

        # Install Homebrew if not installed
        if ! command -v brew &>/dev/null; then
            echo -e "${BLUE}Installing Homebrew...${NC}"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            # Add Homebrew to PATH
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        install_homebrew_packages

    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update -qq
        install_apt_packages
    else
        echo -e "${RED}Unknown OS. Exiting.${NC}"
        exit 1
    fi

}

install_common_packages
run_tool_install_scripts

echo -e "${GREEN}Bootstrap process complete.${NC}"
/bin/zsh

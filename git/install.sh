#!/bin/bash

YELLOW='\033[0;33m'
NC='\033[0m'

# Symlink the .gitconfig file
if [ -f "$HOME/.gitconfig" ]; then
    mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
    echo -e "${YELLOW}Backed up existing .gitconfig to .gitconfig.bak${NC}"
fi
ln -sv "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"

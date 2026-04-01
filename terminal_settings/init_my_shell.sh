#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 0. Prerequisites check
echo "[0] Checking prerequisites..."
for cmd in curl git; do
    if ! command -v $cmd &>/dev/null; then
        echo "$cmd is not installed. Installing..."
        sudo apt-get update && sudo apt-get install $cmd -y
    fi
done

# 1. zsh 설치 확인 및 설치
echo "[1] Checking if zsh is installed..."
if ! command -v zsh &>/dev/null; then
    echo "zsh is not installed. Installing zsh..."
    if [[ $(uname) == "Darwin" ]]; then
        brew install zsh
    else
        sudo apt-get update && sudo apt-get install zsh -y
    fi
else
    echo "zsh is already installed."
fi

# 2. less 설치 확인 및 설치
echo "[2] Checking if less is installed..."
if ! command -v less &>/dev/null; then
    echo "less is not installed. Installing less..."
    if [[ $(uname) == "Darwin" ]]; then
        brew install less
    else
        sudo apt-get install less -y
    fi
else
    echo "less is already installed."
fi

# 3. Oh My Zsh 설치 확인 및 설치
echo "[3] Checking if Oh My Zsh is installed..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# 4. Powerlevel10k 테마 설치 확인 및 설치
echo "[4] Checking if Powerlevel10k is installed..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Powerlevel10k is not installed. Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "Powerlevel10k is already installed."
fi

# 5. vim backup 디렉토리 생성
echo "[5] Creating vim backup directory..."
mkdir -p "$HOME/.vim/backups"

# 6. 파일을 홈 디렉토리로 심볼릭 링크 생성
echo "[6] Creating symbolic links for configuration files in home directory..."

FILES=(.my_aliases.sh .vimrc .zshrc .bashrc)
for FILE in "${FILES[@]}"; do
    if [ -f "$SCRIPT_DIR/$FILE" ]; then
        if [ -e "$HOME/$FILE" ] || [ -L "$HOME/$FILE" ]; then
            echo "$HOME/$FILE already exists. Removing existing file or link."
            rm -f "$HOME/$FILE"
        fi
        ln -sf "$SCRIPT_DIR/$FILE" "$HOME/$FILE"
        echo "Symbolic link for $FILE created in home directory."
    else
        echo "$FILE not found in $SCRIPT_DIR."
    fi
done

# 운영 체제에 따라 .gitconfig 심볼릭 링크 생성
if [ -e "$HOME/.gitconfig" ] || [ -L "$HOME/.gitconfig" ]; then
    echo "$HOME/.gitconfig already exists. Removing existing file or link."
    rm -f "$HOME/.gitconfig"
fi

if [[ $(uname) == "Darwin" ]]; then
    if [ -f "$SCRIPT_DIR/.mac.gitconfig" ]; then
        echo "Creating symbolic link for macOS .gitconfig..."
        ln -sf "$SCRIPT_DIR/.mac.gitconfig" "$HOME/.gitconfig"
        echo "Symbolic link for .gitconfig created in home directory."
    else
        echo ".mac.gitconfig not found. Copying .gitconfig instead."
        [ -f "$SCRIPT_DIR/.gitconfig" ] && ln -sf "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
    fi
elif [[ $(uname) == "Linux" ]]; then
    if [ -f "$SCRIPT_DIR/.linux.gitconfig" ]; then
        echo "Creating symbolic link for Linux .gitconfig..."
        ln -sf "$SCRIPT_DIR/.linux.gitconfig" "$HOME/.gitconfig"
        echo "Symbolic link for .gitconfig created in home directory."
    else
        echo ".linux.gitconfig not found. Copying .gitconfig instead."
        [ -f "$SCRIPT_DIR/.gitconfig" ] && ln -sf "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
    fi
fi

# 7. 기본 쉘을 zsh로 설정
echo "[7] Setting zsh as the default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    echo "zsh has been set as the default shell."
else
    echo "zsh is already the default shell."
fi

echo ""
echo "============================================"
echo "  Setup complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. git config --global user.name \"Your Name\""
echo "  2. git config --global user.email \"your@email.com\""
echo "  3. Restart your terminal (or run: zsh)"
echo "  4. (Optional) Run 'p10k configure' to customize your prompt"
echo "     Recommended settings: ynn 111 22 2141 2y 1 (y)"
echo ""

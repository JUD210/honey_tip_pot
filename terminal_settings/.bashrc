# If zsh is installed, switch to it automatically
if [ -x "$(command -v zsh)" ]; then
    exec zsh
fi

# Cargo (Rust) environment
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

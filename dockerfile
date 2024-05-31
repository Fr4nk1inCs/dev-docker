# Base image: ArchLinux
FROM archlinux:latest

# Mirrorlist: USTC
ARG MIRROR="Server = https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch"
RUN printf "%s\n%s\n" "${MIRROR}" "$(cat /etc/pacman.d/mirrorlist)" > /etc/pacman.d/mirrorlist

# Update the system
RUN pacman -Syyu --noconfirm

# Install packages
## Base packages
ARG BASE_PACKAGES="base-devel zsh vim git neovim tmux openssh wget curl htop zip unzip gzip tar less"
RUN pacman -S --noconfirm ${BASE_PACKAGES}

## CLI Tools
ARG CLI_TOOLS="fzf ripgrep fd bat eza git-delta zoxide starship lazygit"
RUN pacman -S --noconfirm ${CLI_TOOLS}

# Development configuration
## Zsh configuration
### Install zimfw
RUN curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
### zshrc & zimrc
COPY ./zimrc /root/.zimrc
COPY ./zshrc /root/.zshrc
### starship preset
RUN mkdir "$HOME/.config" && starship preset nerd-font-symbols -o "$HOME/.config/starship.toml"
### fzf configuration
COPY ./fzfrc /root/.fzfrc
### bat configuration
COPY ./config/bat /root/.config/bat
### tmux configuration
COPY ./tmux.conf /root/.tmux.conf

## Development tools
### Rust
RUN pacman -S --noconfirm rustup
RUN rustup default stable

### LLVM
RUN pacman -S --noconfirm llvm clang

### Python (Mamba as package manager)
ARG MAMBA_SOURCE="/mamba/"
RUN pacman -S --noconfirm python python-pip
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" -O "/tmp/Miniforge3-$(uname)-$(uname -m).sh"
RUN bash "/tmp/Miniforge3-$(uname)-$(uname -m).sh" -b -p ${MAMBA_SOURCE}
RUN echo "" >> "$HOME/.zshrc" && \
    echo "# mamba" >> "$HOME/.zshrc" && \
    echo "source \"${MAMBA_SOURCE}/etc/profile.d/conda.sh\"" >> "$HOME/.zshrc" && \
    echo "source \"${MAMBA_SOURCE}/etc/profile.d/mamba.sh\"" >> "$HOME/.zshrc"
COPY ./mambarc /root/.mambarc

## Editor configuration (NeoVim)
COPY ./config/nvim /root/.config/nvim
### NeoVim dependencies
ARG NVIM_DEP_PACKAGES="tree-sitter-cli python-pynvim nodejs npm"
RUN pacman -S --noconfirm ${NVIM_DEP_PACKAGES}
RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless "+TSUpdate" +qa

ENV TERM=xterm-256color

ENTRYPOINT ["/bin/zsh"]

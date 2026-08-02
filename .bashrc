# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export PATH="$PATH:/home/fabian/.local/bin"
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias nodejs='node'
alias fastfetch='hyfetch -p=#8ec07c,#83a598,#fabd2f,#fb4934 -b fastfetch';

cat() {
    for arg in "$@"; do
        if [[ "$arg" == *.json ]]; then
            if command -v jq >/dev/null 2>&1; then
                jq . "$arg"
            else
                command cat "$arg"
            fi
        else
            command cat "$arg"
        fi
    done
}

fastfetch

. /etc/profile.d/nix.sh
export NIX_REMOTE=daemon

# terminal-wakatime setup
export PATH="$HOME/.wakatime:$PATH"
eval "$(terminal-wakatime init)"

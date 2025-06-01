# .bashrc
export EDITOR="nvim"

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
. "$HOME/.cargo/env"
export PATH="$PATH:~/Documents/CODE/UTILS-windows/UTILS"

yazi() {
  local tmpfile=$(mktemp)
  command yazi --cwd-file="$tmpfile" "$@"
  if [ -f "$tmpfile" ]; then
    local last_dir=$(<"$tmpfile")
    rm -f "$tmpfile"
    if [ -d "$last_dir" ]; then
      cd "$last_dir"
    fi
  fi
}

alias scale125="kscreen-doctor output.eDP-1.scale.1,25"
alias config='/usr/bin/git --git-dir=/home/janecea/.cfg/ --work-tree=/home/janecea'

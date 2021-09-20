set fish_greeting
fish_vi_key_bindings

set fish_bind_mode insert
alias rm 'rm -i'
alias nnn 'nnn -e'
alias mpv 'mpv --hwdec=vaapi'
alias icat 'kitty +kitten icat'
set -gx MOZ_WEBRENDER 1
export GPG_TTY=(tty)
set -gx XDG_SESSION_TYPE wayland
set -gx XDG_CURRENT_DESKTOP sway
set -gx MOZ_ENABLE_WAYLAND 1
set -gx EDITOR vim
set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket
set -gx LC_ALL en_US.UTF-8
set -x PATH /usr/libexec /usr/local/bin /home/minhradz/.cargo/bin /home/minhradz/.local/bin $PATH
starship init fish | source
eval (direnv hook fish)

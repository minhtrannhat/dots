set fish_greeting
fish_vi_key_bindings
set fish_bind_mode insert

alias rm 'rm -i'
alias nnn 'nnn -e'
alias mpv 'mpv --hwdec=vaapi'
alias icat 'kitty +kitten icat'
alias magit 'emacs -nw --eval "(magit-status)"'
alias qutebrowser 'qutebrowser --qt-flag ignore-gpu-blocklist --qt-flag enable-gpu-rasterization --qt-flag enable-native-gpu-memory-buffers --qt-flag num-raster-threads=4'

export GPG_TTY=(tty)

set -gx MOZ_WEBRENDER 1
set -gx XDG_SESSION_TYPE wayland
set -gx XDG_CURRENT_DESKTOP sway
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_AUTO_SCREEN_SCALE_FACTOR 1

set -Ux GTK_IM_MODULE ibus
set -Ux QT_IM_MODULE ibus
set -Ux XMODIFIERS @im=ibus

set -gx EDITOR lvim
set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket

set -gx LC_ALL en_US.UTF-8

set -x PATH /usr/libexec /usr/local/bin /home/minhradz/.cargo/bin /home/minhradz/.local/bin $PATH

starship init fish | source

set fish_greeting
fish_vi_key_bindings
set fish_bind_mode insert

alias rm 'rm -i'
alias nnn 'nnn -e'
alias icat 'kitty +kitten icat'
alias magit 'emacs -nw --eval "(magit-status)"'
alias emac 'emacsclient -nw'

export GPG_TTY=(tty)

gpgconf --launch gpg-agent

if test -z (pgrep ssh-agent)
  eval (ssh-agent -c)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

set -gx MOZ_WEBRENDER 1
set -gx XDG_SESSION_TYPE wayland
set -gx XDG_CURRENT_DESKTOP sway
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_AUTO_SCREEN_SCALE_FACTOR 1

set -gx VDPAU_DRIVER va_gl

set -Ux GTK_IM_MODULE ibus
set -Ux QT_IM_MODULE ibus
set -Ux XMODIFIERS @im=ibus

set -gx EDITOR lvim
set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket
set -gx MANPAGER "lvim +Man!"
set -gx LC_ALL en_US.UTF-8

set -gx _JAVA_AWT_WM_NONREPARENTING 1

# bun
set --export BUN_INSTALL "$HOME/.bun"

set -x PATH /usr/libexec /usr/local/bin /home/minhradz/.cargo/bin /home/minhradz/.local/bin /home/minhradz/go/bin /home/minhradz/.cabal/bin $BUN_INSTALL/bin $PATH

starship init fish | source

direnv hook fish | source

# The following lines were added by compinstall

zstyle ':completion:*' auto-description ':%d'
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 'NUMERIC==1'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SScroll: %p (%l) | ↑↓ to move, TAB to accept%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*' '+'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=3
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'Found %e error(s). Select correction:'
zstyle ':completion:*' select-prompt '%SScrolling (%p) | %l | Press ↑↓ to select%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 'NUMERIC==2'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/jccc/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt autocd beep extendedglob nomatch auto_menu
unsetopt notify
bindkey -v
# End of lines configured by zsh-newuser-install

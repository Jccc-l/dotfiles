zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 0
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 'NUMERIC >= 1'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=**' '+l:|=* r:|=*' '+'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '输入中存在 %e 个错误'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes false
zstyle ':completion:*' substitute 'NUMERIC >= 1'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/jccc/.zshrc'
# 只有一个匹配时直接补全
zstyle ':completion:*' auto-complete true
# 强制列出完整文件/目录名（关键）
zstyle ':completion:*' file-list false

# 可选：让目录补全时也显示完整路径
zstyle ':completion:*:cd:*' list-full-path true
zstyle ':completion:*:cd:*' show-remaining true

# 方向键补全
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt autocd beep extendedglob nomatch notify

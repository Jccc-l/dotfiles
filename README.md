# Dotfile

## Z-Shell

### Plugins

- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [You Should Use](https://github.com/MichaelAquilina/zsh-you-should-use)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/)

```zsh
ln -sf ~/.config/zsh/zshrc ~/.zshrc
ln -sf ~/.config/zsh/.p10k.zsh ~/.p10k.zsh
```

### Vi-Mode Keymap

Set keymaps for Vi-Mode

'keys' is the key combination to bind, and 'action' is the corresponding action or command.

```zsh
bindkey -M vicmd keys action
```

See [Zsh Line Editor - Movements](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Movement)

E.G. Map 'k' to backward-char

```zsh
bindkey -M vicmd 'k' backward-char
```

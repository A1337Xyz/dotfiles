[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] || {
    fortune | cowsay -f $(ls -1 /usr/share/cows | shuf -n1) 2>/dev/null;
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null;
}
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source ~/.config/bash_aliases
source ~/.scripts/ShellScript/bash_functions
unset -f bkp
alias bkp='tar --numeric-owner -pcaf'

autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
    print -Pn -- '\e]2;urxvt %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
    print -Pn -- '\e]2;urxvt %~ %# ' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

add-zsh-hook -Uz precmd xterm_title_precmd
add-zsh-hook -Uz preexec xterm_title_preexec

zstyle :compinstall filename '/home/anon/.config/zsh/zshrc'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select

eval "$(dircolors -b)"

_comp_options+=(globdots) # Include hidden files in autocomplete

HISTFILE=~/.cache/zsh/histfile
HISTSIZE=5000
SAVEHIST=5000

bindkey "^[[5~" beginning-of-history #PageUp
bindkey "^[[6~" end-of-history #PageDown
bindkey -s "^F" 'vim "$(find ~/.scripts -type f | fzf)"\n'
bindkey -s "^N" 'nnn\n'

setopt autocd
setopt hist_ignore_all_dups
setopt no_beep

blink=$'\033[5m'
PROMPT="%B%{$fg[blue]%}%~%b%{$reset_color%}
%B%0(?.%{$fg[green]%}>.%{$fg[red]%}%{$blink%}>)%{$reset_color%} "
RPROMPT="%{$fg[blue]%}<<<%{$reset_color%}"

#===============================================================================#
# => Custom theme and colors
#===============================================================================#
export LC_ALL=en_US.UTF-8
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

if [ -f ~/.zsh/custom_prompt ]; then
	. ~/.zsh/custom_promt
fi

precmd() { eval "$PROMPT_COMMAND" }
precmd_functions=(prompt_cmd)

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#===============================================================================#
# => History
#===============================================================================#
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

#===============================================================================#
# => AUTOCOMPLETE
#===============================================================================#
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

#===============================================================================#
# => VIM MODE
#===============================================================================#
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
#===============================================================================#
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
#===============================================================================#
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#===============================================================================#
# => Additional Files	
#===============================================================================#
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/pathrc" ] && source "$HOME/.config/pathrc"
[ -f "$HOME/.config/variablerc" ] && source "$HOME/.config/variablerc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

#===============================================================================#
# => ZSH SYNTAX HIGHTLIGHT
#===============================================================================#
source $HOME/.brew/Cellar/zsh-syntax-highlighting/0.6.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

#===============================================================================#
# => Prompt theme															  	#
#===============================================================================#

## Loading Custom Promt
if [ -f ~/.zsh/zsh_classy_custom ]; then
	. ~/.zsh/zsh_classy_custom
fi

## Foreach cmd...
precmd() { eval "$PROMPT_COMMAND" }
precmd_functions=(prompt_cmd)

#===============================================================================#
# => Theme & colors															  	#
#===============================================================================#

## ls command theme
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
alias ls='ls -Fh'

#===============================================================================#
# => Variable Environment													  	#
#===============================================================================#

## define User Environment Variable
export PATH="$HOME/cmake-3.10.0/bin/:$PATH"
export USER=alngo
export MAIL="$USER@student.42.fr"

#===============================================================================#
# => Additional Files													  		#
#===============================================================================#

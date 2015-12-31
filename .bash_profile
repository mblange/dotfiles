#for DOTFILE in `$HOME/.{bash_alias,grep,prompt}`
#do
#  [ -f “$DOTFILE” ] && source “$DOTFILE”
#done

##mbl## this works but above might be better if configured? ##
if [ -f ~/.bashrc ]; then
 	source ~/.bashrc
fi

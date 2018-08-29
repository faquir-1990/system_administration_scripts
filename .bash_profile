# run .bashrc

if [[ -f ~/.bashrc ]]  ; then
        .~/.bashrc
fi
# startx after logging in if $DISPLAY is not set

if  [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] ; then

        startx
fi

# color list

export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[2;37m'
export COLOR_BLACK='\e[1;30m'
export COLOR_BLUE='\e[1;34m'
export COLOR_LIGHT_BLUE='\e[2;34m'
export COLOR_GREEN='\e[1;32m'
export COLOR_LIGHT_GREEN='\e[2;32m'
export COLOR_CYAN='\e[1;36m'
export COLOR_LIGHT_CYAN='\e[2;36m'
export COLOR_RED='\e[1;31m'
export COLOR_LIGHT_RED='\e[2;31m'
export COLOR_PURPLE='\e[1;35m'
export COLOR_LIGHT_PURPLE='\e[2;35m'
export COLOR_BROWN='\e[1;33m'
export COLOR_YELLOW='\e[2;33m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_GRAY='\e[1;37m'


#custom aliases 

alias ls='ls --color'
alias grep='grep --color=auto'
alias q='exit'
alias c='clear'
alias Ccode='cd /home/faquir/C.practice'
alias py='cd /home/faquir/scripts/pyCodes'
alias by='cd /home/faquir/scripts/shell'

#interactive shell user prompt style [basic]
#export PS1="[\[\e[32;1m\]\u@\[\e[32;1m\]\h \[\e[33;1m\]\$PWD]$  \[\e[0m\]"

# Custom:  must put '\' before $PWD so it isn't expanded immediately
PS1="${COLOR_LIGHT_BLUE}\u${COLOR_YELLOW}@${COLOR_LIGHT_GREEN}\h ${COLOR_LIGHT_PURPLE}\$PWD \n${COLOR_LIGHT_GREEN}->${COLOR_NC} "

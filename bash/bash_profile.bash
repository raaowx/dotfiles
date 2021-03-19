# === BASH PROFILE === #

# === VARIABLES  === #
B=$(tput setaf 0); BB=$(tput setaf 8)  # BLACK
R=$(tput setaf 1); RB=$(tput setaf 9)  # RED
G=$(tput setaf 2); GB=$(tput setaf 10) # GREEN
Y=$(tput setaf 3); YB=$(tput setaf 11) # YELLOW
A=$(tput setaf 4); AB=$(tput setaf 12) # BLUE
M=$(tput setaf 5); MB=$(tput setaf 13) # MAGENTA
C=$(tput setaf 6); CB=$(tput setaf 14) # CYAN
W=$(tput setaf 7); WB=$(tput setaf 15) # WHITE
RESET=$(tput sgr0)                     # RESET

# === EXPORT === #
# PROMPT_COMMAND
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
# PROMPT
export PS1='\[$W\][\D{%a %d.%m.%Y} - \t] ~ \[$Y\]\!\[$W\] ~ \[$RB\]#\#\n\[$WB\]··> \h { \j } <·· \[$W\][\[$CB\]\u\[$W\]] \[$MB\]\W\[$RESET\] \[$B\]$(gitbranch)\[$RESET\]\$ '
export PS2='\[$R\]··>\[$RESET\] '
# STDOUT
export CLICOLOR=1
export LSCOLORS=GxFxAxExBxdxDxBxBxGxGx
# LOCALE
export LANG="en_GB.UTF-8"
# export LC_ALL="en_GB.UTF-8"
export LC_ADDRESS="es_ES.UTF-8"
export LC_COLLATE="en_GB.UTF-8"
export LC_CTYPE="es_ES.UTF-8"
export LC_MONETARY="es_ES.UTF-8"
export LC_MEASUREMENT="es_ES.UTF-8"
export LC_MESSAGES="en_GB.UTF-8"
export LC_NUMERIC="en_GB.UTF-8"
export LC_PAPER="es_ES.UTF-8"
export LC_RESPONSE="en_GB.UTF-8"
export LC_TELEPHONE="es_ES.UTF-8"
export LC_TIME="es_ES.UTF-8"
# HISTORY
export HISTSIZE=777 # Number of commands in history
export HISTFILESIZE=999999 # Number of lines in file
export HISTCONTROL='ignoreboth' # Ignores repeated command & commands starting with a space
# EDITOR
export EDITOR=nano
# APPS
export APPS_ROOT="$HOME/.apps"
# SCRIPTS
export SCRIPT_ROOT="$HOME/.scripts"
# NVM
export NVM_DIR="$HOME/.nvm"
# PYENV
export PYENV_ROOT="$HOME/.pyenv"
# PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:$APPS_ROOT"
export PATH="$PATH:$SCRIPT_ROOT"
export PATH="$PATH:$NVM_DIR"
export PATH="$PATH:$PYENV_ROOT"

# === WELCOME === #
echo -e "\n $CB ··> Hi $USER! Welcome to $(basename $SHELL) $BASH_VERSINFO <·· $RESET\n"

# === LOAD FILES === #
echo -e "$CB Sourcing completion: $RESET"

# LOAD BASH COMPLETION
BASH_COMPLETION="/usr/local/share/bash-completion/bash_completion"
if [ -f $BASH_COMPLETION ]; then
	echo -e "$CB   ··>$MB bash $RESET"
	. $BASH_COMPLETION # This loads bash completion
fi

# LOAD GIT COMPLETION
GIT_COMPLETION="/usr/local/etc/bash_completion.d/git-completion.bash"
if [ -f $GIT_COMPLETION ]; then
	echo -e "$CB   ··>$MB git $RESET"
	. $GIT_COMPLETION # This loads git completion
fi

# LOAD BREW COMPLETION
BREW_COMPLETION="/usr/local/etc/bash_completion.d/brew"
if [ -f $BREW_COMPLETION ]; then
	echo -e "$CB   ··>$MB brew $RESET"
	. $BREW_COMPLETION # This loads brew completion
fi

# LOAD BREW SERVICES COMPLETION
BREW_SERVICES_COMPLETION="/usr/local/etc/bash_completion.d/brew-services"
if [ -f $BREW_SERVICES_COMPLETION ]; then
	echo -e "$CB   ··>$MB brew-services $RESET"
	. $BREW_SERVICES_COMPLETION # This loads brew-services completion
fi

# LOAD DOCKER COMPLETION
DOCKER_COMPLETION="/usr/local/etc/bash_completion.d/docker"
if [ -f $DOCKER_COMPLETION ]; then
	echo -e "$CB   ··>$MB docker $RESET"
  . $DOCKER_COMPLETION # This loads docker completion
fi

# LOAD DOCKER COMPOSE COMPLETION
DOCKER_COMPOSE_COMPLETION="/usr/local/etc/bash_completion.d/docker-compose"
if [ -f $DOCKER_COMPOSE_COMPLETION ]; then
	echo -e "$CB   ··>$MB docker-compose $RESET"
  . $DOCKER_COMPOSE_COMPLETION # This loads docker-compose completion
fi

# LOAD NVM COMPLETION
NVM_COMPLETION="/usr/local/opt/nvm/etc/bash_completion.d/nvm"
if [ -f $NVM_COMPLETION ]; then
	echo -e "$CB   ··>$MB nvm $RESET"
  . $NVM_COMPLETION  # This loads nvm completion
fi

echo -e "\n$CB Sourcing scripts: $RESET"

# LOAD BASH FILES
if [ -f "$HOME/.bash_aliases" ]; then
	echo -e "$CB   ··>$MB aliases $RESET"
	. "$HOME/.bash_aliases"
fi

if [ -f "$HOME/.bash_functions" ]; then
	echo -e "$CB   ··>$MB functions $RESET"
	. "$HOME/.bash_functions"
fi

if [ -f "$HOME/.bash_job" ]; then
	echo -e "$CB   ··>$MB job $RESET"
	. "$HOME/.bash_job"
fi

# LOAD NVM
if [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
	echo -e "$CB   ··>$MB nvm $RESET"
  . "/usr/local/opt/nvm/nvm.sh"
fi

# LOAD PYENV
if command -v pyenv 1> /dev/null 2>&1; then
	echo -e "$CB   ··>$MB pyenv $RESET"
	eval "$(pyenv init -)"
fi

echo -e "\n $CB ··> All tools were loaded, enjoy your shell <·· $RESET\n"

# LOAD BASH INIT
if [ -f "$HOME/.bash_init" ]; then
	. "$HOME/.bash_init"
fi
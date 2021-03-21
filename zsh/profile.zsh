# === === === ZSH RC === === === #

# === VARIABLES === #
NEWLINE=$'\n'
B=$(tput setaf 0); BB=$(tput setaf 8)  # BLACK
R=$(tput setaf 1); RB=$(tput setaf 9)  # RED
G=$(tput setaf 2); GB=$(tput setaf 10) # GREEN
Y=$(tput setaf 3); YB=$(tput setaf 11) # YELLOW
A=$(tput setaf 4); AB=$(tput setaf 12) # BLUE
M=$(tput setaf 5); MB=$(tput setaf 13) # MAGENTA
C=$(tput setaf 6); CB=$(tput setaf 14) # CYAN
W=$(tput setaf 7); WB=$(tput setaf 15) # WHITE
RESET=$(tput sgr0)                     # RESET

# === CONFIGURATION === #
# OPTIONS
setopt AUTO_CD # Perform 'cd' if argument in stdin is a directory instead of a command
## setopt AUTO_PUSHD # Use directory stack
## setopt PUSHD_IGNORE_DUPS # Don't save duplicate entries in the directory stack
## setopt PUSHD_TO_HOME # 'pushd' without args will work as 'pushd $HOME'
setopt NO_CASE_GLOB # Autocompletion will be case insensitive
setopt GLOB_COMPLETE # Create a cyclable menu with all autocomplete matches
setopt PROMPT_SUBST # Enable prompt function execution capabilities
# PROMPT
export PS1='%F{7}[%D{%a %d.%m.%Y - %H:%M:%S}]$NEWLINE%F{15}··> %m { %j } <·· %F{7}[%F{14}%n%F{7}] %F{13}%1~%f %F{0}$(gitbranch)%f%# '
export RPS1='%F{3}%!%F{7} ~ %(?.%F{10}√%f.%F{9}%?%f)'
export PS2='%F{1}··>%f '
export RPS2='%F{1}<··%f'
# STDOUT
export CLICOLOR=1
export LSCOLORS=GxFxAxExBxdxDxBxBxGxGx
# LOCALE
export LANG="en_GB.UTF-8"
## export LC_ALL="en_GB.UTF-8"
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
export SAVEHIST=999999 # Number of lines in file
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits
setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space
setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again
setopt HIST_SAVE_NO_DUPS # Don't write duplicate entries in the history file
# EDITOR
export EDITOR=nano
# LESS
export LESSHISTFILE="-"
# APPS
export APPS_ROOT="$HOME/.apps"
# SCRIPTS
export SCRIPT_ROOT="$HOME/.scripts"
# COMPLETIONS
export COMPLETIONS_DIR="$HOME/.completions"
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
echo -e "\n $CB ··> Hi $USER! Welcome to $(basename $SHELL) $ZSH_VERSION <·· $RESET\n"

# === LOAD FILES === #
echo -e "$CB Loading completion: $RESET"
autoload bashcompinit && bashcompinit

# LOAD ZSH COMPLETION
echo -e "$CB   ··>$MB zsh $RESET"
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SCompletion Scrolling { %l }:%s

# LOAD GIT COMPLETION
GIT_COMPLETION_ZSH="$COMPLETIONS_DIR/git-completion.zsh"
GIT_COMPLETION_BASH="$COMPLETIONS_DIR/git-completion.bash"
if [ -f $GIT_COMPLETION_ZSH ] && [ -f $GIT_COMPLETION_BASH ]; then
	echo -e "$CB   ··>$MB git $RESET"
	zstyle ':completion:*:*:git:*' script $GIT_COMPLETION_BASH
	fpath=($GIT_COMPLETION_ZSH $fpath)
fi

# LOAD DOCKER COMPLETION
DOCKER_COMPLETION="$COMPLETIONS_DIR/docker.zsh"
if [ -f $DOCKER_COMPLETION ]; then
	echo -e "$CB   ··>$MB docker $RESET"
	fpath=($DOCKER_COMPLETION $fpath)
fi

# LOAD DOCKER COMPOSE COMPLETION
DOCKER_COMPOSE_COMPLETION="$COMPLETIONS_DIR/docker-compose.zsh"
if [ -f $DOCKER_COMPOSE_COMPLETION ]; then
	echo -e "$CB   ··>$MB docker-compose $RESET"
	fpath=($DOCKER_COMPOSE_COMPLETION $fpath)
fi

autoload -Uz compinit && compinit

# LOAD BREW COMPLETION
BREW_COMPLETION="/usr/local/etc/bash_completion.d/brew"
if [ -f $BREW_COMPLETION ]; then
	echo -e "$CB   ··>$MB brew $RESET"
	. $BREW_COMPLETION
fi

# LOAD BREW SERVICES COMPLETION
BREW_SERVICES_COMPLETION="/usr/local/etc/bash_completion.d/brew-services"
if [ -f $BREW_SERVICES_COMPLETION ]; then
	echo -e "$CB   ··>$MB brew-services $RESET"
	. $BREW_SERVICES_COMPLETION
fi

# LOAD NVM COMPLETION
NVM_COMPLETION="/usr/local/opt/nvm/etc/bash_completion.d/nvm"
if [ -f $NVM_COMPLETION ]; then
	echo -e "$CB   ··>$MB nvm $RESET"
  . $NVM_COMPLETION
fi

echo -e $NEWLINE
echo -e "$CB Loading scripts: $RESET"

# LOAD ZSH FILES
if [ -f "$HOME/.zsh_aliases" ]; then
	echo -e "$CB   ··>$MB aliases $RESET"
	. "$HOME/.zsh_aliases"
fi

if [ -f "$HOME/.zsh_functions" ]; then
	echo -e "$CB   ··>$MB functions $RESET"
	. "$HOME/.zsh_functions"
fi

if [ -f "$HOME/.zsh_job" ]; then
	echo -e "$CB   ··>$MB job $RESET"
	. "$HOME/.zsh_job"
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

# LOAD ZSH INIT
if [ -f "$HOME/.zsh_init" ]; then
	. "$HOME/.zsh_init"
fi
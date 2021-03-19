# === BASH FUNCTIONS === #

# A
# B
# C
cleanup-history() {
  echo -n >"$HOME/.bash_history"
  history -c
}
# D
dos2nix() {
  FILE=$(basename "$1")
  NAME="${FILE%.*}"
  tr -d '\r' < $1 > $NAME.nix.txt
}
# E
# F
# G
gitbranch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/{ \1 }\ /'
}
gitignore() {
  PARAM="linux,macos,windows"
  if [ $# -ne 0 ]; then
    for name in $*; do
      PARAM="$PARAM,$name"
    done
    echo -e "$WB Creating '$RB.gitignore$WB' with provided values:$YB $PARAM $RESET"
  else
    echo -e "$WB Creating '$RB.gitignore$WB' with default values:$YB $PARAM $RESET"
  fi
  curl --connect-timeout 10 -f -s -L toptal.com/developers/gitignore/api/$PARAM -o .gitignore
}
# H
hosts() {
  HOSTS="/etc/hosts"
  which bat &> /dev/null
  if [ $? -eq 0 ]; then
    bat $HOSTS
  else
    which lolcat &> /dev/null
    if [ $? -eq 0 ]; then
      lolcat $HOSTS 
    else
      cat $HOSTS
    fi
  fi
}
# I
# J
# K
# L
lanconfig() {
  for ip in $(ifconfig | grep inet\ | cut -f 2 -d \ ); do
    echo -e "$WB LAN IP:$YB $ip $RESET"
  done
}
# M
# N
netconfig() {
  lanconfig
  wanconfig
}
nix2dos() {
  FILE=$(basename "$1")
  NAME="${FILE%.*}"
  sed 's/$'"/`echo \\\r`/" $1 > $NAME.dos.txt
}
# O
# P
# Q
# R
reloadbash() {
  clear
  source "$HOME/.bash_profile"
}
repoinfo() {
  git rev-parse --show-toplevel > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e "$WB ··> Name:$YB $(basename $(pwd))$RESET"
    echo -e "$WB ··> Branch:$YB $(gitbranch)$RESET"
    echo -e "$WB ··> Current changes:$RESET"
    git status -s
    regex='^[0-9]+$'
    if [[ $# -eq 0 ]]; then
      echo -e "$WB ··> Last 5 commits:$RESET"
      git log -n 5 --oneline
    elif [[ $# -eq 1 ]] && [[ $1 =~ $regex ]] && [[ $1 -gt 0 ]]; then
      echo -e "$WB ··> Last $1 commits:$RESET"
      git log -n $1 --oneline
    else
      echo -e "\n$RB[ERROR] Remember to pass only one positive integer as parameter$RESET\n"
      echo -e "$WB ··> Last 5 commits:$RESET"
      git log -n 5 --oneline
    fi
    echo
  else
    echo -e "$RB[ERROR] There's no repository here $RESET"
  fi
}
# S
# T
# U
update_terminal_cwd() { 
  # Workaround to solve command not found in the editors integrated terminals 
  # Identify the directory using a "file:" scheme URL,
  # including the host name to disambiguate local vs.
  # remote connections. Percent-escape spaces.
  local SEARCH=' '
  local REPLACE='%20'
  local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
  printf '\e]7;%s\a' "$PWD_URL"
}
# V
# W
wanconfig() {
  echo -e "$WB WAN IP:$YB $(curl --connect-timeout 10 -f -s -L ident.me)$RESET"
}
weather() {
  CITY=$(echo $@ | sed 's/\ /%20/g')
  curl --connect-timeout 10 -f -s -L wttr.in/$CITY
}
# X
# Y
# Z
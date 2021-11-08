source /usr/local/etc/profile.d/bash_completion.sh
#export FIGNORE="$FIGNORE:DS_Store:ds_store"

shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s direxpand
shopt -s dirspell
shopt -s no_empty_cmd_completion
shopt -s globstar


export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)

export c0='\033[38;5;0m'  # black
export c1='\033[38;5;1m'  # red
export c2='\033[38;5;2m'  # green
export c3='\033[38;5;3m'  # yellow
export c4='\033[38;5;4m'  # blue
export c5='\033[38;5;5m'  # purple
export c6='\033[38;5;6m'  # cyan
export c7='\033[38;5;7m'  # white

export cb='\033[1m'       # bold
export cd='\033[2m'       # dim
export cr='\033[0m'       # reset

export cs='\033[2J'       # clear screen
export el='\033[0K'       # clear to end of line
export ci='\033[?25l'     # cursor inv
export cv='\033[?25h'     # cursor vis
export wd='\033[=7l'      # wrap dis
export we='\033[=7h'      # wrap ena


export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=gxdxdxdxdxdxdxdxdxgxgx
export LS_COLORS='di=36:fi=33:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=90:*.rpm=90'
export GREP_OPTIONS='--color=auto'


export PATH=~/.mac/bin:$PATH
export PS1="\[$c0\]\w \[$cr\]"

export XDG_CONFIG_HOME=~/.mac/cfg
export XDG_DATA_HOME=~/.mac/sha

export INPUTRC=~/.mac/cfg/inputrc
export NETRC=~/.mac/cfg/netrc
export TMPDIR=/tmp

export FZF_DEFAULT_COMMAND='fd -tf --exclude .git'
export GOPATH=~/.mac/go
export HOMEBREW_NO_ANALYTICS=1
export HTOPRC=~/.mac/cfg/htoprc
export MYVIMRC=~/.vim/vimrc
export PARALLEL_HOME=~/.mac/cfg/parallel
export PIP_CONFIG_FILE=~/.mac/cfg/piprc
export XONSHRC=~/.mac/cfg



export de=~/Desktop
export dc=~/Documents
export dw=~/Downloads
export lb=~/Library
export ss=~/.mac/bin

export aa=~/Public/acm
export ww=~/Public/web
export xr=/tmp/xr
export xs=/tmp/xs


alias de='cd $de'
alias dc='cd $dc'
alias dw='cd $dw'
alias aa='cd $aa'
alias ww='cd $ww'
alias ss='cd $ss'

alias la='ls -A'
alias ll='ls -oh'
alias lf='ll -O'
alias al='ll -A'
alias lt='ll -rt'
alias lx='ll -rS'

alias ..='cd ..'
alias cp='cp -r'
alias rm='rm -r'

alias cx='lsof -P -i -n'
alias mo='less'
alias tf='tail -f'
alias tm='sudo sysctl debug.lowpri_throttle_enabled=0'
alias tw='tail -f /var/log/wifi.log'
alias tx='tmux -f ~/.mac/cfg/tmux/tmux.conf'
alias wv='fd -Htf -E *.log . -X rg robbie'



function ar {
  [[ -z $1 ]] && return
  tar cf ${1%.*}.tar --no-mac-metadata $1
}

function az {
  [[ -z $1 ]] && return
  zip -rq ${1%.*}.zip $1
}

function ax {
  [[ -z $1 ]] && return
  case "${1##*.}" in
    tar) tar -kxf $1 ;;
    zip) unzip -nqq $1 ;;
  esac
}

function di {
  df -m | rg "k1|bb" | awk '{printf "%-30s %9d '$cd'%9d '$cr'%5s\n",$9,$3,$4,$5}'
}

function dm {
  fd -I$2 -d1 . $1 -x du -sk | sort -k2 | awk '{a=$1/1024} {s+=a} \
    {printf "'$cd'%15.1f'$cr' ",a; $1=""; sub($1,"")}1 \
    END {printf "%15.1f\n",s}'
}

function ds {
  dm $1 $2 | sort -k1n
}

function dx {
  sudo fd -I$2 -d1 . $1 -x du -sk | sort -k2 | awk '{a=$1/1024} {s+=a} \
    {printf "'$cd'%15.1f'$cr' ",a; $1=""; sub($1,"")}1 \
    END {printf "%15.1f\n",s}'
}

function ea {
  [[ $(pwd) == ~ ]] && return
  xattr -rc ${1:-.}
}

function ee {
  fd -Htf ".ds_store|.localize|thumbs.db" ${1:-.} -X rm
}

function ib {
  [[ ${#1} -ne 3 || ${#2} -ne 3 ]] && return
  #echo $(egrep --color=none -o "$1....|$2...." ~/.mac/cfg/ibrc | cut -c5-7)
  echo $(rg -o "$1....|$2...." ~/.mac/cfg/ibrc | paste - - | cut -c5-7,13-15)
}

function hh {
  history | awk '{ print substr($0, length($1 $2) + 3) }' | sort | uniq -c | sort -rn | head -50
}

function lc {
  ls "$@" | nl -nrn | column -t | column
}

function gp {
  ps -eco "pid,comm" | rg $1 | awk '{print $1}'
}

function md {
  [[ -z $1 ]] && return
  mkdir -p $1 && chmod 700 $1
}

function oo {
  open ${@:-.}
}

function ql {
  fd -tf -p "$1" -X qlmanage -p &>/dev/null
}

function sn {
  tput civis
  local x="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
  while kill -0 $! 2>&-; do i=$(((i+1)%10)); printf "\r${x:$i:1} "$@""; sleep .1; done
  echo
  tput cnorm
}

function tt {
  [[ -z $2 ]] && t=$(date '+%Y%m%d0000') || t=$2"0000"
  fd -d1 -p $1 -X touch -amt $t
}

function um {
  tput clear
  umx -a
  tput cup $(tput lines) 0
}

function wf {
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I
}

function ws {
  open ~/.mac/twx/tws.app
  while [[ ! -f ~/.hwid || ! -d ~/.oracle_jre_usage ]]; do sleep 1; done
  rm -rf ~/{.hwid,.oracle_jre_usage,.2021*}
}

function xm {
  mkdir -p $xr $xs
  #sudo kextload /System/Library/Extensions/smbfs.kext
  mount -t smbfs smb://robbie:w00dpecker@10.0.0.100/robbie $xr 2>&-
  mount -t smbfs smb://robbie:w00dpecker@10.0.0.100/shared $xs 2>&-
  cd $xs
}

function xu {
  cd $HOME
  umount -f $xr $xs 2>&-
}

export -f ar ea ee gp ql sn wf

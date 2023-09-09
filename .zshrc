# ~/.zshrc

export PATH=/home/ed/.local/bin:$PATH

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=8000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit promptinit colors zcalc tetris zed vcs_info
colors
compinit
promptinit;
#SPROMPT=$'%{\e[91m%п·я┬п╦п╠п╨п╟! п▓я▀ я┘п╬я┌п╣п╩п╦ п╡п╡п╣я│я┌п╦ %r п╡п╪п╣я│я┌п╬ %R? ([Y]es/[N]o/[E]dit/[A]bort)%{\e[0m%}'
# End of lines added by compinstall

autoload -U zutil
autoload -U complist

# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt NO_EQUALS
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME# tries to resume command of same name
unsetopt BG_NICE        # do NOT nice bg commands
setopt CORRECT          # command CORRECTION
setopt EXTENDED_HISTORY # puts timestamps in the history
# setopt HASH_CMDS# turns on hashing
#
setopt MENUCOMPLETE
setopt ALL_EXPORT
# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash
# turn off correction for proper commands
unsetopt correctall

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
######## zmodload -ap zsh/mapfile mapfile

export LANG="en_US.UTF-8"

#####

# bindkey '\e[A' history-search-backward
# bindkey '\e[B' history-search-forward

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# bindkey '^R' history-search-backward
# bindkey '^S' history-search-forward

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# bindkey -M isearch '^R' history-incremental-search-backward
# bindkey -M isearch '^S' history-incremental-search-forward

bindkey '^K' kill-whole-line
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[H" beginning-of-line # Home (xorg)
bindkey "\e[1~" beginning-of-line # Home (console)
bindkey "\e[4~" end-of-line # End (console)
bindkey "\e[F" end-of-line # End (xorg)
bindkey "`echotc kP`" history-beginning-search-backward # Page Up
bindkey "`echotc kN`" history-beginning-search-forward # Page Down

bindkey "\e[2~" overwrite-mode # Ins
bindkey "\e[3~" delete-char # Delete
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
bindkey ';5D' backward-word # Ctrl+left 
bindkey ';5C' forward-word # Ctrl+right
bindkey "`echotc ku`" up-line-or-history # up
bindkey "`echotc kd`" down-line-or-history # down
bindkey "`echotc kr`" forward-char # Right
bindkey "`echotc kl`" backward-char # Left
bindkey '[D' backward-word # Alt+left
bindkey '[C' forward-word # Alt+right
bindkey '[3~' delete-word # Alt+Del  почему-то это блокирует простой Del

# Resource files

alias grep='egrep -s --colour=auto'
alias tree='tree -C'
alias ls='ls -F -h'
alias ll='ls -l'
alias la='ls -a'
alias cp='cp -viR'
alias mv='mv -vi'
alias rm='rm -viR'
alias md='mkdir -p -v'
alias df='df -h'
alias du='du -h'
alias burndvd='growisofs -Z /dev/dvdrw -R -J'
alias burndvdISO='growisofs -dvd-compat -Z /dev/dvdrw='
alias burncd='mkisofs -r -f -jcharset=cp1251 -C $(cdrecord dev=/dev/cdrw -msinfo) -M /dev/cdrw $HOME/forburn/ | cdrecord --speed=4 -v -multi driveropts=burnfree -eject dev=/dev/cdrw -'
alias burncdISO='cdrecord --speed=4 -v -multi driveropts=burnfree -eject dev=/dev/cdrw'
alias blankcd='cdrecord --dev=/dev/cdrw --blank=fast'
alias wget='wget --no-check-certificate'
alias wgetp='wgetpaste -rXvt'
alias zip="zip -r"

# EDITOR
export EDITOR="nvim"

#------------------------------------------////
# Color man pages:
#------------------------------------------////

#export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
#export LESS_TERMCAP_md=$'\E[01;31m'      # begin bold
#export LESS_TERMCAP_me=$'\E[0m'          # end mode
#export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
#export LESS_TERMCAP_so=$'\E[01;44;33m'   # begin standout-mode - info box
#export LESS_TERMCAP_ue=$'\E[0m'          # end underline
#export LESS_TERMCAP_us=$'\E[01;32m'      # begin underline

export MANPATH=~/.local/share/man:$MANPATH

setopt prompt_subst
# Configuring vcs_info
zstyle ':vcs_info:*' stagedstr "%{$fg_bold[green]%}~"
zstyle ':vcs_info:*' unstagedstr "%{$fg_bold[yellow]%}+"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' branchformat '%b-%r'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
# hash changes branch misc
# Git

# zstyle ':vcs_info:git*' formats "[%{$fg[yellow]%}%12.12i%{$reset_color%} %u %{$fg[magenta]%}%b%{$reset_color%}%m] "
# zstyle ':vcs_info:git*' formats '[%F{green}%b%c%u%F{red}●%F{blue}] '
############# zstyle ':vcs_info:git*' actionformats "(%a)[%{$fg[yellow]%}%12.12i%{$reset_color%} %u %{$fg[magenta]%}%b%{$reset_color%}%m]"
#  zstyle ':vcs_info:git*' formats "%s  %r/%S %b %m%u%c "#  zstyle ':vcs_info:git*' formats "(%s)[%12.12i %u %b %m]"
#  zstyle ':vcs_info:git*' formats "%{$fg[grey]%}%s %{$reset_color%}%r/%S%{$fg[grey]%} %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%} "
#  zstyle ':vcs_info:git*' actionformats "(%s|%a)[%12.12i %u %b %m]"
# Mercurial
# zstyle ':vcs_info:hg*' formats "(%s)[%i%u %b %m]"
zstyle ':vcs_info:hg*' actionformats "(%s|%a)[%i%u %b %m]"
zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:(hg*|git*):*' check-for-changes true
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:hg*:*' get-mq true
zstyle ':vcs_info:hg*:*' get-unapplied true
zstyle ':vcs_info:hg*:*' patch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:hg*:*' nopatch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:(hg*|git*):*' stagedstr "%{$fg_bold[green]%}~"
zstyle ':vcs_info:(hg*|git*):*' unstagedstr "%{$fg_bold[yellow]%}+"
zstyle ':vcs_info:hg*:*' hgrevformat "%r" # only show local rev.
zstyle ':vcs_info:hg*:*' branchformat "%b" # only show branch


# use version control info - for prompt
zstyle ':vcs_info:*' enable git svn cvs hg bzr darcs

vcs_info_wrapper() {
    # if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    #         zstyle ':vcs_info:git*' formats '[%F{green}%b%c%u%F{blue}] '
    # } else {
    zstyle ':vcs_info:*' formats "%{$fg_bold[white]%}[%{$reset_color%}%{$fg[green]%}%b%c%u%{$fg_bold[red]%}!%{$fg_bold[white]%}]"
    #}
    vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
	echo "%{$fg_bold[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    fi
}

## or use pre_cmd, see man zshcontrib
# precmd() {
#     vcs_info
# }
# precmd () {
#     if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
#             zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{blue}]'
# } else {
#             zstyle ':vcs_info:*' formats ' [%F{green}%b%c%u%F{red}•%F{blue}]'
# }
# vcs_info
# }


# Prompt
if [[ $EUID == 0 ]]
then
    PROMPT='$(vcs_info_wrapper)%{$fg_bold[grey]$bg[white]%} %T %D{%a} %D{%Y-%m-%d} %{$fg_bold[black]$bg[red]%} %~ %{$fg_bold[white]%}]%{$reset_color%} '  # root dir #
else
    PROMPT='$(vcs_info_wrapper)%{$fg_bold[grey]$bg[white]%} %T %D{%a} %D{%Y-%m-%d} %{$fg_bold[black]$bg[green]%} %~ %{$fg_bold[white]%}>%{$reset_color%} '  # user dir #
fi

# Set xterm title
case $TERM in (xterm*|rxvt)
precmd () { print -Pn "\e]0;%n@%m: %~\a" }
preexec () { print -Pn "\e]0;%n@%m: $1\a" }
;;
esac

# Grep colors
#GREP_OPTIONS='--color=auto'
#GREP_COLOR='5;38' #п╪п╦пЁп╟я▌я┴п╦п╧
GREP_COLOR='1;33' #я▐я─п╨п╬-п╤п╣п╩я┌я▀п╧ п╫п╟ я┤п╣я─п╫п╬п╪
#export GREP_OPTIONS GREP_COLOR

zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

#Errors red
#exec 2>>(while read line; do
#          print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &)

#set -B


zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
# zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
# zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:

# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# Filename suffixes to ignore during completion (except after rm command)
# zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
#     '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
# zstyle ':completion:*:functions' ignored-patterns '_*'
# zstyle ':completion:*:*:*:users' ignored-patterns \
#         adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
#         named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
#         rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
#         avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
#         firebird gnats haldaemon hplip irc klog list man cupsys postfix\
#         proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# custom terminfo
LOCAL_TERMINFO=$HOME/.terminfo
if [ -d $LOCAL_TERMINFO ]; then
    export TERMINFO=$LOCAL_TERMINFO
fi

# Add RVM to PATH for scripting
export PATH=$PATH:$HOME/.rvm/bin

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

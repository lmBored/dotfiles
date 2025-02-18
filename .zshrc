# This and the zprof at the end of the file is to show which function takes the most time to startup: https://stevenvanbael.com/profiling-zsh-startup
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# cmatrix -ba -C blue
# echo "H e l l o !" | figlet | lolcat
# neofetch --ascii ~/.config/neofetch/logo | lolcat

# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#==================================================================

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias gcc="gcc-12"
# alias g++="g++-12"
# alias cpp="cpp-12"
# alias c++="c++-12"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formatse
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf-tab fzf-tab-source zsh-autosuggestions fast-syntax-highlighting)

# Optimize autocompletion startup
autoload -Uz compinit
if [[ -n ${HOME}/.cache/zsh/zcompdump-$ZSH_VERSION(#qN.mh+24) ]]; then
    compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
else
    compinit -C -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
fi

# source omz
source $ZSH/oh-my-zsh.sh

# Source gruvbox
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#bindkey '\t' autosuggest-accept

# fzf
source <(fzf --zsh)
[ -f ~/.fzf.zsh ]
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export PATH=/Users/master/apache-maven-3.9.6/bin:$PATH
export PATH=${PATH}:/usr/local/mysql/bin
path+="$HOME/.emacs.d/bin"

[ -f "/Users/master/.ghcup/env" ] && . "/Users/master/.ghcup/env" # ghcup-env
. "$HOME/.cargo/env"

# Alias for jupyter notebook converter to html for preview:
alias jnbhtml="jupyter nbconvert --ExecutePreprocessor.timeout=600 --to html"

# some more ls aliases
alias ll="ls -l"
alias la="ls -A"
#alias l='ls -CF'

# Aliases for common dirs
alias home="cd ~"

# System Aliases
alias ..="cd .."
alias x="exit"

# Git Aliases
alias add="git add"
alias commit="git commit"
alias pull="git pull"
alias vdiff="git difftool HEAD"
alias cfg="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias push="git push"
alias g="lazygit"

alias ssh="TERM=xterm-256color ssh"
alias vtree="tree -C | less -R"
alias mysql.server="sudo /usr/local/mysql/support-files/mysql.server"
export LC_ALL="en_US.UTF-8" # To fix https://github.com/withfig/fig/issues/2484
alias bvim='vim $(fzf --preview="bat --color=always {}")'
# alias neofetch="neofetch --backend iterm2 --ascii ~/.config/neofetch/logo"
# setup conda environment by choice to decrese startup time
alias condainit='eval "$(/Users/master/anaconda3/bin/conda shell.zsh hook)"'

# Cool git diff with fzf
gdiff() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}

is_in_git_repo() {
    # git rev-parse HEAD > /dev/null 2>&1
    git rev-parse HEAD > /dev/null
}

# Filter branches.
gbranchh() {
    is_in_git_repo || return

    local tags branches target
    tags=$(
	git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
	git branch --all | grep -v HEAD |
	    sed "s/.* //" | sed "s#remotes/[^/]*/##" |
	    sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
	(echo "$tags"; echo "$branches") |
	    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
		--ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
    echo $(echo "$target" | awk -F "\t" '{print $2}')
}

# Filter branches and checkout the selected one with <enter> key,
gcheckoutt() {
    is_in_git_repo || return
    git checkout $(git-br-fzf)
}

# Filter commit logs. The diff is shown on the preview window.
glogg() { # fshow - git commit browser
    is_in_git_repo || return

    _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always %'"
    git log --graph --color=always \
	--format="%C(auto)%h%d [%an] %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
	--preview="$_viewGitLogLine" \
	--bind "ctrl-m:execute:
		(grep -o '[a-f0-9]\{7\}' | head -1 |
		xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
		{}
FZF-EOF"
}

function gitac() {
    if [ -n "$ZSH_VERSION" ]; then
        echo -n "Enter commit message: "
        read commit_msg
    else
        read -p "Enter commit message: " commit_msg
    fi
    git add . && git commit -m "$commit_msg"
}

function gitacp() {
    if [ -n "$ZSH_VERSION" ]; then
        echo -n "Enter commit message: "
        read commit_msg
    else
        read -p "Enter commit message: " commit_msg
    fi
    git add . && git commit -m "$commit_msg" && git push
}

# Increase minimum fzf-preview height for fzf-tab
zstyle ':fzf-tab:*' fzf-min-height 20
# Add preview for flags and subcommands
zstyle ':fzf-tab:complete:*:options' fzf-preview '/usr/bin/echo Description:; /usr/bin/echo option: $desc | sed -e "s/\s\{2,\}/\n/g"'
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview '/usr/bin/echo Description:; /usr/bin/echo option: $desc | sed -e "s/\s\{2,\}/\n/g"'
# Add continuous trigger when completing path
zstyle ':fzf-tab:*' continuous-trigger ';'
# enable hidden in zsh completion
setopt globdots
# disable . and .. directories in completion (enabled by omz)
zstyle ':completion:*' special-dirs false
zstyle ':completion:*:descriptions' format '[%d]'

export PATH=$PATH:/Users/master/.spicetify

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Zoxide
eval "$(zoxide init zsh)"
export _ZO_ECHO='1'

# Navi
eval "$(navi widget zsh)"

# eza
alias ls="eza -a -l --git --hyperlink --header -g -F -s type"

# lazygit 
# (Function to consider even though rarely used: github.com/jesseduffield/lazygit?tab=readme-ov-file#changing-directory-on-exit)
alias lg='lazygit' 

function suyabai () {
  SHA256=$(shasum -a 256 /opt/homebrew/bin/yabai | awk "{print \$1;}")
  if [ -f "/private/etc/sudoers.d/yabai" ]; then
    sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${SHA256}'/' /private/etc/sudoers.d/yabai
  else
    echo "sudoers file does not exist yet"
  fi
}

# Color Scheme
export BLACK=0xff181819
export WHITE=0xffe2e2e3
export RED=0xfffc5d7c
export GREEN=0xff9ed072
export BLUE=0xff76cce0
export YELLOW=0xffe7c664
export ORANGE=0xfff39660
export MAGENTA=0xffb39df3
export GREY=0xff7f8490
export TRANSPARENT=0x00000000
export BG0=0xff2c2e34
export BG1=0xff363944
export BG2=0xff414550

# Only load conda into path but dont actually use the bloat that comes with it
# export PATH="$HOME/miniforge3/bin:/usr/local/anaconda3/bin:$PATH:$(brew --prefix)/opt/llvm/bin"

# copy paste https://stackoverflow.com/questions/5130968/how-can-i-copy-the-output-of-a-command-directly-into-my-clipboard
alias "c=pbcopy"
alias "v=pbpaste"

# zprof

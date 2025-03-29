# This and the zprof at the end of the file is to show which function takes the most time to startup: https://stevenvanbael.com/profiling-zsh-startup
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

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
# autoload -Uz compinit
# if [[ -n ${HOME}/.cache/zsh/zcompdump-$ZSH_VERSION(#qN.mh+24) ]]; then
#     compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
# else
#     compinit -C -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
# fi

# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206
() {
  setopt local_options

  local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  local zcomp_ttl=1  # how many days to let the zcompdump file live before it must be recompiled
  local lock_timeout=1  # register an error if lock-timeout exceeded
  local lockfile="${zcompdump}.lock"

  autoload -Uz compinit

  # check for lockfile — if the lockfile exists, we cannot run a compinit
  #   if no lockfile, then we will create one, and set a trap on EXIT to remove it;
  #   the trap will trigger after the rest of the function has run.
  if [ -f "${lockfile}" ]
  then

    # error log if the lockfile outlived its timeout
    if [ "$( find "${lockfile}" -mmin $lock_timeout )" ]
    then
      (
        echo "${lockfile} has been held by $(< ${lockfile}) for longer than ${lock_timeout} minute(s)."
        echo "This may indicate a problem with compinit"
      ) >&2
    fi

    # since the zcompdump is still locked, run compinit without generating a new dump
    compinit -D -d "$zcompdump"

    # Exit if there's a lockfile; another process is handling things
    return 1

  else

    # Create the lockfile with this shell's PID for debugging
    echo $$ > "${lockfile}"

    # Ensure the lockfile is removed on exit
    trap "rm -f '${lockfile}'" EXIT

  fi


  # refresh the zcompdump file if needed
  if [ ! -f "$zcompdump" -o "$( find "$zcompdump" -mtime "+${zcomp_ttl}" )" ]
  then
    # if the zcompdump is expired (past its ttl) or absent, we rebuild it
    compinit -d "$zcompdump"

  else

    # load the zcompdump without updating
    compinit -CD -d "$zcompdump"

    # asynchronously rebuild the zcompdump file
    (autoload -Uz compinit; compinit -d "$zcompdump" &);

  fi
}

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

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Dracula theme
export FZF_DEFAULT_OPTS=' --ansi --no-height --no-reverse --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#c6a0f6,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
# Catppuccin macchiato theme
# export FZF_DEFAULT_OPTS=" --ansi --no-height --no-reverse \
# --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
# --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
# --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
# --color=selected-bg:#494d64 \
# --color=border:#363a4f,label:#cad3f5"
export FZF_TMUX_OPTS='-p63%,75%'
export FZF_CTRL_T_OPTS="
  --wrap
  --select-1 --exit-0
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# ripgrep->fzf->vim [QUERY]
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

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

# integrate fzf with zoxide entries https://github.com/ajeetdsouza/zoxide/discussions/1007
# function zoxide_fzf() {
#     # Preserve original buffer content
#     local orig_buffer=$LBUFFER
#     local selection

#     # Run fzf, return if canceled (ESC pressed)
#     selection=$(zoxide query --list | fzf --height 40% --reverse --border) || {
#         LBUFFER=$orig_buffer
#         zle redisplay
#         return 0
#     }

#     # Append selection if valid
#     if [[ -n "$selection" ]]; then
#         LBUFFER+="$selection"
#         zle redisplay
#     fi
# }

function zoxide_fzf() {
    # Preserve original command line buffer
    local orig_buffer=$LBUFFER
    local selection

    # Run zoxide through fzf with eza preview.
    # The preview command checks if the item is a directory and uses eza to list its contents.
    selection=$(
        zoxide query --list | fzf \
            --wrap \
            --height 45% \
            --reverse \
            --border \
            --preview 'if [[ -d {} ]]; then eza -a -l --git --hyperlink --header -g -F -s type --color=always {}; else eza -a -l --git --hyperlink --header -g -F -s type --color=always {}; fi' \
            --preview-window='right:50%:wrap'
    ) || {
        LBUFFER=$orig_buffer
        zle redisplay
        return 0
    }

    # If a selection is made, append it to the command line.
    if [[ -n "$selection" ]]; then
        LBUFFER+="$selection"
        zle redisplay
    fi
}

zle -N zoxide_fzf
bindkey '^k' zoxide_fzf

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

# Create and cd into directory
mkcd() { mkdir -p "$1" && cd "$1"; }

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

if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi

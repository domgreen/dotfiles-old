# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [ "$TMUX" = "" ]; then tmux; fi

# Path to your oh-my-zsh installation.
export ZSH="/home/dominic/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  kubectl
  zsh-autosuggestions
  helm
)

source $ZSH/oh-my-zsh.sh
eval "$(direnv hook zsh)"
export PATH="$PATH:/improbable/tools/latest/linux"
export PATH="$PATH:/usr/local/go/bin"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$GOBIN"
export PATH="$PATH:/home/dominic/istio-1.4.3/bin"

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#compdef _kind kind


function _kind {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "build:Build one of [base-image, node-image]"
      "completion:Output shell completion code for the specified shell (bash or zsh)"
      "create:Creates one of [cluster]"
      "delete:Deletes one of [cluster]"
      "export:exports one of [kubeconfig, logs]"
      "get:Gets one of [clusters, nodes, kubeconfig]"
      "help:Help about any command"
      "load:Loads images into nodes"
      "version:prints the kind CLI version"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  build)
    _kind_build
    ;;
  completion)
    _kind_completion
    ;;
  create)
    _kind_create
    ;;
  delete)
    _kind_delete
    ;;
  export)
    _kind_export
    ;;
  get)
    _kind_get
    ;;
  help)
    _kind_help
    ;;
  load)
    _kind_load
    ;;
  version)
    _kind_version
    ;;
  esac
}


function _kind_build {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "base-image:build the base node image"
      "node-image:build the node image"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  base-image)
    _kind_build_base-image
    ;;
  node-image)
    _kind_build_node-image
    ;;
  esac
}

function _kind_build_base-image {
  _arguments \
    '--image[name:tag of the resulting image to be built]:' \
    '--source[path to the base image sources, autodetected by default]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_build_node-image {
  _arguments \
    '--base-image[name:tag of the base image to use for the build]:' \
    '--image[name:tag of the resulting image to be built]:' \
    '--kube-root[Path to the Kubernetes source directory (if empty, the path is autodetected)]:' \
    '--type[build type, one of [bazel, docker]]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}


function _kind_completion {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "bash:Output shell completions for bash"
      "zsh:Output shell completions for zsh"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  bash)
    _kind_completion_bash
    ;;
  zsh)
    _kind_completion_zsh
    ;;
  esac
}

function _kind_completion_bash {
  _arguments \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_completion_zsh {
  _arguments \
    '(-h --help)'{-h,--help}'[help for zsh]' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}


function _kind_create {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "cluster:Creates a local Kubernetes cluster"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  cluster)
    _kind_create_cluster
    ;;
  esac
}

function _kind_create_cluster {
  _arguments \
    '--config[path to a kind config file]:' \
    '--image[node docker image to use for booting the cluster]:' \
    '--kubeconfig[sets kubeconfig path instead of $KUBECONFIG or $HOME/.kube/config]:' \
    '--name[cluster context name]:' \
    '--retain[retain nodes for debugging when cluster creation fails]' \
    '--wait[Wait for control plane node to be ready (default 0s)]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}


function _kind_delete {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "cluster:Deletes a cluster"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  cluster)
    _kind_delete_cluster
    ;;
  esac
}

function _kind_delete_cluster {
  _arguments \
    '--kubeconfig[sets kubeconfig path instead of $KUBECONFIG or $HOME/.kube/config]:' \
    '--name[the cluster name]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}


function _kind_export {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "kubeconfig:exports cluster kubeconfig"
      "logs:exports logs to a tempdir or [output-dir] if specified"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  kubeconfig)
    _kind_export_kubeconfig
    ;;
  logs)
    _kind_export_logs
    ;;
  esac
}

function _kind_export_kubeconfig {
  _arguments \
    '--kubeconfig[sets kubeconfig path instead of $KUBECONFIG or $HOME/.kube/config]:' \
    '--name[the cluster context name]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_export_logs {
  _arguments \
    '--name[the cluster context name]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}


function _kind_get {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "clusters:lists existing kind clusters by their name"
      "kubeconfig:prints cluster kubeconfig"
      "kubeconfig-path:DEPRECATED: prints the default kubeconfig path for the kind cluster by --name"
      "nodes:lists existing kind nodes by their name"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  clusters)
    _kind_get_clusters
    ;;
  kubeconfig)
    _kind_get_kubeconfig
    ;;
  kubeconfig-path)
    _kind_get_kubeconfig-path
    ;;
  nodes)
    _kind_get_nodes
    ;;
  esac
}

function _kind_get_clusters {
  _arguments \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_get_kubeconfig {
  _arguments \
    '--internal[use internal address instead of external]' \
    '--name[the cluster context name]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_get_kubeconfig-path {
  _arguments \
    '--name[the cluster context name]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_get_nodes {
  _arguments \
    '--name[the cluster context name]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_help {
  _arguments \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}


function _kind_load {
  local -a commands

  _arguments -C \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "docker-image:loads docker image from host into nodes"
      "image-archive:loads docker image from archive into nodes"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  docker-image)
    _kind_load_docker-image
    ;;
  image-archive)
    _kind_load_image-archive
    ;;
  esac
}

function _kind_load_docker-image {
  _arguments \
    '--name[the cluster context name]:' \
    '*--nodes[comma separated list of nodes to load images into]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_load_image-archive {
  _arguments \
    '--name[the cluster context name]:' \
    '*--nodes[comma separated list of nodes to load images into]:' \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

function _kind_version {
  _arguments \
    '--loglevel[DEPRECATED: see -v instead]:' \
    '(-q --quiet)'{-q,--quiet}'[silence all stderr output]' \
    '(-v --verbosity)'{-v,--verbosity}'[info log verbosity]:'
}

alias top='htop'
alias vim="nvim"

# https://github.com/ogham/exa
alias ls='exa'
alias l='exa -l --icons'
alias lla='exa -la'
alias lt='exa -T --icons'

# enable fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export _start=0
export TERMONITOR=0
function startTime () {
   if (( ${TERMONITOR}!=0 )); then
	_start=$(($(date +%s%N)/1000000))
   fi
}

function postCmd () {
   CODE=$?
   if (( ${TERMONITOR}!=0 )); then
     if (( $_start > 0 )); then
       _end=$(($(date +%s%N)/1000000))
       echo "{ \"timestamp_ms\": \"$_start\", \"duration_ms\": \"$((_end-_start))\", \"code\": $CODE, \"cmd\": \"$(history | tail -1 | head -1 | cut -c8-999)\", \"user\":\"$USER\", \"host\":\"$HOST\" }" >> $HOME/.termonitor
     fi
   fi
}

export PATH="${HOME}/.pyenv/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

add-zsh-hook preexec startTime
add-zsh-hook precmd postCmd

eval "$(/opt/homebrew/bin/brew shellenv)"

###
# CLICOLOR=1 simply enables coloring of your terminal.
# LSCOLORS=... specifies how to color specific items.
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

###

### ALIASES ###
# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Get the url of the git repo in the current folder, from command line
alias url="git config --get remote.origin.url"

# Get current logged in user's info on CLI
alias gc="git config --list"

# The provided alias script sets up shortcuts for making HTTP requests using the lwp-request command from the libwww-perl library. Example Usage
# After running this script, you can use the HTTP methods directly as commands in the terminal to make HTTP requests. For example:
# GET http://example.com will run lwp-request -m 'GET' http://example.com
# POST http://example.com will run lwp-request -m 'POST' http://example.com
# This setup simplifies making HTTP requests by allowing you to use intuitive command names (the HTTP methods themselves) instead of typing out the full lwp-request command each time.
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done
alias deid='ssh akr4007@vdcorep033.med.cornell.edu'

### ALIASES ENDS ###


export M2_HOME=/Volumes/Akhil/apache-maven-3.8.4
export PATH=$PATH:$M2_HOME/bin
export ANDROID_HOME=/Users/akhil/Library/Android/sdk
export error_webhook=""
export PYSPARK_PYTHON="/Users/akhil/anaconda3/envs/dsw_assign_2/bin/python"
export PYSPARK_DRIVER_PYTHON="/Users/akhil/anaconda3/envs/dsw_assign_2/bin/python"

#export hts='root@65.21.185.206'
#export SCALA_HOME="/usr/local/scala"
#export PATH=$PATH:$SCALA_HOME/bin

export NODE_OPTIONS=--max_old_space_size=4096

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

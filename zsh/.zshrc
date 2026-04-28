# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export EDITOR="nvim"

# Plugins
plugins=(
    git 
    zsh-autosuggestions
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

bindkey '^@' autosuggest-accept

git_remote_check() {
    local is_ssh is_https
    is_ssh=$(git config --global --get-all url.git@github.com:.insteadOf)
    is_https=$(git config --global --get-all url."https://github.com/".insteadOf)

    if [[ -n "$is_ssh" ]]; then
        echo "ssh"
    elif [[ -n "$is_https" ]]; then
        echo "https"
    else
        echo "none"
    fi
}

git_remote_toggle() {
    local current
    current=$(git_remote_check)

    case $current in
        ssh)
            echo "switching to https"
            git config --global --unset-all url.git@github.com:.insteadOf
            git config --global url."https://github.com/".insteadOf git@github.com:
            ;;
        https)
            echo "switching to ssh"
            git config --global --unset-all url."https://github.com/".insteadOf
            git config --global url.git@github.com:.insteadOf https://github.com/
            ;;
        none)
            echo "nothing set. defaulting to ssh"
            git config --global url.git@github.com:.insteadOf https://github.com/
            ;;
    esac
}

sync_zsh() {
    rsync -av --progress $HOME/.zshrc $HOME/.config/zsh/
    rsync -av --progress $HOME/.zprofile $HOME/.config/zsh/
}

reload_zsh() {
    source ~/.zshrc
    source ~/.zprofile
}

# Aliases -- CLI Stuff
alias ff='clear && fastfetch --logo "ubuntu sway"'
alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias zprofile="vim ~/.zprofile"
alias reload=reload_zsh
alias bat="batcat"
alias python3=/usr/bin/python3.12
alias zsync="sync_zsh"
alias ll="lsd -l"

# Easier paths
alias home="cd $HOME"
alias dev="cd $HOME/dev/"
alias cdrive="cd /mnt/c/"
alias onedrive="cd /mnt/c/Users/mitchella/OneDrive\ -\ Milwaukee\ School\ of\ Engineering"
alias star="cd $HOME/.config/starship"
alias dotfiles="cd $HOME/.config/"

# git aliases
alias gp="git push"
alias gc="git checkout"
alias gl="git log --oneline --decorate"
alias gs="git status"
alias ghcreate="gh repo create --private --source=. --remote-origin && git push -u --all && gh browse"
alias gt="git_remote_toggle"
alias check="git_remote_check"

nvm_lazy_load() {
  unset -f node npm npx nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

node() { nvm_lazy_load; node "$@"; }
npm()  { nvm_lazy_load; npm "$@"; }
npx()  { nvm_lazy_load; npx "$@"; }
nvm()  { nvm_lazy_load; nvm "$@"; }

eval "$(starship init zsh)"


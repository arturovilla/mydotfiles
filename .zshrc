#Homebrew shit
eval $(/opt/homebrew/bin/brew shellenv)

#vscode 'code' command
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# ~/.zshrc



# assumes github and slash separated plugin names
github_plugins=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
  rupa/z
  # must be last
  # zdharma/fast-syntax-highlighting
  zsh-users/zsh-syntax-highlighting
)

for plugin in $github_plugins; do
  # clone the plugin from github if it doesn't exist
  if [[ ! -d ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin ]]; then
    mkdir -p ${ZDOTDIR:-$HOME}/.zsh_plugins/${plugin%/*}
    git clone --depth 1 --recursive https://github.com/$plugin.git ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin
  fi
  # load the plugin
  for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
    if [[ -f ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript ]]; then
      source ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript
      break
    fi
  done
done

# clean up
unset github_plugins
unset plugin
unset initscript

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/arturo/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/arturo/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/arturo/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/arturo/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh




#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

autoload -U colors && colors

PROMPT=" %F{#a6e196}λ ~ "

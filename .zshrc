### ZSH HOME
export ZSH=$HOME/.zsh

### ---- history config -------------------------------------
export HISTFILE=$ZSH/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How many commands history will save on file.
export SAVEHIST=10000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

### ---- PLUGINS & THEMES -----------------------------------
source $ZSH/themes/spaceship-prompt/spaceship.zsh-theme
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=($ZSH/plugins/zsh-completions/src $fpath)
autoload compinit
compinit -i

### --- Source aliases --------------------------------------
source $HOME/.aliases

### --- Spaceship Config ------------------------------------

SPACESHIP_PROMPT_ORDER=(
  user      # Username section
  dir       # Current directory section
  host      # Hostname section
  git       # Git section (git_branch + git_status)
  hg        # Mercurial section (hg_branch  + hg_status)
  exec_time # Execution time
  line_sep  # Line break
  jobs      # Background jobs indicator
  exit_code # Exit code section
  char      # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_AZURE_SHOW=true
SPACESHIP_DIR_SHOW=true
SPACESHIP_TERRAFORM_SHOW=true

### ---- Setup ----------------------------------------
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# thefuck
eval $(thefuck --alias)
# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# z
source $HOMEBREW_PREFIX/etc/profile.d/z.sh
# SDKMAN
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

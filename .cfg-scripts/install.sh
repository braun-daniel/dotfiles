#!/bin/zsh
# See https://www.atlassian.com/git/tutorials/dotfiles

# Brew repos
brew tap -q sdkman/tap

# Install required packages
brew update && brew install -q \
  sdkman-cli \
  fzf \
  thefuck \
  bat \
  fd \
  yt-dlp \
  eza \
  diff-so-fancy \
  z \
  autojump \
  navi

# Check out GIT repos
mkdir -p $HOME/.cfg
mkdir -p $HOME/.zsh/plugins
{
  git clone --mirror https://github.com/braun-daniel/dotfiles.git $HOME/.cfg
  git clone git@github.com:spaceship-prompt/spaceship-prompt.git $HOME/.zsh/themes/spaceship-prompt
  git clone git@github.com:zdharma-zmirror/fast-syntax-highlighting.git $HOME/.zsh/plugins/fast-syntax-highlighting
  git clone git@github.com:zsh-users/zsh-autosuggestions.git $HOME/.zsh/plugins/zsh-autosuggestions
  git clone git@github.com:zsh-users/zsh-completions.git $HOME/.zsh/plugins/zsh-completions

  # Configure config
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME reset --hard HEAD
  
} > /dev/null 2>&1

# Setup fzf
if [ -z "$(ls -A $(brew --prefix)/opt/fzf)" ]; then
  $(brew --prefix)/opt/fzf/install \
    --bin \
    --key-bindings \
    --completion \
    --no-update-rc \
    --no-bash \
    --no-fish
fi

# Setup fzf
$(brew --prefix)/opt/fzf/install \
  --bin \
  --key-bindings \
  --completion \
  --no-update-rc \
  --no-bash \
  --no-fish

# Source zshrc
source $HOME/.zshrc

echo "Done. Restart your shell."
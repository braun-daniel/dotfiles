#!/bin/zsh
# See https://www.atlassian.com/git/tutorials/dotfiles

# Check if MacPorts is installed
if command -v brew >/dev/null 2>&1; then
  package_manager="homebrew"
elif command -v port >/dev/null 2>&1; then
  package_manager="macports"
else
  echo "Neither MacPorts nor Homebrew is installed. Please install either of them."
  exit 1
fi

# Check if the package manager can be overridden with an environment variable
if [ -n "$PACKAGE_MANAGER" ]; then
  package_manager="$PACKAGE_MANAGER"
fi

# Define the list of packages
packages="sdkman fzf thefuck bat fd yt-dlp eza diff-so-fancy z autojump navi lazygit"

# Install required packages using the selected package manager
if [ "$package_manager" = "macports" ]; then
  sudo port selfupdate
  sudo port install -q $packages
elif [ "$package_manager" = "homebrew" ]; then
  brew update
  brew install -q $packages
fi

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

} >/dev/null 2>&1

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

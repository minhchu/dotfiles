brew install \
  git \
  tmux \
  neovim \
  starship \
  ripgrep \
  fzf \
  htop \
  jesseduffield/lazydocker/lazydocker \
  jesseduffield/lazygit/lazygit \
  ansible \
  httpie \
  k6 \
  nvm \
  python-setuptools \
  tpm \
  helm \
  kubernetes-cli

brew install --casks google-chrome stats alacritty orbstack linearmouse raycast
brew tap homebrew/cask-fonts
brew install font-sauce-code-pro-nerd-font

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# You should create NVM's working directory if it doesn't exist:
#   mkdir ~/.nvm
# 
# Add the following to your shell profile e.g. ~/.profile or ~/.zshrc:
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

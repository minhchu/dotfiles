# Install ubuntu package
sudo apt install -y curl git zsh htop xclip ripgrep tmux gnome-tweaks make python3-pip

# Install nvim
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
rm get-docker.sh
# logout your computer then login again

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

# Install node
source ~/.nvm/nvm.sh
nvm install --lts

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Clone nerd-fonts
git clone https://github.com/ryanoasis/nerd-fonts ~/codes/nerd-fonts --depth=1

# Install nerd-fonts
cd ~/codes/nerd-fonts
./install.sh SourceCodePro

# Install devilbox
git clone https://github.com/cytopia/devilbox ~/codes/devilbox --depth=1

# Install ibus bamboo
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo apt-get update
sudo apt-get install ibus-bamboo
ibus restart

# Install github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Install heroku cli
curl https://cli-assets.heroku.com/install.sh | sh

# Install provider for neovim
python3 -m pip install --user --upgrade pynvim

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy config manually
cp .tmux.conf ~/.tmux.conf
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig

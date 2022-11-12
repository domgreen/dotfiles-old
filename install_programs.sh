sudo apt update
sudo apt-get update

# this is improtant ... aparently
sudo apt-get -y install libncurses5-dev libncursesw5-dev
sudo apt-get -y install libevent-dev

# curl
# sudo apt install zsh
# chsh -s $(which zsh)
# sudo apt install curl
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# htop
sudo apt-get -y install htop

# neovim
sudo apt-get -y install python-dev python-pip python3-dev python3-pip
sudo apt-get -y install neovim
mkdir -p ~/.config/nvim/
mkdir -p ~/.config/nvim/colors/
cp colors/molokai.vim .config/nvim/colors/
ln ~/.config/nvim/init.vim .vimrc

echo 'open nvim and PlugInstall'
echo 'then do :GoInstallBinaries'

# add gnome tweaks
#sudo add-apt-repository universe
#sudo apt-get -y install gnome-tweak-tool

# install tmux
sudo apt -y install tmux
sudo apt -y install tig
sudo apt-get install ripgrep

# install direnv
sudo apt -y install direnv

# install jq
sudo apt -y install jq

# install rust
curl https://sh.rustup.rs -sSf | sh

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install Tailscale
#curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add -
#curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list
#sudo apt-get update
#sudo apt-get install -y tailscale

# install kubectl
#sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
#sudo apt-get update
#sudo apt-get install -y kubectl

# install kubectx
echo 'install kubectx'

# https://github.com/BurntSushi/ripgrep#installation
echo 'install rg'

echo 'install fish esk completion'
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo 'install exa'
# cargo install exa

echo 'install more manually (gimp|slack|spotify|steam)'
# sudo snap install gimp
# sudo snap install slack
# sudo snap install spotify
# sudo snap install inkscape
# sudo apt-get install ripgrep
# sudo apt -y install steam

echo 'install nerd fonts Space Mono Nerd Font Mono'
# https://github.com/ryanoasis/nerd-fonts#option-3-install-script

echo 'install gcloud https://cloud.google.com/sdk/docs/install'
echo 'install cloud_sql_proxy https://cloud.google.com/sql/docs/mysql/connect-admin-proxy'
echo 'install go https://golang.org/doc/install'

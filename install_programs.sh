sudo apt update
sudo apt-get update

# this is improtant ... aparently
sudo apt-get -y install libncurses5-dev libncursesw5-dev
sudo apt-get -y install libevent-dev

# neovim
sudo apt-get -y install python-dev python-pip python3-dev python3-pip
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim
mkdir -p .config/nvim/colors/
cp colors/molokai.vim .config/nvim/colors/

echo 'open nvim and PlugInstall'

# add gnome tweaks
sudo add-apt-repository universe
sudo apt-get -y install gnome-tweak-tool

# install tmux
sudo apt -y install tmux

# install direnv
sudo apt -y install direnv

# install rust
curl https://sh.rustup.rs -sSf | sh

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# https://github.com/BurntSushi/ripgrep#installation
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb

echo 'install fish esk completion'
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo 'install exa'
# https://github.com/ogham/exa (downlaod zip)

echo 'install more manually (gimp|slack|spotify|steam)'
# sudo snap install gimp
# sudo snap install slack
# sudo snap install spotify
# sudo apt -y install steam
# sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

echo 'install tig'
# tig https://github.com/jonas/tig/blob/master/INSTALL.adoc

echo 'install nerd fonts'
# https://github.com/ryanoasis/nerd-fonts#option-3-install-script

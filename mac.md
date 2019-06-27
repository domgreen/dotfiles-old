brew install neovim
brew install zsh
brew install tmux
brew install fzf
brew install ripgrep
brew install exa
brew install tig
brew install direnv

which zsh
chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp dotfiles/nvim/colors/molokai.vim .config/nvim/colors

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


pip install -U neovim
pip3 install -U neovim

./install

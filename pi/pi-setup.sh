curr_dir=$(pwd)
old_configs_dir="$HOME/old_configs"

echo $curr_dir
mkdir -p "$old_configs_dir"
# move old .zshrc config
mv ~/.zshrc "$old_configs_dir"

# install  shit we need
apt update -y
apt upgrade -y
apt install zsh -y
apt install curl -y
apt install wget -y
apt install git -y

#  install zsh
sudo apt install zsh -y

#  install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# set zsh as default
chsh -s $(which zsh)

# install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts

# download latest .zshrc
curl -O https://raw.githubusercontent.com/EagleLizard/dotfiles/main/pi/.zshrc

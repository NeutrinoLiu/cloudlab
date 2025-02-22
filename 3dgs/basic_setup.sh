# desktop gui =============================
sudo apt update
sudo apt upgrade -y
sudo apt install xfce4 xrdp htop git tmux -y

# install omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# install miniconda =============================
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda-installer.sh
bash ./miniconda-installer.sh -u -b
rm miniconda-installer.sh
source ~/miniconda3/etc/profile.d/conda.sh
conda init zsh

# install cuda11.8 =============================
sudo bash install_nv_driver.sh
sudo bash install_cuda_118.sh

# reboot after =============================
sudo reboot

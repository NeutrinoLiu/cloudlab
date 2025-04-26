# desktop gui =============================
sudo apt update
sudo apt upgrade -y
sudo apt install xfce4 xrdp htop git tmux nano unzip -y

# install omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# install miniconda =============================
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda-installer.sh
bash ./miniconda-installer.sh -u -b
rm miniconda-installer.sh
source ~/miniconda3/etc/profile.d/conda.sh
conda init zsh
conda update -n base conda
conda install -n base conda-libmamba-solver
conda config --set solver libmamba
conda config --add channels conda-forge
conda config --set channel_priority strict


# install cuda11.8 =============================
sudo bash install_nv_driver.sh
# sudo bash install_cuda_118.sh
conda install -c nvidia/label/cuda-11.8.0 cuda-toolkit --override-channels

# reboot after =============================
sudo reboot

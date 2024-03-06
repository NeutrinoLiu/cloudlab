# download dataset =============================

sudo mkdir /data/dataset
sudo chmod 777 -R /data/dataset
ln -s /data/dataset ~/Desktop/dataset
cd ~/Desktop/dataset

wget https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/datasets/input/tandt_db.zip
wget -O dnerf_db.zip https://www.dropbox.com/s/0bf6fl0ye2vz3vr/data.zip

conda init
conda activate gaussian_splatting
conda install gdown
gdown https://drive.google.com/file/d/18JxhpWD-4ZmuFKLzKlAw-w5PpzZxXOcG/view\?usp\=drive_link --fuzzy

unzip tandt_db.zip
unzip dnerf_db.zip
unzip nerf_synthetic.zip

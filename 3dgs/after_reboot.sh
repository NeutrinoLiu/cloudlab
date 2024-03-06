# download dataset =============================
# sudo mkdir /data/dataset
# sudo chmod 777 -R /data/dataset
# ln -s /data/dataset ~/Desktop/dataset
# cd ~/Desktop/dataset
# wget https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/datasets/input/tandt_db.zip
# wget -O dnerf_db.zip https://www.dropbox.com/s/0bf6fl0ye2vz3vr/data.zip
# unzip tandt_db.zip
# unzip dnerf_db.zip

# install chrome browser =============================
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install -y
rm *.deb

# download 3dgs =============================
cd ~/Desktop
git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive
cd gaussian-splatting
conda env create --file environment.yml
conda init
conda activate gaussian_splatting
conda install tensorboard -y 

# train
# python train.py -s ../dataset/tandt/truck/

# install gui viewer =============================
sudo apt install -y libglew-dev libassimp-dev libboost-all-dev libgtk-3-dev libopencv-dev libglfw3-dev libavdevice-dev libavcodec-dev libeigen3-dev libxxf86vm-dev libembree-dev ninja-build cmake
cd ~/Desktop/gaussian-splatting/SIBR_viewers
CUDACXX=/usr/local/cuda-11.8/bin/nvcc cmake -Bbuild . -DCMAKE_BUILD_TYPE=Release -G Ninja
cmake --build build -j --target install

# run gui viewer =============================
# ~/Desktop/gaussian-splatting/SIBR_viewers/install/bin/SIBR_gaussianViewer_app -m ~/Desktop/gaussian-splatting/output

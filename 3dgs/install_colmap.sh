# install COLMAP

sudo apt-get install \
    git \
    cmake \
    ninja-build \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev -y

cd ~/Desktop
git clone https://github.com/colmap/colmap.git
cd colmap
mkdir build
cd build
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-11.8/lib64
export PATH=${PATH}:/usr/local/cuda-11.8/bin
cmake .. -GNinja -DCMAKE_CUDA_ARCHITECTURES=70 #V100 is 70
ninja
sudo ninja install

cd ~/Desktop
git clone https://github.com/ImageMagick/ImageMagick.git 
cd ImageMagick
./configure
make -j
sudo make install
sudo ldconfig /usr/local/lib


# This script is designed to work with ubuntu 16.04 LTS

# ensure system is updated and has basic build tools
# sudo apt-get update
# sudo apt-get --assume-yes upgrade
# sudo apt-get --assume-yes install tmux build-essential gcc g++ make binutils
# sudo apt-get --assume-yes install software-properties-common

# download and install GPU drivers
CUDA_REPO_PKG=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
wget "$CUDA_REPO_PKG" -O cuda-repo.deb
sudo dpkg -i cuda-repo.deb && rm -f cuda-repo.deb

sudo apt-get update
sudo apt-get -y install cuda
sudo modprobe nvidia
nvidia-smi

# install and configure theano
pip install theano
echo "[global]
device = gpu
floatX = float32

[cuda]
root = /usr/local/cuda" > ~/.theanorc

# install and configure keras
pip install keras==1.2.2
mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json

# install cudnn libraries
# wget "http://platform.ai/files/cudnn.tgz" -O "cudnn.tgz"
# tar -zxf cudnn.tgz
# cd cuda
# sudo cp lib64/* /usr/local/cuda/lib64/
# sudo cp include/* /usr/local/cuda/include/
ML_REPO_PKG=http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb
wget "$ML_REPO_PKG" -O ml-repo.deb
sudo dpkg -i ml-repo.deb && rm -f ml-repo.deb

sudo apt-get update
sudo apt-get install libcudnn

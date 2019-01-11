#
# Original sources:
# 1. https://www.learnopencv.com/install-opencv3-on-ubuntu/
# 2. https://github.com/BVLC/caffe/wiki/OpenCV-3.3-Installation-Guide-on-Ubuntu-16.04
# Combined all possible installs found in both links above. 
#

printf "\nPerform update and upgrade"
printf "\n=======================\n"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

printf "\nConfigure and install OS libraries"
printf "\n============================\n"


printf "\nRemove any previous installations of x264"
printf "\n=======================================\n"
# x264 is a free software library developed by VideoLAN for encoding video streams into the H.264/MPEG-4 AVC format.
sudo apt-get remove --assume-yes x264 libx264-dev

printf "\nInstalling OpenCV OS Dependencies\n"
printf "\n=======================================\n"

# 'build-essentials' is a reference for all the packages needed to compile a debian package. 
# It generally includes the gcc/g++ compilers, libraries and some other utils.
sudo apt-get install --assume-yes build-essential 

# Checkinstall keeps track of all the files created or modified by your installation script, 
# builds a standard binary package (.deb, .rpm, .tgz) and installs it in your system giving 
# you the ability to uninstall it with your distribution's standard package management utilities.
sudo apt-get install --assume-yes checkinstall 

sudo apt-get install --assume-yes cmake pkg-config yasm
sudo apt-get install --assume-yes git gfortran

sudo apt-get install --assume-yes libjpeg8-dev libjasper-dev libpng12-dev libtiff5-dev
 
sudo apt-get install --assume-yes libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt-get install --assume-yes libxine2-dev libv4l-dev
sudo apt-get install --assume-yes libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt-get install --assume-yes qt5-default libgtk2.0-dev libtbb-dev
sudo apt-get install --assume-yes libatlas-base-dev
sudo apt-get install --assume-yes libfaac-dev libmp3lame-dev libtheora-dev
sudo apt-get install --assume-yes libvorbis-dev libxvidcore-dev
sudo apt-get install --assume-yes libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt-get install --assume-yes x264 v4l-utils
 
sudo apt-get install --assume-yes build-essential cmake git
sudo apt-get install --assume-yes unzip ffmpeg qtbase5-dev python-dev python3-dev python-numpy python3-numpy
sudo apt-get install --assume-yes libopencv-dev libgtk-3-dev libdc1394-22  libjpeg-dev  
sudo apt-get install --assume-yes libfaac-dev   
sudo apt-get install --assume-yes vtk6
sudo apt-get install --assume-yes liblapacke-dev libopenblas-dev libgdal-dev 

printf "\nInstall essential python dependencies"
printf "\n======================================\n"
sudo pip install --upgrade pip
sudo pip install numpy


printf "\nInstall optional dependencies"
printf "\n==============================\n"
# Optional dependencies
sudo apt-get install --assume-yes libprotobuf-dev protobuf-compiler
sudo apt-get install --assume-yes libgoogle-glog-dev libgflags-dev
sudo apt-get install --assume-yes libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

sudo apt-get install --assume-yes python-dev python-pip python3-dev python3-pip

printf "\nInstalling dependencies - Completed\n"
printf "\n==============================\n"


printf "\nCloning opencv\n"
printf "\n==============================\n"
cd ~
git clone https://github.com/opencv/opencv.git
cd opencv 
git checkout 3.3.1 

printf "\nCloning opencv-contrib\n"
printf "\n==============================\n"
cd ~
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 3.3.1

cd ~/opencv
mkdir build
cd ~/opencv/build/


cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
      -D WITH_CUDA=OFF \
      -D BUILD_EXAMPLES=ON ..


make -j$(nproc)
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig


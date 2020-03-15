#
# Original sources:
# 1. https://www.learnopencv.com/install-opencv3-on-ubuntu/
# 2. https://github.com/BVLC/caffe/wiki/OpenCV-3.3-Installation-Guide-on-Ubuntu-16.04
# Combined all possible installs found in both links above. 
#

cvVersion="4.1.2"

printf "\nPerform update and upgrade"
printf "\n=======================\n"
sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes dist-upgrade

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
 

# Checkinstall keeps track of all the files created or modified by your installation script, 
# builds a standard binary package (.deb, .rpm, .tgz) and installs it in your system giving 
# you the ability to uninstall it with your distribution's standard package management utilities.
sudo apt-get install --assume-yes checkinstall 
sudo apt-get install --assume-yes pkg-config 
sudo apt-get install --assume-yes yasm
sudo apt-get install --assume-yes git 
sudo apt-get install --assume-yes gfortran
sudo apt-get install --assume-yes software-properties-common
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt-get --assume-yes update
sudo apt-get install --assume-yes libjasper-dev 
sudo apt-get install --assume-yes libjasper1 
sudo apt-get install --assume-yes libtiff-dev
sudo apt-get install --assume-yes libtiff5-dev

sudo apt-get install --assume-yes libjpeg8-dev 
sudo apt-get install --assume-yes libpng-dev 
sudo apt-get install --assume-yes libpng12-dev 
 
sudo apt-get install --assume-yes libavcodec-dev 
sudo apt-get install --assume-yes libavformat-dev 
sudo apt-get install --assume-yes libswscale-dev 
sudo apt-get install --assume-yes libdc1394-22-dev

sudo apt-get install --assume-yes libxine2-dev 
sudo apt-get install --assume-yes libv4l-dev 
sudo apt-get install --assume-yes libx264-dev
# this is for ubuntu 16
# sudo apt-get install --assume-yes libgstreamer0.10-dev 
# sudo apt-get install --assume-yes libgstreamer-plugins-base0.10-dev

# this is for ubuntu 18
sudo apt-get install --assume-yes libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

sudo apt-get install --assume-yes qt5-default 

# this is for ubuntu 16
# sudo apt-get install --assume-yes libgtk2.0-dev 
# sudo apt-get --assume-yes install python-dev

# this is for ubuntu 18
sudo apt-get install --assume-yes libgtk-3-dev

sudo apt-get install --assume-yes libtbb-dev
sudo apt-get install --assume-yes libatlas-base-dev
sudo apt-get install --assume-yes libfaac-dev 
sudo apt-get install --assume-yes libmp3lame-dev 
sudo apt-get install --assume-yes libtheora-dev
sudo apt-get install --assume-yes libvorbis-dev 
sudo apt-get install --assume-yes libxvidcore-dev
sudo apt-get install --assume-yes libopencore-amrnb-dev 
sudo apt-get install --assume-yes libopencore-amrwb-dev
sudo apt-get install --assume-yes x264 
sudo apt-get install --assume-yes v4l-utils
 
 
sudo apt-get install --assume-yes unzip 
sudo apt-get install --assume-yes ffmpeg 
sudo apt-get install --assume-yes qtbase5-dev 
sudo apt-get install --assume-yes libopencv-dev 
sudo apt-get install --assume-yes libdc1394-22  
sudo apt-get install --assume-yes libjpeg-dev  
sudo apt-get install --assume-yes vtk6
sudo apt-get install --assume-yes liblapacke-dev 
sudo apt-get install --assume-yes libopenblas-dev 
sudo apt-get install --assume-yes libgdal-dev 

#cd /usr/include/linux
#sudo ln -s -f ../libv4l1-videodev.h videodev.h
#cd "$cwd"

sudo apt-get --assume-yes install libgstreamer1.0-dev 
sudo apt-get --assume-yes install libgstreamer-plugins-base1.0-dev 
sudo apt-get --assume-yes install libavresample-dev

printf "\nInstall essential python dependencies"
printf "\n======================================\n"
sudo apt-get --assume-yes install python3-dev 
pip install --upgrade pip
pip install numpy


printf "\nInstall optional dependencies"
printf "\n==============================\n"
# Optional dependencies
sudo apt-get install --assume-yes libprotobuf-dev 
sudo apt-get install --assume-yes protobuf-compiler 
sudo apt-get install --assume-yes python3-testresources
sudo apt-get install --assume-yes libgoogle-glog-dev 
sudo apt-get install --assume-yes libgflags-dev
sudo apt-get install --assume-yes libgphoto2-dev 
sudo apt-get install --assume-yes libeigen3-dev 
sudo apt-get install --assume-yes libhdf5-dev 
sudo apt-get install --assume-yes doxygen


printf "\nInstalling dependencies - Completed\n"
printf "\n==============================\n"


printf "\nCloning opencv\n"
printf "\n==============================\n"
cd ~
git clone https://github.com/opencv/opencv.git
cd opencv 
git checkout $cvVersion

printf "\nCloning opencv-contrib\n"
printf "\n==============================\n"
cd ~
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cvVersion

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
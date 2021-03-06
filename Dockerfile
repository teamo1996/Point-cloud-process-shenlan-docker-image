FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

# ------ powered by Zhang Junjie, 18810521109@163.com ------

# ------ USER ROOT HAS BEEN ACTIVATED ------
USER root

# ------ PART 0: set environment variables ------

# set up environment:
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV HOME=/root SHELL=/bin/bash

# set Gpu support
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

# ------ PART 1: install the necessary tools ------
RUN apt update && \
    apt-get install -y --no-install-recommends --allow-unauthenticated\ 
        # package utils:
        sudo dpkg pkg-config apt-utils \
        # network utils:
        curl wget iputils-ping net-tools \
        # command line:
        vim grep sed patch gedit\
        # zip and unzip:
        pv zip unzip bzip2 \
        # version control:
        git \
        # browser
        firefox \
        #open3d dependices:
        libgl1 libgomp1 python3-pip \
        # general development:
        gcc g++ \
        make cmake build-essential autoconf automake libtool \
        libglib2.0-dev libboost-dev libboost-all-dev \
        libomp-dev libtbb-dev \
        libgoogle-glog-dev \
        libqt5svg5-dev libqt5opengl5-dev qt5-default qttools5-dev qttools5-dev-tools libqt5websockets5-dev \
        # PCL:
        libeigen3-dev libpcl-dev &&\
    apt autoclean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

# ------ PART 2: install miniconda ------

ENV PATH="/root/miniconda3/bin:${PATH}"

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.10.3-Linux-x86_64.sh && \
    chmod +x Miniconda3-py37_4.10.3-Linux-x86_64.sh &&\
    bash Miniconda3-py37_4.10.3-Linux-x86_64.sh -b && \
    rm Miniconda3-py37_4.10.3-Linux-x86_64.sh

# ------ PART 3: install Cloudcompare

RUN git clone --recursive git://github.com/cloudcompare/CloudCompare.git && \
    cd CloudCompare && \
    mkdir build && cd build && cmake -DCMAKE_PREFIX_PATH=/usr/lib/x86_64-linux-gnu/cmake .. && make install && cd / && rm -r /CloudCompare

# ------ PART 4: move cudnn libary to correct location ------

RUN cp /usr/lib/x86_64-linux-gnu/libcudnn* /usr/local/cuda/lib64/ && \
    cp /usr/include/cudnn.h /usr/local/cuda/include 

# ------ PART 5: install python pkgs ------

# ------ create virtual envirment -----

RUN /bin/bash -c "conda init" 
RUN conda update -n base -c defaults conda && conda create --name Point-cloud-process python=3.8
# RUN /bin/bash -c "source /root/miniconda3/bin/activate Point-cloud-process && pip install addict scikit-learn pyyaml matplotlib plyfile pyntcloud tqdm && \
#              conda install numpy pandas && \
#              conda install -c open3d-admin open3d " 
# RUN /root/miniconda3/bin/conda run -n Point-cloud-process python3 -m pip install --no-cache-dir --upgrade open3d
# RUN /bin/bash -c "source /root/miniconda3/bin/activate Point-cloud-process && python3 -m pip install --no-cache-dir --upgrade open3d " 

# # ------ pytorch 1.4.0 ------
# RUN /bin/bash -c "source /root/miniconda3/bin/activate Point-cloud-process && conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=10.1 -c pytorch " 

# # ------ pytorch tensorflow 2.3.0 ------
# RUN /bin/bash -c "source /root/miniconda3/bin/activate Point-cloud-process && pip install tensorflow==2.3.0 " 

# switch to virtual env
SHELL [ "conda","run","-n","Point-cloud-process","/bin/bash","-c" ]

# ------ open3d ------
RUN python3 -m pip install --no-cache-dir --upgrade open3d && \
# ------ pytorch 1.4.0 ------
    conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=10.1 -c pytorch && \
# ------ tensorflow 2.3.0 ------
    python3 -m pip install tensorflow==2.3.0 pyntcloud torchsummary

# ------- PART 6: init environment -----
RUN echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.1/extras/CUPTI/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc && \
    echo "source /root/miniconda3/bin/activate Point-cloud-process" >> ~/.bashrc
    

# 深蓝学院三维点云处理环境镜像

## 概述

本镜像设计用于深蓝学院三维点云处理课程学习及作业完成，内置了完成课程所需要的所有环境以及基于X server的GUI显示功能，并启用了GPU硬件加速图形显示和CUDA。

## 环境需求
* `ubuntu`（已经在`ubuntu20.04`上进行了测试，理论上`ubutnu16.04`以上版本均可以运行）
* `Docker >= 19.03`
* `NVIDIA Linux drivers >= 418.81.07`
* `NVIDIA Container Toolkit`（参考[官方指导](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker%5D)）


## 内置环境
镜像内主要安装了以下环境和工具：
* `Vim, gedit`文本编辑器
* `Firefox`浏览器
* `C++:gcc/g++-7.5.0, cmake-3.10.2`
* `PCL: PCL-1.8.0`
* `minicond3`:默认版本为`python3.7`
* `CUDA-10.1+cudnn-7`
* `CloudCompare`
* `Open3D-0.11`（`conda`虚拟环境`Point-cloud-process`中）
* `tensorflow-2.3.0`（`conda`虚拟环境`Point-cloud-process`中）
* `pytorch-1.7.0`（`conda`虚拟环境`Point-cloud-process`中）
* 其他`ubuntu`系统常用的工具（参考`Dockerfile`）

## 运行方法
1. 克隆仓库
    ```bash
    git clone https://github.com/teamo1996/Point-cloud-process-shenlan-docker-image.git
    ```
2. 为启动脚本添加可执行权限
    ```bash
    sudo chmod +x ./run.sh
    ```
3. 运行`shell`脚本
    ```bash
    ./run.sh
    ```
    > 注意：此脚本会自动从我的`docker`仓库拉取所需的镜像，镜像尺寸较大，需要耐心等候
4. 启动后如果一切正常的话，会进入默认的`conda`虚拟环境，已经配置好课程相关的`python`环境和工具，显示如下
    ```bash
    (Point-cloud-process) root@"your computer name":/# 
      ```
    > 注意：为了确保安装过程简单，默认使用`root`用户进行操作，可能存在一定的安全隐患，故提供了原始的`Dockerfile`，有需要可以自行修改并加入权限控制

5. 本镜像会默认将脚本目录下的`workspace`目录挂载到`docker`容器内的`/workspace`目录，为了保证关闭容器后相关代码的保留，建议所有作业相关代码均在`/workspace`目录下完成。

## 课程所需要的数据集及其下载地址
* [modelnet40_normal_resampled](https://shapenet.cs.stanford.edu/media/modelnet40_normal_resampled.zip)
* [KITTI depth dataset(Optional)](http://www.cvlibs.net/datasets/kitti/eval_depth_all.php)好像只需要下载下面这个数据集就行
    * [Download annotated depth maps data set (14 GB)](http://www.cvlibs.net/download.php?)
* [KITTI 3D object detection](http://www.cvlibs.net/datasets/kitti/eval_object.php?obj_benchmark=3d)下载如下几个数据集
  * [Download left color images of object data set(12 GB)](http://www.cvlibs.net/download.php?file=data_object_image_2.zip)
  * [Download Velodyne point clouds, if you want to use laser information (29 GB)](http://www.cvlibs.net/download.php?file=data_object_velodyne.zip)
  * [Download camera calibration matrices of object data set (16 MB)](http://www.cvlibs.net/download.php?file=data_object_calib.zip)
  * [Download training labels of object data set (5 MB)](http://www.cvlibs.net/download.php?file=data_object_label_2.zip)
  * [Download object development kit (1 MB)](https://s3.eu-central-1.amazonaws.com/avg-kitti/devkit_object.zip)
  
* registration_dataset.zip(由深蓝学院提供)

## 各章节需要的数据集统计
* 第一章:modelnet40_normal_resampled, KITTI depth dataset(Optional)
* 第四章:KITTI 3D object detection
* 第五章:modelnet40_normal_resampled
* 第六章:KITTI 3D object detection
* 第七章:modelnet40_normal_resampled
* 第八章:modelnet40_normal_resampled
* 第九章:registration_dataset.zip
* Final Project:KITTI 3D object detection
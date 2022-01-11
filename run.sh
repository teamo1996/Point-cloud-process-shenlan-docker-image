#！//bin/bash

xhost +

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd);
echo $DIR
docker run --rm -it \
    --privileged \
    --net=host \
    --memory="8g" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$DIR/workspace:/workspace" \
    --runtime=nvidia \
    teamo1998/point-cloud-process-shenlan:latest 
# docker

手工运行命令

docker run -ti --rm --entrypoint="/bin/bash" daocloud.io/zuroc/gu321 -c bash 

docker exec -it gu321 bash

启动之后

需要初始化home目录的代码见：

git clone https://github.com/gu321/docker_home
cd docker_home
./init/dev.sh

各种常用的工具脚本见 https://gitee.com/gu321/docker

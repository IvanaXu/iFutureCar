
if [ "$1" = "train" ];
then
    echo "train"
    python -m train.main
elif [ "$1" = "rcmd" ]
then
    echo "rcmd"
    docker run -dit --name matrix_demo registry.cn-shanghai.aliyuncs.com/tianchi/matrix:matrix_demo bash

    docker cp run.sh matrix_demo:/workspace/
    docker cp inference/ matrix_demo:/workspace/  # 场景评分代码
    docker cp train/ matrix_demo:/workspace/ # 场景训练代码

    dimage=registry.cn-shanghai.aliyuncs.com/tianchi_ivanxu/test-car:v1.0
    docker commit matrix_demo $dimage
    docker push $dimage

else
    python /workspace/inference/inference_demo.py
fi
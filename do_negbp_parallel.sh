
source common.ini

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 numjobs"
    exit
fi

numjobs=$1


posName=fcswncnnbc
trainCollection=train10k
conceptset=concepts130
baseAnnotationName="$conceptset"social.txt
posNum=500
startAnnotationName="$conceptset"social."$posName""$posNum".random"$posNum".0.txt



feature=pygooglenet-pool5_7x7_s1l2
#feature=pygooglenet-pool5_7x7_s1
#feature=pyvggnet-fc7l2
feature=vgg-verydeep-16-fc7relul2
modelname=fastlinear


parallel python $codepath/model_based/negbp.py $trainCollection $baseAnnotationName $startAnnotationName  $feature $modelname --rootpath $rootpath --overwrite 0  --numjobs $numjobs --job {1} ::: `seq $numjobs`


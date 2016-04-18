
source common.ini


if [ "$#" -ne 3 ]; then
    echo "Usage: $0 trainCollection trainAnnotationName numjobs"
    exit
fi

trainCollection=$1
trainAnnotationName=$2
numjobs=$3

feature=pygooglenet-pool5_7x7_s1l2
feature=dsift

parallel python $codepath/model_based/svms/fastlinear/trainLinearConcepts.py $trainCollection $trainAnnotationName $feature --rootpath $rootpath --overwrite 0  --numjobs $numjobs --job {1} ::: `seq $numjobs`


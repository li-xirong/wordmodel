
source common.ini

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 trainCollection trainAnnotationName testCollection"
    exit
fi

trainCollection=$1
trainAnnotationName=$2
testCollection=$3
overwrite=0

feature=pygooglenet-pool5_7x7_s1l2
feature=dsiftl2
feature=vgg-verydeep-16-fc7relul2
feature=dsift

modelName=fastlinear

python $codepath/model_based/svms/applyfaster.py $testCollection $trainCollection $trainAnnotationName $feature $modelName --rootpath $rootpath --overwrite $overwrite


if [ "$testCollection" = "mirflickr08" ]; then
    testAnnotationName=conceptsmir14.txt
elif [ "$testCollection" = "flickr51" ]; then
    testAnnotationName=concepts51ms.txt
elif [ "$testCollection" = "flickr81" ]; then
    testAnnotationName=concepts81.txt
elif [ "$testCollection" = "voc2008val" ]; then
    testAnnotationName=conceptsvoc2008val.txt
else
    echo "unknown testCollection $testCollection"
    exit
fi

conceptfile=$rootpath/$testCollection/Annotations/$testAnnotationName
tagvotesfile=$rootpath/$testCollection/autotagging/$testCollection/$trainCollection/$trainAnnotationName/$feature,$modelName/id.tagvotes.txt
resfile=$rootpath/$testCollection/autotagging/$testCollection/$trainCollection/$trainAnnotationName/$feature,$modelName/id.tagvotes.pkl
resfile=$rootpath/$testCollection/autotagging/$testCollection,$trainCollection,$trainAnnotationName,$feature,$modelName.pkl

python $codepath/postprocess/pickle_tagvotes.py $conceptfile $tagvotesfile $resfile  --overwrite $overwrite


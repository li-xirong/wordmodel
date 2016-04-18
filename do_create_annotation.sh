
source common.ini

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 trainCollection conceptset"
    exit
fi

overwrite=0
trainCollection=$1
conceptset=$2
annotationName=$conceptset.txt
socialAnnotationName="$conceptset"social.txt

conceptfile=$rootpath/$trainCollection/Annotations/$annotationName
tagfile=$rootpath/$trainCollection/TextData/id.userid.lemmtags.txt

for datafile in $conceptfile $tagfile
do

    if [ ! -f "$datafile" ]; then
        echo "$datafile does not exist!"
        exit
    fi
done

python $codepath/util/imagesearch/obtain_labeled_examples.py $trainCollection $conceptfile --overwrite $overwrite
python $codepath/util/tagsim/expand_tags.py $trainCollection $annotationName
python $codepath/model_based/dataengine/createSocialAnnotations.py $trainCollection $annotationName --overwrite $overwrite


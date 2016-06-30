# wordmodel
train linear classifier per word using [Jingwei](https://github.com/li-xirong/jingwei)


## Setup

### code

```
cd ~/github
git clone https://github.com/li-xirong/jingwei
git clone https://github.com/li-xirong/wordmodel
cd wordmodel
source ~/github/jingwei/start.sh
```

### toy data

```
cd ~/VisualSearch
wget http://lixirong.net/data/tmm2013/voc2008train-voc2008val.zip
unzip voc2008train-voc2008val.zip
```

## Train models

```
./do_train_parallel.sh voc2008train conceptsvoc2008train.txt 2
```

## Test models

```
./do_test.sh voc2008train conceptsvoc2008train.txt voc2008val
```

## Evaluation (MiAP and MAP)

```
ls ~/VisualSearch/voc2008val/autotagging/voc2008val,voc2008train,conceptsvoc2008train.txt,dsift,fastlinear.pkl > voc2008val.txt
python ~/github/jingwei/eval/eval_pickle.py voc2008val conceptsvoc2008val.txt voc2008val.txt  > voc2008val.res
```



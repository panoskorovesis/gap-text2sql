#!/bin/bash

mkdir logdir
mkdir ie_dirs
mkdir models

echo "Downdoad and unzip Spider Dataset"
gdown --id 1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0
unzip spider.zip
bash data/spider/generate.sh ./spider
rm spider.zip

echo "Build English dataset directory"
echo "The original version of the Spider dataset is distributed under the CC BY-SA 4.0 license."

mkdir data/spider-en
cp ./spider/train_spider.json data/spider-en/
cp ./spider/train_others.json data/spider-en/
cp ./spider/dev.json data/spider-en/
cp ./spider/tables.json data/spider-en/
ln -s $(pwd)/spider/database data/spider-en/database

echo "Build Portuguese dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-pt
cp ./spider/tables.json data/spider-pt/
cd data/spider-pt
gdown --id 1rU79PipqU6XDIzqtYuS2Lg_LTYLbyN9U
gdown --id 1no9qKojtDTAwFTm9MqZTOjjTupiEy7Ir
gdown --id 1HTNEUihVDuEg1hvLDbJd3yxXngJp3u4v
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-pt/database

echo "Build Spanish dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-es
cp ./spider/tables.json data/spider-es/
cd data/spider-es
gdown --id 1utYMsytUVRaozo50qjkQGwS2vDUWp4kD
gdown --id 1aSNetfAote7eG0lzDCJSPukT84abEtIN
gdown --id 1UoFGQMvRkV7wBRyqhqu49Luu1Gs_HSi8
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-es/database

echo "Build French dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-fr
cp ./spider/tables.json data/spider-fr/
cd data/spider-fr
gdown --id 1VC8IiOSY2Oaq6eCJJjf0pplHtVXPhOXi
gdown --id 1GmqiKa3-W1soEKadpY3L2fXiKLzf_6Ps
gdown --id 1NdALreT67okWPwIKuiVP6y2xWyZUtUf7
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-fr/database


echo "Build English and Portuguese dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt
cp ./spider/tables.json data/spider-en-pt/
cd data/spider-en-pt
gdown --id 1ph3ttcoaHMJvsI4yFhENHHuH_4M-UH53
gdown --id 1odAFfyTM3N5y8QqQE5oUEt9CZZQ60CpS
gdown --id 1HOM5GNPiO_o4NeQTVzpgymyABPgUPbbr
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt/database

echo "Build English, Portuguese, Spanish and French dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt-es-fr
cp ./spider/tables.json data/spider-en-pt-es-fr/
cd data/spider-en-pt-es-fr
gdown --id 18xoEkF5XdbfaN5SwqsbbMw89Y3iNvAa9
gdown --id 1n2U1pBzzRDAZuqmjloj6CV4Btf5sKfvd
gdown --id 1diKAP4BGccFzupvf3HCcPleRP5EMqSHM
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt-es-fr/database
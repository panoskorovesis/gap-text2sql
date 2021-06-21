#!/bin/bash

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
gdown --id 12JjlnOsWxLDtOV2cK-3ggsAtBeqU1vYp
gdown --id 1FeVYW3fR1A3Ls-Es-0H_QkB3mRw8QCFx
gdown --id 1UvEFBTAqcrmibUfxTOLo41viIifh7g6K
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-pt/database


echo "Build English and Portuguese dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt
cp ./spider/tables.json data/spider-en-pt/
cd data/spider-en-pt
gdown --id 1qFaSvUU1d4ZxYA7q4fRqjPTfZH9zjQ-x
gdown --id 1c6CEnenCkpW9Ugk_OHhawGb39_-DeY1y
gdown --id 1ZRIlwCOwi2VjaxADisf7QpFSVIyMONGe
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt/database


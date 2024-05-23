#!/bin/bash

mkdir logdir
mkdir ie_dirs
mkdir models
chmod +x BART_large.sh
chmod +x BERTimbau-base.sh
chmod +x BERTimbau-large.sh
chmod +x mBART50MtoM-large.sh
chmod +x mT5_large.sh

echo
echo "Downdoad and unzip Spider Dataset"

unzip spider.zip
bash data/spider/generate.sh ./spider

echo "Build English dataset directory"
echo "The original version of the Spider dataset is distributed under the CC BY-SA 4.0 license."

mkdir data/spider-en
cp ./spider/train_spider.json data/spider-en/
cp ./spider/train_others.json data/spider-en/
cp ./spider/dev.json data/spider-en/
cp ./spider/tables.json data/spider-en/
ln -s $(pwd)/spider/database data/spider-en/database

mkdir data/spider-gr
cp ./spider/train_spider.json data/spider-gr/
cp ./spider/train_others.json data/spider-gr/
cp ./spider/dev.json data/spider-gr/
cp ./spider/tables.json data/spider-gr/
ln -s $(pwd)/spider/database data/spider-gr/database


echo "Folders structure preparation"

#mt5-base
mkdir logdir/mT5-base-en-train
mkdir ie_dirs/mT5-base-en-train

mkdir logdir/mT5-base-gr-train
mkdir ie_dirs/mT5-base-gr-train


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
echo "Downdload and unzip Spider Dataset"

gdown https://drive.google.com/uc?id=1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0
gdown --id 1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0

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

echo
echo "Downdload SMALL version of ENG Spider"

gdown https://drive.google.com/uc?id=1EHs2q6lOD7W0NltjOWe0NNsM_HubdzJ8
gdown https://drive.google.com/uc?id=1huPVUOlwP3zasNzZmWjNc8QA1L1arzqK
gdown https://drive.google.com/uc?id=1V8TuijPPpR2sGWVlh5J1PA5YAxBDvD09

mv dev.json data/spider-en/
mv train_others.json data/spider-en/
mv train_spider.json data/spider-en/

mkdir data/spider-gr
cp ./spider/train_spider.json data/spider-gr/
cp ./spider/train_others.json data/spider-gr/
cp ./spider/dev.json data/spider-gr/
cp ./spider/tables.json data/spider-gr/
ln -s $(pwd)/spider/database data/spider-gr/database

echo
echo "Downdload SMALL version of GR Spider"

gdown https://drive.google.com/uc?id=1IlGT2aK0Ntf6ojRf7qhNfkuRkSn28dXI
gdown https://drive.google.com/uc?id=1B9s1sj8a3AUTRlH6magKsDkPVk6ODNAI
gdown https://drive.google.com/uc?id=1SwW40nBwqghOtHBlFRDtG391XKzFMmty
gdown https://drive.google.com/uc?id=1u8cJ2PH6mfiDKZJRpEMBdnJfpmAlLGtZ

mv dev.json data/spider-gr/
mv tables.json data/spider-gr/
mv train_others.json data/spider-gr/
mv train_spider.json data/spider-gr/

echo "Folders structure preparation"

#mt5-base
mkdir logdir/mT5-base-en-train
mkdir ie_dirs/mT5-base-en-train

mkdir logdir/mT5-base-gr-train
mkdir ie_dirs/mT5-base-gr-train


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
gdown --id 1WA7fcDjXcqvgNbR9zeDE3MIBkrU2CkUj
gdown --id 12tH9OljA1BlhQblh4LWORnNXLOyaHNId
gdown --id 13REA81vx2Zk0SSdCNS5HeYFW10oOTasf
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt/database

echo "Build Spanish dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-es
cp ./spider/tables.json data/spider-es/
cd data/spider-es
gdown --id 1ELxDV-HI6fT0Vup5m1s7s8RgRE_MOeeU
gdown --id 1k4ous-ilXz52uvIq9uYHYnQO3yr_8JUV
gdown --id 1FMM1W6w0JouiwnmIKaK9h3EhbOlUJ-Ci
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-es/database

echo "Build French dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-fr
cp ./spider/tables.json data/spider-fr/
cd data/spider-fr
gdown --id 1If4Pvhi2kc2hxuLo35_YwjGUSsf4l-tH
gdown --id 1bauP3V6DVQKNhZIhERA-ltXWUZ7_jc8Y
gdown --id 1HqN9hQU7Yqlavk2UNLy9wx9phPjTLF5t
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-fr/database

echo "Build English, Portuguese, Spanish and French dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt-es-fr
cp ./spider/tables.json data/spider-en-pt-es-fr/
cd data/spider-en-pt-es-fr
gdown --id 1CdQuLKtF4FBHwd5_VfDLa5GHrMY9kgK2 
gdown --id 1hDCZTxEsgZ9EFUIaMNwMM3UT9aqc5v9z 
gdown --id 1DeLYa97cn16EOOUaNoVqTorSZp8i5Ik1 
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt-es-fr/database
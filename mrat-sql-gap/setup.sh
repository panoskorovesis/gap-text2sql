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
gdown https://drive.google.com/uc?id=1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0
#gdown --id 1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0
unzip spider.zip
bash data/spider/generate.sh ./spider

echo
echo "Preparing Spider FIT Dataset"
cp -r spider spider-FIT
cd spider-FIT
rm *.*
gdown --id 1WRZRIRIq_sjWwgXPVGj9942tjiQtmZm-
cd database
rm -r baseball_1
rm -r cre_Drama_Workshop_Groups
rm -r soccer_1
gdown --id 1iWAKxH0hSk98dlI9-oSuuMpfMdtJ29Yn
unzip resized.zip
rm resized.zip
cd ..
cd ..
rm spider.zip

echo
echo "Build English dataset directory"
echo "The original version of the Spider dataset is distributed under the CC BY-SA 4.0 license."

mkdir data/spider-en
cp ./spider/train_spider.json data/spider-en/
cp ./spider/train_others.json data/spider-en/
cp ./spider/dev.json data/spider-en/
cp ./spider/tables.json data/spider-en/
ln -s $(pwd)/spider/database data/spider-en/database

echo
echo "Build English data augmentation by rules and data augmentation by backtranslation dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-enr-enb
cp ./spider/tables.json data/spider-en-enr-enb/
cp ./data/spider-en/dev.json data/spider-en-enr-enb/
cd data/spider-en-enr-enb
gdown https://drive.google.com/uc?id=1hatQ9yvNpYJu7QFEwWfPp06sluLtMwpt
gdown https://drive.google.com/uc?id=1OLcIwPjKMVoIkopIDUT1s2Ldo9jtOt93
#gdown --id 1hatQ9yvNpYJu7QFEwWfPp06sluLtMwpt
#gdown --id 1OLcIwPjKMVoIkopIDUT1s2Ldo9jtOt93
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-enr-enb/database


echo
echo "Build English non-linear data augmentation (extra question/queries in train_spider.json) 3 x by rules and 1 x by backtranslation dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-extra-3enr-1enb
cp ./spider/tables.json data/spider-en-extra-3enr-1enb/
cp ./data/spider-en/dev.json data/spider-en-extra-3enr-1enb/
cp ./data/spider-en/train_others.json data/spider-en-extra-3enr-1enb/
cd data/spider-en-extra-3enr-1enb
gdown https://drive.google.com/uc?id=1cp_hYBR9BX1qXCWLEGq6X4RyzJw4fhle
#gdown --id 1cp_hYBR9BX1qXCWLEGq6X4RyzJw4fhle
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-extra-3enr-1enb/database


echo
echo "Build Portuguese dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-pt
cp ./spider/tables.json data/spider-pt/
cd data/spider-pt
gdown https://drive.google.com/uc?id=1rU79PipqU6XDIzqtYuS2Lg_LTYLbyN9U
gdown https://drive.google.com/uc?id=1no9qKojtDTAwFTm9MqZTOjjTupiEy7Ir
gdown https://drive.google.com/uc?id=1HTNEUihVDuEg1hvLDbJd3yxXngJp3u4v
#gdown --id 1rU79PipqU6XDIzqtYuS2Lg_LTYLbyN9U
#gdown --id 1no9qKojtDTAwFTm9MqZTOjjTupiEy7Ir
#gdown --id 1HTNEUihVDuEg1hvLDbJd3yxXngJp3u4v
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-pt/database

echo
echo "Build Spanish dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-es
cp ./spider/tables.json data/spider-es/
cd data/spider-es
gdown https://drive.google.com/uc?id=1utYMsytUVRaozo50qjkQGwS2vDUWp4kD
gdown https://drive.google.com/uc?id=1aSNetfAote7eG0lzDCJSPukT84abEtIN
gdown https://drive.google.com/uc?id=1UoFGQMvRkV7wBRyqhqu49Luu1Gs_HSi8
#gdown --id 1utYMsytUVRaozo50qjkQGwS2vDUWp4kD
#gdown --id 1aSNetfAote7eG0lzDCJSPukT84abEtIN
#gdown --id 1UoFGQMvRkV7wBRyqhqu49Luu1Gs_HSi8
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-es/database

echo
echo "Build French dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-fr
cp ./spider/tables.json data/spider-fr/
cd data/spider-fr
gdown https://drive.google.com/uc?id=1VC8IiOSY2Oaq6eCJJjf0pplHtVXPhOXi
gdown https://drive.google.com/uc?id=1GmqiKa3-W1soEKadpY3L2fXiKLzf_6Ps
gdown https://drive.google.com/uc?id=1NdALreT67okWPwIKuiVP6y2xWyZUtUf7
#gdown --id 1VC8IiOSY2Oaq6eCJJjf0pplHtVXPhOXi
#gdown --id 1GmqiKa3-W1soEKadpY3L2fXiKLzf_6Ps
#gdown --id 1NdALreT67okWPwIKuiVP6y2xWyZUtUf7
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-fr/database


echo
echo "Build English and Portuguese dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt
cp ./spider/tables.json data/spider-en-pt/
cd data/spider-en-pt
gdown https://drive.google.com/uc?id=1ph3ttcoaHMJvsI4yFhENHHuH_4M-UH53
gdown https://drive.google.com/uc?id=1odAFfyTM3N5y8QqQE5oUEt9CZZQ60CpS
gdown https://drive.google.com/uc?id=1HOM5GNPiO_o4NeQTVzpgymyABPgUPbbr
#gdown --id 1ph3ttcoaHMJvsI4yFhENHHuH_4M-UH53
#gdown --id 1odAFfyTM3N5y8QqQE5oUEt9CZZQ60CpS
#gdown --id 1HOM5GNPiO_o4NeQTVzpgymyABPgUPbbr
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt/database

echo
echo "Build English, Portuguese, Spanish and French dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt-es-fr
cp ./spider/tables.json data/spider-en-pt-es-fr/
cd data/spider-en-pt-es-fr
gdown https://drive.google.com/uc?id=18xoEkF5XdbfaN5SwqsbbMw89Y3iNvAa9
gdown https://drive.google.com/uc?id=1n2U1pBzzRDAZuqmjloj6CV4Btf5sKfvd
gdown https://drive.google.com/uc?id=1diKAP4BGccFzupvf3HCcPleRP5EMqSHM
#gdown --id 18xoEkF5XdbfaN5SwqsbbMw89Y3iNvAa9
#gdown --id 1n2U1pBzzRDAZuqmjloj6CV4Btf5sKfvd
#gdown --id 1diKAP4BGccFzupvf3HCcPleRP5EMqSHM
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt-es-fr/database

echo
echo "Build English, Portuguese, Spanish, French; Data augmentation just in English by rules and by backtranslation dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt-es-fr-enr-enb
cp ./spider/tables.json data/spider-en-pt-es-fr-enr-enb/
cp ./data/spider-en-pt-es-fr/dev.json data/spider-en-pt-es-fr-enr-enb/
cd data/spider-en-pt-es-fr-enr-enb
gdown https://drive.google.com/uc?id=1gvrpgytqswz8wKx2qTZqofVqM3S32Wm8
gdown https://drive.google.com/uc?id=1M2ZWYAXK-28I6ovlGSJ_D6pJzo0wliJP
#gdown --id 1gvrpgytqswz8wKx2qTZqofVqM3S32Wm8
#gdown --id 1M2ZWYAXK-28I6ovlGSJ_D6pJzo0wliJP
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt-es-fr-enr-enb/database



echo
echo "Build English, Portuguese, Spanish, French; non-linear data augmentation (extra question/queries in train_spider.json) by rules in all four languages dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr
cp ./spider/tables.json data/spider-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/
cp ./data/spider-en-pt-es-fr/dev.json data/spider-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/
cp ./data/spider-en-pt-es-fr/train_others.json data/spider-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/
cd data/spider-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr
gdown https://drive.google.com/uc?id=1XmjUWjukShJnYlX_kCYOLaDHIU6HRqHy
#gdown --id 1XmjUWjukShJnYlX_kCYOLaDHIU6HRqHy
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/database






echo
echo "FIT"
echo
echo "Build English FIT dataset directory"
echo "The original version of the Spider dataset is distributed under the CC BY-SA 4.0 license."
mkdir data/spider-FIT-en
cp ./spider-FIT/tables.json data/spider-FIT-en/
cp ./spider/train_others.json data/spider-FIT-en/
cp ./spider/dev.json data/spider-FIT-en/
cd data/spider-FIT-en
gdown https://drive.google.com/uc?id=1uoJbTyABoFO_7-3juN7VNDA3N0LK5p_y
#gdown --id 1uoJbTyABoFO_7-3juN7VNDA3N0LK5p_y
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-en/database



echo
echo "Build English data augmentation by rules and data augmentation by backtranslation  FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
echo "dev.json is the same of spider-en, train_others.json is the same of spider-en-enr-enb" 
mkdir data/spider-FIT-en-enr-enb
cp ./spider-FIT/tables.json data/spider-FIT-en-enr-enb/
cp ./data/spider-en/dev.json data/spider-FIT-en-enr-enb/
cp ./data/spider-en-enr-enb/train_others.json data/spider-FIT-en-enr-enb/
cd data/spider-FIT-en-enr-enb
gdown https://drive.google.com/uc?id=1XzgYlKZ48W_u4O0XxyeeE8LGSY8zREEb
#gdown --id 1XzgYlKZ48W_u4O0XxyeeE8LGSY8zREEb
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-en-enr-enb/database


echo
echo "Build English non-linear data augmentation (extra question/queries in train_spider.json) 3 x by rules and 1 x by backtranslation FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
echo "dev.json is the same of spider-en, train_others.json is the same of spider-en"
mkdir data/spider-FIT-en-extra-3enr-1enb
cp ./spider-FIT/tables.json data/spider-FIT-en-extra-3enr-1enb/
cp ./data/spider-en/dev.json data/spider-FIT-en-extra-3enr-1enb/
cp ./data/spider-en/train_others.json data/spider-FIT-en-extra-3enr-1enb/
cd data/spider-FIT-en-extra-3enr-1enb
gdown https://drive.google.com/uc?id=1nO2KkWWcug-wl9pEUbu41k4CVkXOfjoM
#gdown --id 1nO2KkWWcug-wl9pEUbu41k4CVkXOfjoM
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-en-extra-3enr-1enb/database



echo
echo "Build Portuguese FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-FIT-pt
cp ./spider-FIT/tables.json data/spider-FIT-pt/
cp ./data/spider-pt/train_others.json data/spider-FIT-pt/
cp ./data/spider-pt/dev.json data/spider-FIT-pt/
cd data/spider-FIT-pt
gdown https://drive.google.com/uc?id=1MgE2V1Uncv7zTHYcmo_hVmcr1r7bBVBy
#gdown --id 1MgE2V1Uncv7zTHYcmo_hVmcr1r7bBVBy
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-pt/database

echo
echo "Build Spanish FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-FIT-es
cp ./spider-FIT/tables.json data/spider-FIT-es/
cp ./data/spider-es/train_others.json data/spider-FIT-es/
cp ./data/spider-es/dev.json data/spider-FIT-es/
cd data/spider-FIT-es
gdown https://drive.google.com/uc?id=1UrEuLL_dCxR6pAomWP6-ENDHIziXdlax
#gdown --id 1UrEuLL_dCxR6pAomWP6-ENDHIziXdlax
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-es/database

echo
echo "Build French FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-FIT-fr
cp ./spider-FIT/tables.json data/spider-FIT-fr/
cp ./data/spider-fr/train_others.json data/spider-FIT-fr/
cp ./data/spider-fr/dev.json data/spider-FIT-fr/
cd data/spider-FIT-fr
gdown https://drive.google.com/uc?id=10XCzFqcunfQCnvJxdl6jnXzPLvZhZKxq
#gdown --id 10XCzFqcunfQCnvJxdl6jnXzPLvZhZKxq
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-fr/database

echo
echo "Build  English, Portuguese, Spanish and French FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
mkdir data/spider-FIT-en-pt-es-fr
cp ./spider-FIT/tables.json data/spider-FIT-en-pt-es-fr/
cp ./data/spider-en-pt-es-fr/train_others.json data/spider-FIT-en-pt-es-fr/
cp ./data/spider-en-pt-es-fr/dev.json data/spider-FIT-en-pt-es-fr/
cd data/spider-FIT-en-pt-es-fr
gdown https://drive.google.com/uc?id=1gVf-w_ytPnc-R_TYRixKE2SiDh_4AvQ-
#gdown --id 1gVf-w_ytPnc-R_TYRixKE2SiDh_4AvQ-
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-en-pt-es-fr/database

echo
echo "Build English, Portuguese, Spanish, French; non-linear data augmentation (extra question/queries in train_spider.json) by rules in all four languages FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
echo "dev.json is the same of spider-en-pt-es-fr, train_others.json is the same of spider-en-pt-es-fr"
mkdir data/spider-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr
cp ./spider-FIT/tables.json data/spider-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/
cp ./data/spider-en-pt-es-fr/train_others.json data/spider-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/
cp ./data/spider-en-pt-es-fr/dev.json data/spider-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/
cd data/spider-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr
gdown https://drive.google.com/uc?id=1L4nn3N99S0rOmBVe4D-NeJx-xghzGoEs
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr/database


echo
echo "Build English, Portuguese, Spanish, French; Data augmentation just in English by rules and by backtranslation FIT dataset directory"
echo "The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the CC BY-SA 4.0 license, respecting ShareAlike."
echo "dev.json is the same of spider-en-pt-es-fr, train_others.json is the same of spider-en-pt-es-fr-enr-enb"
mkdir data/spider-FIT-en-pt-es-fr-enr-enb
cp ./spider-FIT/tables.json data/spider-FIT-en-pt-es-fr-enr-enb/
cp ./data/spider-en-pt-es-fr-enr-enb/train_others.json data/spider-FIT-en-pt-es-fr-enr-enb/
cp ./data/spider-en-pt-es-fr/dev.json data/spider-FIT-en-pt-es-fr-enr-enb/
cd data/spider-FIT-en-pt-es-fr-enr-enb
gdown https://drive.google.com/uc?id=1WfQNZf-oIsBfNhyosNgklgSL1gnFjh1a
#gdown https://drive.google.com/uc?id=1WfQNZf-oIsBfNhyosNgklgSL1gnFjh1a
cd ..
cd ..
ln -s $(pwd)/spider-FIT/database data/spider-FIT-en-pt-es-fr-enr-enb/database



echo "Folders structure preparation"
Name_mT5="mt5-large"

mkdir logdir/${Name_mT5}-en-train
mkdir ie_dirs/${Name_mT5}-en-train

mkdir logdir/${Name_mT5}-en-pt-es-fr-train
mkdir ie_dirs/${Name_mT5}-en-pt-es-fr-train

mkdir logdir/${Name_mT5}-en-pt-es-fr-enr-enb-train
mkdir ie_dirs/${Name_mT5}-en-pt-es-fr-enr-enb-train

mkdir logdir/${Name_mT5}-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr-train
mkdir ie_dirs/${Name_mT5}-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr-train

mkdir logdir/${Name_mT5}-FIT-en-train
mkdir ie_dirs/${Name_mT5}-FIT-en-train

mkdir logdir/${Name_mT5}-FIT-en-pt-es-fr-train
mkdir ie_dirs/${Name_mT5}-FIT-en-pt-es-fr-train

mkdir logdir/${Name_mT5}-FIT-en-pt-es-fr-enr-enb-train
mkdir ie_dirs/${Name_mT5}-FIT-en-pt-es-fr-enr-enb-train

mkdir logdir/${Name_mT5}-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr-train
mkdir ie_dirs/${Name_mT5}-FIT-en-pt-es-fr-extra-3enr-3ptr-3esr-3frr-train

Name_T5-v1_1="T5-v1_1-large"

mkdir logdir/${Name_T5-v1_1}-en-train
mkdir ie_dirs/${Name_T5-v1_1}-en-train

#mkdir logdir/${Name_T5-v1_1}-en-enr-enb-train
#mkdir ie_dirs/${Name_T5-v1_1}-en-enr-enb-train

#mkdir logdir/${Name_T5-v1_1}-en-extra-3enr-1enb-train
#mkdir ie_dirs/${Name_T5-v1_1}-en-extra-3enr-1enb-train

mkdir logdir/${Name_T5-v1_1}-FIT-en-train
mkdir ie_dirs/${Name_T5-v1_1}-FIT-en-train

mkdir logdir/${Name_T5-v1_1}-FIT-en-enr-enb-train
mkdir ie_dirs/${Name_T5-v1_1}-FIT-en-enr-enb-train

mkdir logdir/${Name_T5-v1_1}-FIT-en-extra-3enr-1enb-train
mkdir ie_dirs/${Name_T5-v1_1}-FIT-en-extra-3enr-1enb-train


Name_mBART50MtoM="mBART50MtoM-large"

mkdir logdir/${Name_mBART50MtoM}-en-train
mkdir ie_dirs/${Name_mBART50MtoM}-en-train

mkdir logdir/${Name_mBART50MtoM}-pt-train
mkdir ie_dirs/${Name_mBART50MtoM}-pt-train

mkdir logdir/${Name_mBART50MtoM}-en-pt-train
mkdir ie_dirs/${Name_mBART50MtoM}-en-pt-train

mkdir logdir/${Name_mBART50MtoM}-en-pt-es-fr-train
mkdir ie_dirs/${Name_mBART50MtoM}-en-pt-es-fr-train


Name_BERTimbau-base="BERTimbau-base"

mkdir logdir/${Name_BERTimbau-base}-pt-train
mkdir ie_dirs/${Name_BERTimbau-base}-pt-train


Name_BERTimbau-large="BERTimbau-large"

mkdir logdir/${Name_BERTimbau-large}-pt-train
mkdir ie_dirs/${Name_BERTimbau-large}-pt-train

Name_BART-large="BART-large"

mkdir logdir/${Name_BART-large}-en-train
mkdir ie_dirs/${Name_BART-large}-en-train
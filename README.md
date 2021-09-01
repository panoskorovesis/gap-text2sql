# mRAT-SQL+GAP - Multilingual version of the RAT-SQL+GAP

Based on: RAT-SQL+GAP: [Github] https://github.com/awslabs/gap-text2sql Paper [AAAI 2021 paper](https://arxiv.org/abs/2012.10309)

## Dataset

The Spider dataset translated to Portuguese and a double-size (English and Portuguese) version are available [here](https://drive.google.com/drive/folders/1U5-3eqX8vQSkVechxTViRSWD11bh-Fa-?usp=sharing)  (distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike. The source of [Spider Dataset](https://yale-lily.github.io/spider) that follow this license ) different from the other contents that is available under Apache-2.0 license.

## Results

The results are in the directory [inference-results](https://github.com/C4AI/gap-text2sql/tree/main/mrat-sql-gap/inference-results).


## Checkpoints

The checkpoints are available here:
* BART-large trained in English [Checkpoint 40300](https://drive.google.com/file/d/1F4R-WkJKtJ4lFni3q4lBug6tzSo0H5Qe/view?usp=sharing)
* BERTimbau-base trained in Portuguese [Checkpoint 24100](https://drive.google.com/file/d/1gIZS0RuIxdjmm7sNbA3R6p6--9iMJmW8/view?usp=sharing)
* BERTimbau-large trained in Portuguese [Checkpoint 40100](https://drive.google.com/file/d/1q1NOxisOcIdkMftzGPVxBDn989LDDG3X/view?usp=sharing)
* mBART50MtoM-large trained in English [Checkpoint 23100](https://drive.google.com/file/d/16mQf1gMTVGkvONUGpzELzkjCFX5M74cO/view?usp=sharing)
* mBART50MtoM-large trained in Portuguese [Checkpoint 39100](https://drive.google.com/file/d/1fWPH4bG9-UjW-p6OgmpINWLLsnOopWLh/view?usp=sharing)
* mBART50MtoM-large trained in English and Portuguese (together) [Checkpint 41000 Best inferences in Portuguese](https://drive.google.com/file/d/1szb44h_2t3fK2Vc02PdaAjDqnkWqM-0U/view?usp=sharing)
* mBART50MtoM-large trained in English and Portuguese (together) [Checkpint 21100 Best inferences in English](https://drive.google.com/file/d/1MeLkvGf9-5it1JXnUvU9AmXVnnbAAfP0/view?usp=sharing)
* mBART50MtoM-large trained in English, Portuguese, Spanish and French (together) [Checkpint 39100 Best inferences in English](https://drive.google.com/file/d/18nioEDEpZf-6CNH_sU3IMZxsSNts_a4y/view?usp=sharing)
* mBART50MtoM-large trained in English, Portuguese, Spanish and French (together) [Checkpint 42100 Best inferences in Portuguese and Spanish](https://drive.google.com/file/d/1AmJjyVHiP9V-FzW9Q1sXge4YMWAP-srg/view?usp=sharing)
* mBART50MtoM-large trained in English, Portuguese, Spanish and French (together) [Checkpint 44100 Best inferences in French](https://drive.google.com/file/d/1P0F218tNkW42Pb7okn3uFyTT5sy4zGZR/view?usp=sharing)
* mT5-large trained in English [Checkpoint 50100](https://drive.google.com/file/d/1BZ519XxYtXpxxO1iiBy8kSLG4eq34yEX/view?usp=sharing)
* mT5-large trained in English, Portuguese, Spanish and French (together) [Checkpint 51100 Best inferences in English](https://drive.google.com/file/d/15C8H-OrnmBF5W-UCaMsq-UvpBTPkUCYN/view?usp=sharing)
* mT5-large trained in English, Portuguese, Spanish and French (together) [Checkpint 42100 Best inferences in Portuguese](https://drive.google.com/file/d/1mIXtBIaQpWJOHi_iCTkwm8xdPW9S8vtd/view?usp=sharing)
* mT5-large trained in English, Portuguese, Spanish and French (together) [Checkpint 50100 Best inferences in Spanish and French](https://drive.google.com/file/d/1i731DxdcNVbpegCNGMHi7jOR26qaPmbO/view?usp=sharing)


## Updates


## Abstract

mRAT-SQL+GAP is a multilingual version of the RAT-SQL+GAP, wich start with Portuguese Language. Here is available the code, dataset and the results.


## Directory Structure
Go to the directory where you want to install the structure
```bash
git clone https://github.com/C4AI/gap-text2sql
cd gap-text2sql/mrat-sql-gap 
```

## Conda mtext2slq Environment Setup
```bash
conda create --name mtext2sql python=3.7
conda activate mtext2sql
conda install pytorch=1.5 cudatoolkit=10.2 -c pytorch
pip install -r requirements.txt
python -c "import nltk; nltk.download('stopwords'); nltk.download('punkt')"
```



## Setup Script
Just run this script below 
```bash
chmod +x setup.sh
./setup.sh
```
or follow this steps:

### Download the Spider dataset (english)
The original version of the Spider dataset is distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license.
```bash
pip install gdown
gdown --id 1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0
unzip spider.zip
bash data/spider/generate.sh ./spider
rm spider.zip
```

### Build English dataset directory
```bash
mkdir data/spider-en
cp ./spider/train_spider.json data/spider-en/
cp ./spider/train_others.json data/spider-en/
cp ./spider/dev.json data/spider-en/
cp ./spider/tables.json data/spider-en/
ln -s $(pwd)/spider/database data/spider-en/database
```

### Build Portuguese dataset directory
The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike.
```bash
mkdir data/spider-pt
cp ./spider/tables.json data/spider-pt/
cd data/spider-pt
gdown --id 1rU79PipqU6XDIzqtYuS2Lg_LTYLbyN9U
gdown --id 1no9qKojtDTAwFTm9MqZTOjjTupiEy7Ir
gdown --id 1HTNEUihVDuEg1hvLDbJd3yxXngJp3u4v
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-pt/database
```

### Build Spanish dataset directory
The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike.
```bash
mkdir data/spider-es
cp ./spider/tables.json data/spider-es/
cd data/spider-es
gdown --id 1utYMsytUVRaozo50qjkQGwS2vDUWp4kD
gdown --id 1aSNetfAote7eG0lzDCJSPukT84abEtIN
gdown --id 1UoFGQMvRkV7wBRyqhqu49Luu1Gs_HSi8
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-es/database
```

### Build French dataset directory
The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike.
```bash
mkdir data/spider-fr
cp ./spider/tables.json data/spider-fr/
cd data/spider-fr
gdown --id 1VC8IiOSY2Oaq6eCJJjf0pplHtVXPhOXi
gdown --id 1GmqiKa3-W1soEKadpY3L2fXiKLzf_6Ps
gdown --id 1NdALreT67okWPwIKuiVP6y2xWyZUtUf7
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-fr/database
```

### Build English and Portuguese dataset directory
The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the  [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike.
```bash
mkdir data/spider-en-pt
cp ./spider/tables.json data/spider-en-pt/
cd data/spider-en-pt
gdown --id 1ph3ttcoaHMJvsI4yFhENHHuH_4M-UH53
gdown --id 1odAFfyTM3N5y8QqQE5oUEt9CZZQ60CpS
gdown --id 1HOM5GNPiO_o4NeQTVzpgymyABPgUPbbr
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt/database
```


### Build English, Portuguese, Spanish and French dataset directory
The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the  [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike.
```bash
mkdir data/spider-en-pt-es-fr
cp ./spider/tables.json data/spider-en-pt-es-fr/
cd data/spider-en-pt
gdown --id 18xoEkF5XdbfaN5SwqsbbMw89Y3iNvAa9
gdown --id 1n2U1pBzzRDAZuqmjloj6CV4Btf5sKfvd
gdown --id 1diKAP4BGccFzupvf3HCcPleRP5EMqSHM
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt-es-fr/database
```

### Download the BART checkpoint
```bash
mkdir ie_dirs

mkdir -p logdir/BART-large-en-train/bs\=12\,lr\=1.0e-04\,bert_lr\=1.0e-05\,end_lr\=0e0\,att\=1/
curl https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/gap-finetuned-checkpoint -o logdir/BART-large-en-train/bs\=12\,lr\=1.0e-04\,bert_lr\=1.0e-05\,end_lr\=0e0\,att\=1/model_checkpoint-00041000

mkdir -p pretrained_checkpoint
curl https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/pretrained-checkpoint -o pretrained_checkpoint/pytorch_model.bin

```

Alternatively, you can download them here if you don't have awscli:
[gap-finetuned-checkpoint](https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/gap-finetuned-checkpoint)
and [pretrained-checkpoint](https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/pretrained-checkpoint)

If you prefer to use:
```bash
aws s3 cp s3://gap-text2sql-public/checkpoint-artifacts/gap-finetuned-checkpoint logdir/BART-large-en-train/bs\=12\,lr\=1.0e-04\,bert_lr\=1.0e-05\,end_lr\=0e0\,att\=1/model_checkpoint-00041000
aws s3 cp s3://gap-text2sql-public/checkpoint-artifacts/pretrained-checkpoint pretrained_checkpoint/pytorch_model.bin
```


### Preprocess dataset
This is good to validate the setup. It will take some time, maybe 40 minutes.
```bash
python run.py preprocess experiments/spider-configs/gap-run.jsonnet
```
You can see the files processed in the paths:
`data/spider-en/nl2code-1115,output_from=true,fs=2,emb=bart,cvlink`

## Inference
This is good to validate de setup. 
```bash
python run.py eval experiments/spider-configs/gap-run.jsonnet
```

You then get the inference results and evaluation results in the paths:

`ie_dirs/BART-large-en-train/bart-large-en_run_1_true_1-step41000.infer` 

and 

`ie_dirs/BART-large-en-train/bart-large-en_run_1_true_1-step41000.eval`.

## Training
Execute if it is really necessary, if you want to fine-tune the model, this will take a long time... some days. But if you have a good machine available and want to see different checkpoints in the logdir, do it.

```bash
python run.py train experiments/spider-configs/gap-run.jsonnet
```
You then get the training checkpoints in the paths:
`logdir/BART-large-en-train`

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.

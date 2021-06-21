# mRAT-SQL+GAP - Multilingual version of the RAT-SQL+GAP

Based on: RAT-SQL+GAP: [Github] https://github.com/awslabs/gap-text2sql Paper [AAAI 2021 paper](https://arxiv.org/abs/2012.10309)

## Dataset

The Spider dataset translated to Portuguese and a double-size (English and Portuguese) version are available [here](https://drive.google.com/drive/folders/1U5-3eqX8vQSkVechxTViRSWD11bh-Fa-?usp=sharing)  (distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike. The source of [Spider Dataset](https://yale-lily.github.io/spider) that follow this license ) different from the other contents that is available under Apache-2.0 license.

## Results

The results are in the directory [inference-results](https://github.com/C4AI/gap-text2sql/tree/main/mrat-sql-gap/inference-results).


## Checkpoints

The checkpoints are available [here](https://drive.google.com/drive/folders/1XSmCsb-xrIzrrMFmRzS7iaAn9QthDm05?usp=sharing)


## Updates

[2020/02/05] Support to run the model on own databases and queries. Check out the [notebook](rat-sql-gap/notebook.ipynb). 

## Abstract

mRAT-SQL+GAP is a multilingual version of the RAT-SQL+GAP, wich start with Portuguese Language. Here is available the code, dataset and the results.



## Setup
```bash
conda create --name gap-text2sql python=3.7
conda activate gap-text2sql
conda install pytorch=1.5 cudatoolkit=10.2 -c pytorch
pip install -r requirements.txt
python -c "import nltk; nltk.download('stopwords'); nltk.download('punkt')"
```

## Directory Structure
Go to the directory where you want to install the structure
```bash
git clone https://github.com/C4AI/gap-text2sql
cd gap-text2sql/mrat-sql-gap 
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
gdown --id 12JjlnOsWxLDtOV2cK-3ggsAtBeqU1vYp
gdown --id 1FeVYW3fR1A3Ls-Es-0H_QkB3mRw8QCFx
gdown --id 1UvEFBTAqcrmibUfxTOLo41viIifh7g6K
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-pt/database
```

### Build English and Portuguese dataset directory
The modified versions of train_spider.json, train_others.json, and dev.json are distributed under the  [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike.
```bash
mkdir data/spider-en-pt
cp ./spider/tables.json data/spider-en-pt/
cd data/spider-en-pt
gdown --id 1qFaSvUU1d4ZxYA7q4fRqjPTfZH9zjQ-x
gdown --id 1c6CEnenCkpW9Ugk_OHhawGb39_-DeY1y
gdown --id 1ZRIlwCOwi2VjaxADisf7QpFSVIyMONGe
cd ..
cd ..
ln -s $(pwd)/spider/database data/spider-en-pt/database
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

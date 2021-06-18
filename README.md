# mRAT-SQL+GAP - Multilingual version of the RAT-SQL+GAP

Based on: RAT-SQL+GAP: [Github] https://github.com/awslabs/gap-text2sql Paper [AAAI 2021 paper](https://arxiv.org/abs/2012.10309)

## Dataset

The Spider dataset translated to Portuguese and a double-size (English and Portuguese) version are available [here](https://drive.google.com/drive/folders/1U5-3eqX8vQSkVechxTViRSWD11bh-Fa-?usp=sharing)  (distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, to respect the source of [Spider Dataset](https://yale-lily.github.io/spider) that follow this license ) different from the other contents that is available under Apache-2.0 license.

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
source activate gap-text2sql
conda install pytorch=1.5 cudatoolkit=10.2 -c pytorch
pip install -r requirements.txt
python -c "import nltk; nltk.download('stopwords'); nltk.download('punkt')"
```

### Download the dataset
```bash
pip install gdown
cd rat-sql-gap
gdown --id 1_AckYkinAnhqmRQtGsQgUKAnTHxxX5J0
unzip spider.zip
bash data/spider/generate.sh ./spider
```

### Build dataset directory
```bash
mkdir data/spider-bart
cp ./spider/tables.json data/spider-bart/
cp ./spider/train_spider.json data/spider-bart/
cp ./spider/train_others.json data/spider-bart/
cp ./spider/dev.json data/spider-bart/
ln -s $(pwd)/spider/database data/spider-bart/database
```

### Download the library
```bash
mkdir third_party
wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
unzip stanford-corenlp-full-2018-10-05.zip -d third_party/
```

### Start the Stanford library
```bash
pushd third_party/stanford-corenlp-full-2018-10-05
nohup java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 8999 -timeout 15000 > server.log &
popd
```

### Download the checkpoint
```bash
mkdir -p logdir/bart_run_1/bs\=12\,lr\=1.0e-04\,bert_lr\=1.0e-05\,end_lr\=0e0\,att\=1/
mkdir ie_dirs
aws s3 cp s3://gap-text2sql-public/checkpoint-artifacts/gap-finetuned-checkpoint logdir/bart_run_1/bs\=12\,lr\=1.0e-04\,bert_lr\=1.0e-05\,end_lr\=0e0\,att\=1/model_checkpoint-00041000

mkdir -p pretrained_checkpoint
aws s3 cp s3://gap-text2sql-public/checkpoint-artifacts/pretrained-checkpoint pretrained_checkpoint/pytorch_model.bin
```

Alternatively, you can download them here if you don't have awscli:
[gap-finetuned-checkpoint](https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/gap-finetuned-checkpoint)
and [pretrained-checkpoint](https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/pretrained-checkpoint)

```bash
curl https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/gap-finetuned-checkpoint -o logdir/bart_run_1/bs\=12\,lr\=1.0e-04\,bert_lr\=1.0e-05\,end_lr\=0e0\,att\=1/model_checkpoint-00041000
curl https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/pretrained-checkpoint -o pretrained_checkpoint/pytorch_model.bin
```


### Preprocess dataset
```bash
python run.py preprocess experiments/spider-configs/gap-run.jsonnet
```

## Inference
```bash
python run.py eval experiments/spider-configs/gap-run.jsonnet
```

You then get the inference results and evaluation results in the paths:`ie_dirs/bart_run_1_true_1-step41000.infer` and `ie_dirs/bart_run_1_true_1-step41000.eval`.

## Training

```bash
python run.py train experiments/spider-configs/gap-run.jsonnet
```

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.

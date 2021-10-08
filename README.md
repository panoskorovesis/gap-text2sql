# mRAT-SQL+GAP - Multilingual version of the RAT-SQL+GAP
Code and model from our BRACIS 2021 paper, [here the pre-print in arXiv] (https://arxiv.org/abs/2110.03546).

Based on: RAT-SQL+GAP: [Github](https://github.com/awslabs/gap-text2sql) Paper [AAAI 2021 paper](https://arxiv.org/abs/2012.10309)


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
conda install jupyter notebook
conda install -c conda-forge jupyter_contrib_nbextensions
```



## Setup Script
Just run this script below, it will copy the datasets.
The original version of the Spider dataset is distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license.
The modified versions (translated to Portuguese, Spanish, French, double-size(English and Portuguese) and quad-size (English, Portuguese, Spanish and French)) of train_spider.json, train_others.json, and dev.json are distributed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license, respecting ShareAlike.

```bash
chmod +x setup.sh
./setup.sh
```

## Specific setup
The models and checkpoints have big files (GBytes), so if you have enough disk space you can run all shell scripts. To understand how things work, run just BART_large.sh and after run the others.
```bash
./BART_large.sh
./mBART50MtoM-large.sh
./mT5_large.sh
./BERTimbau-base.sh
./BERTimbau-large.sh
```

## Environment Test
Now the environment is ready for training (fine-tune) and inferences. The training is very slow more than 60 hours for BART, BERTimbau, mBART50, and more than 28 hours for mT5. Therefore I recommend testing the environment with the inference.

### Preprocess dataset
This preprocess step is necessary both for inference and for training. It will take some time, maybe 40 minutes.
I will use the script for BART, but you can use the other, look the directory experiments/spider-configs
```bash
python run.py preprocess experiments/spider-configs/spider-BART-large-en-train_en-eval.jsonnet
```
You can see the files processed in the paths:
`data/spider-en/nl2code-1115,output_from=true,fs=2,emb=bart,cvlink`

## Inference
I will use the script for BART again. 
Note: We are making inferences using the checkpoint already trained (directory logdir) and defined in:
`experiments/spider-configs/spider-BART-large-en-train_en-eval.jsonnet`
`logdir: "logdir/BART-large-en-train",` and  
`eval_steps: [40300],`
```bash
python run.py eval experiments/spider-configs/spider-BART-large-en-train_en-eval.jsonnet
```

You then get the inference results and evaluation results in the paths:

`ie_dirs/BART-large-en-train/bart-large-en_run_1_true_1-step41000.infer` 

and 

`ie_dirs/BART-large-en-train/bart-large-en_run_1_true_1-step41000.eval`.

## Training
Execute if it is really necessary, if you want to fine-tune the model, this will take a long time. But if you have a good machine available and want to see different checkpoints in the logdir, do it.

```bash
python run.py train experiments/spider-configs/spider-BART-large-en-train_en-eval.jsonnet
```
You then get the training checkpoints in the paths:
`logdir/BART-large-en-train`

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



## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.

#!/bin/bash
echo "Folders structure preparation"
Name="BART-large"

mkdir logdir/${Name}-en-train
mkdir ie_dirs/${Name}-en-train
mkdir models/${Name}
mkdir models/${Name}/pretrained_checkpoint

echo "Model Download - ATTENTION: REVIEW THE FILES SIZES "
cd models/${Name}/pretrained_checkpoint

curl https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/pretrained-checkpoint -o pytorch_model.bin
cd ..
cd ..
cd ..

echo "Download Checkpoint"
cd logdir/${Name}-en-train
mkdir bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
cd bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
gdown --id 1F4R-WkJKtJ4lFni3q4lBug6tzSo0H5Qe
curl https://gap-text2sql-public.s3.amazonaws.com/checkpoint-artifacts/gap-finetuned-checkpoint -o model_checkpoint-00041000
cd ..
cd ..
cd ..







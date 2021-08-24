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

 







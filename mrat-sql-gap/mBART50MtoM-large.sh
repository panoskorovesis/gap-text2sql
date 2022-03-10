#!/bin/bash
echo "Folders structure preparation"
Name="mBART50MtoM-large"

#mkdir logdir/${Name}-en-train
#mkdir ie_dirs/${Name}-en-train

#mkdir logdir/${Name}-pt-train
#mkdir ie_dirs/${Name}-pt-train

#mkdir logdir/${Name}-en-pt-train
#mkdir ie_dirs/${Name}-en-pt-train

#mkdir logdir/${Name}-en-pt-es-fr-train
#mkdir ie_dirs/${Name}-en-pt-es-fr-train
#--

#mkdir models/${Name}
#mkdir models/${Name}/pretrained_checkpoint

#echo "Model Download - ATTENTION: REVIEW THE FILES SIZES "
#cd models/${Name}/pretrained_checkpoint
#curl https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt/resolve/main/config.json -o config.json
#curl https://cdn-lfs.huggingface.co/facebook/mbart-large-50-many-to-many-mmt/024ddcc796a33d2e4decd4c1bd5fe90ad295aaba9072edb3796a09ef9b755934 -o pytorch_model.bin
#curl https://cdn-lfs.huggingface.co/facebook/mbart-large-50-many-to-many-mmt/cfc8146abe2a0488e9e2a0c56de7952f7c11ab059eca145a0a727afce0db2865 -o sentencepiece.bpe.model
#curl https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt/resolve/main/special_tokens_map.json -o special_tokens_map.json
#curl https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt/resolve/main/tokenizer_config.json -o tokenizer_config.json
#cd ..
#cd ..
#cd ..

echo "Download Checkpoint"
cd logdir/${Name}-en-train
mkdir bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
cd bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
gdown --id 16mQf1gMTVGkvONUGpzELzkjCFX5M74cO
cd ..
cd ..
cd ..


cd logdir/${Name}-pt-train
mkdir bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
cd bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
gdown --id 1fWPH4bG9-UjW-p6OgmpINWLLsnOopWLh
cd ..
cd ..
cd ..


cd logdir/${Name}-en-pt-train
mkdir bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
cd bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
gdown --id 1szb44h_2t3fK2Vc02PdaAjDqnkWqM-0U
gdown --id 1MeLkvGf9-5it1JXnUvU9AmXVnnbAAfP0
cd ..
cd ..
cd ..


cd logdir/${Name}-en-pt-es-fr-train
mkdir bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
cd bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1
gdown --id 18nioEDEpZf-6CNH_sU3IMZxsSNts_a4y
gdown --id 1AmJjyVHiP9V-FzW9Q1sXge4YMWAP-srg
gdown --id 1P0F218tNkW42Pb7okn3uFyTT5sy4zGZR
cd ..
cd ..
cd ..

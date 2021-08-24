#!/bin/bash
echo "Folders structure preparation"
Name="mBART50MtoM-large"

mkdir logdir/${Name}-en-pt-es-fr-train
mkdir ie_dirs/${Name}-en-pt-es-fr-train
mkdir models/${Name}
mkdir models/${Name}/pretrained_checkpoint

echo "Model Download - ATTENTION: REVIEW THE FILES SIZES "
cd models/${Name}/pretrained_checkpoint
curl https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt/resolve/main/config.json -o config.json
curl https://cdn-lfs.huggingface.co/facebook/mbart-large-50-many-to-many-mmt/024ddcc796a33d2e4decd4c1bd5fe90ad295aaba9072edb3796a09ef9b755934 -o pytorch_model.bin
curl https://cdn-lfs.huggingface.co/facebook/mbart-large-50-many-to-many-mmt/cfc8146abe2a0488e9e2a0c56de7952f7c11ab059eca145a0a727afce0db2865 -o sentencepiece.bpe.model
curl https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt/resolve/main/special_tokens_map.json -o special_tokens_map.json
curl https://huggingface.co/facebook/mbart-large-50-many-to-many-mmt/resolve/main/tokenizer_config.json -o tokenizer_config.json
cd ..
cd ..
cd ..






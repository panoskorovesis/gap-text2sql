#!/bin/bash
echo "Folders structure preparation"
Name="mt5-large"

mkdir logdir/${Name}-en-pt-es-fr-train
mkdir ie_dirs/${Name}-en-pt-es-fr-train
mkdir models/${Name}
mkdir models/${Name}/pretrained_checkpoint

echo "Model Download - ATTENTION: REVIEW THE FILES SIZES "
cd models/${Name}/pretrained_checkpoint
curl https://huggingface.co/google/mt5-large/resolve/main/README.md -o README.md
curl https://huggingface.co/google/mt5-large/resolve/main/config.json -o config.json
curl https://cdn-lfs.huggingface.co/google/mt5-large/b6ce477860d6630efbc821a2a42638e8cf77686ee0e2f4b98037dcfd4d40415c -o pytorch_model.bin
curl https://huggingface.co/google/mt5-large/resolve/main/special_tokens_map.json -o special_tokens_map.json
curl https://huggingface.co/google/mt5-large/resolve/main/spiece.model -o spiece.model
curl https://cdn-lfs.huggingface.co/google/mt5-large/f28f11f442f5850133fa50b2d5aefa8d19ab51469c56e0e89090534c2c7758c3 -o tf_model.h5
curl https://huggingface.co/google/mt5-large/resolve/main/tokenizer_config.json -o tokenizer_config.json
cd ..
cd ..
cd ..


 







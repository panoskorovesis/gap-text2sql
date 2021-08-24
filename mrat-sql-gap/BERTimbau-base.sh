#!/bin/bash
echo "Folders structure preparation"
Name="BERTimbau-base"

mkdir logdir/${Name}-pt-train
mkdir ie_dirs/${Name}-pt-train
mkdir models/${Name}
mkdir models/${Name}/pretrained_checkpoint

cd models/${Name}/pretrained_checkpoint
curl https://huggingface.co/neuralmind/bert-base-portuguese-cased/resolve/main/added_tokens.json -o added_tokens.json
curl https://huggingface.co/neuralmind/bert-base-portuguese-cased/resolve/main/config.json -o config.json 
curl https://cdn-lfs.huggingface.co/neuralmind/bert-base-portuguese-cased/96d2144445b6ba3530c27e38e7e27139fd0b0a5e36d9ca66f4155da7c5f199b0 -o flax_model.msgpack
curl https://cdn-lfs.huggingface.co/neuralmind/bert-base-portuguese-cased/cb1693767adef60abf23d9fde3996f0c1e6310afad103a2db94ad44854568955 -o pytorch_model.bin
curl https://huggingface.co/neuralmind/bert-base-portuguese-cased/resolve/main/special_tokens_map.json -o special_tokens_map.json
curl https://huggingface.co/neuralmind/bert-base-portuguese-cased/resolve/main/tokenizer_config.json -o tokenizer_config.json
curl https://huggingface.co/neuralmind/bert-base-portuguese-cased/resolve/main/vocab.txt -o vocab.txt
cd ..
cd ..
cd ..





#!/bin/bash
echo "Folders structure preparation"
Name="BERTimbau-large"

mkdir logdir/${Name}-pt-train
mkdir ie_dirs/${Name}-pt-train
mkdir models/${Name}
mkdir models/${Name}/pretrained_checkpoint

cd models/${Name}/pretrained_checkpoint
curl https://huggingface.co/neuralmind/bert-large-portuguese-cased/resolve/main/added_tokens.json -o added_tokens.json
curl https://huggingface.co/neuralmind/bert-large-portuguese-cased/resolve/main/config.json -o config.json
curl https://cdn-lfs.huggingface.co/neuralmind/bert-large-portuguese-cased/9af4f60f0bdd71e483baf8a1dd3e3dc509ceeaa7dd2007ed63f110b5c990e6e6 -o flax_model.msgpack
curl https://cdn-lfs.huggingface.co/neuralmind/bert-large-portuguese-cased/48f211712fdad2263e35c368b0ec79ad635c2df0acb275152e0f7cbd165bb7ca -o pytorch_model.bin
curl https://huggingface.co/neuralmind/bert-large-portuguese-cased/resolve/main/special_tokens_map.json -o special_tokens_map.json
curl https://huggingface.co/neuralmind/bert-large-portuguese-cased/resolve/main/tokenizer_config.json -o tokenizer_config.json
curl https://huggingface.co/neuralmind/bert-large-portuguese-cased/resolve/main/vocab.txt -o vocab.txt
cd ..
cd ..
cd ..





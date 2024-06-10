import argparse
import json
import os

import _jsonnet
import tqdm

from seq2struct import datasets
from seq2struct import models
from seq2struct.utils import registry
from seq2struct.utils import vocab

class Preprocessor:
    def __init__(self, config):
        self.config = config
        self.model_preproc = registry.instantiate(
            registry.lookup('model', config['model']).Preproc,
            config['model'])

    def preprocess(self):
        self.model_preproc.clear_items()
        for section in self.config['data']:
            print(f"\n*********************************************\nself.config['data'][section]={self.config['data'][section]}\n*********************************************\n") #gostei deste print 
            
            
            path_to_file = self.config['data'][section]['paths'][0]
            # Restore the dev file if it had been altered
            if 'dev' in path_to_file.lower():
            	path_to_dev = self.config['data'][section]['paths'][0]
                # Extract the directory and the file name
            	directory = os.path.dirname(path_to_dev)
            	dev_file_name = os.path.basename(path_to_dev)
            	files_in_directory = os.listdir(directory)
            	initial_dev_file = f'initial_{dev_file_name}'
            	if initial_dev_file in files_in_directory:
                    # Remove the file
                	os.remove(path_to_dev)
                	initial_dev_file_path = os.path.join(directory, initial_dev_file)
                	os.rename(initial_dev_file_path, path_to_dev)
            
            data = registry.construct('dataset', self.config['data'][section])
            skipped_counter = 0
            total_counter = 0
            
            if 'dev' in path_to_file.lower():
                list_with_valid_dev_questions = []
                dev_needs_update = False
                
                for item in tqdm.tqdm(data, desc=section, dynamic_ncols=True):
                    to_add, validation_info = self.model_preproc.validate_item(item, section)
                    if to_add:
                        self.model_preproc.add_item(item, section, validation_info)
                        list_with_valid_dev_questions.append(item.orig)
                    else:
                        skipped_counter += 1
                        dev_needs_update = True

                    total_counter += 1
                    # print(item.orig)
                    # break

                print(f'Skipped {skipped_counter} records for {section}.')
                print(f'Initial size: {total_counter} Final Size: {total_counter - skipped_counter}.')
            
            else:
                for item in tqdm.tqdm(data, desc=section, dynamic_ncols=True):
                    to_add, validation_info = self.model_preproc.validate_item(item, section)
                    if to_add:
                        self.model_preproc.add_item(item, section, validation_info)
                    else:
                        skipped_counter += 1

                    total_counter += 1
                    # print(item.orig)
                    # break

                print(f'Skipped {skipped_counter} records for {section}.')
                print(f'Initial size: {total_counter} Final Size: {total_counter - skipped_counter}.')
        if dev_needs_update:
            self.model_preproc.save_and_update_dev(path_to_dev, list_with_valid_dev_questions)
        else:
            self.model_preproc.save()

def add_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('--config', required=True)
    parser.add_argument('--config-args')
    args = parser.parse_args()
    return args

def main(args):
    if args.config_args:
        config = json.loads(_jsonnet.evaluate_file(args.config, tla_codes={'args': args.config_args}))
    else:
        config = json.loads(_jsonnet.evaluate_file(args.config))

    preprocessor = Preprocessor(config)
    preprocessor.preprocess()
    
def main2(args, val_data_path):
    if args.config_args:
        config = json.loads(_jsonnet.evaluate_file(args.config, tla_codes={'args': args.config_args}))
    else:
        config = json.loads(_jsonnet.evaluate_file(args.config))
    
    #print("\nOriginal val data path")
    #print(f"Dataset val(data val paths):{config['data']['val']['paths']}")
    #print(type(config['data']['val']['paths']))
    #print(f"Dataset val(data val tables_paths):{config['data']['val']['tables_paths']}")
    
    #use the command line validation data path
    config['data']['val']['paths'][0] = val_data_path + "dev.json"
    config['data']['val']['tables_paths'][0] = val_data_path + "tables.json"

    #print("\nUpdated val data path")
    print(f"Preprocess Dataset val(data val paths):{config['data']['val']['paths']}")
    #print(type(config['data']['val']['paths']))
    print(f"Preprocess Dataset val(data val tables_paths):{config['data']['val']['tables_paths']}\n")

    preprocessor = Preprocessor(config)
    preprocessor.preprocess()

if __name__ == '__main__':
    args = add_parser()
    main(args)

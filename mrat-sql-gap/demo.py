
import json
import os
import _jsonnet
import os
import warnings
import pandas as pd
warnings.filterwarnings('ignore')

from seq2struct.commands.infer import Inferer
from seq2struct.datasets.spider import SpiderItem
from seq2struct.utils import registry

import torch

from IPython.display import Markdown, display
def printmd(string):
    display(Markdown(string))

# Define a function to load JSON data from a file
def load_json(filename):
    # Open the specified file in read mode, specifying utf-8 encoding
    with open(filename, 'r', encoding='utf-8') as file:
        # Load the JSON data from the file into a Python dictionary
        data = json.load(file)
    # Return the loaded data
    return data

def createPath(lr, bert_lr, end_lr, bs, att):
    lr_s = '%0.1e' % lr
    bert_lr_s = '%0.1e' % bert_lr
    end_lr_s = '0e0' if end_lr == 0 else '%0.1e' % end_lr

    base_bert_enc_size = 768
    enc_size = base_bert_enc_size

    model_name = '/bs=%(bs)d,lr=%(lr)s,bert_lr=%(bert_lr)s,end_lr=%(end_lr)s,att=%(att)d' % {
        'bs': bs,
        'lr': lr_s,
        'bert_lr': bert_lr_s,
        'end_lr': end_lr_s,
        'att': att
    }
    return model_name

# exp_config = json.loads(_jsonnet.evaluate_file("experiments/spider-configs/gap-run.jsonnet"))
exp_config = json.loads(_jsonnet.evaluate_file("experiments/spider-configs/spider-mT5-base-gr-train_gr_eval.jsonnet"))

model_config_path = exp_config["model_config"]
model_config_args = exp_config.get("model_config_args")

#print(model_config_path)
#print(model_config_args)

infer_config = json.loads(
    _jsonnet.evaluate_file(
        model_config_path, 
        tla_codes={'args': json.dumps(model_config_args)}))

#print(infer_config['model']['encoder_preproc'])

db_path = infer_config["model"]["encoder_preproc"]["db_path"]

db_path_for_json = infer_config['data']['val']['tables_paths'][0]

#db_path_for_json

inferer = Inferer(infer_config)

# model_dir = exp_config["logdir"] + "/bs=12,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1"
# checkpoint_step = exp_config["eval_steps"][0]

# '/home/studio-lab-user/gr-spider/Database-Systems/gap-text2sql/mrat-sql-gap/logdir/mT5-base-en-train/bs=4,lr=1.0e-04,bert_lr=1.0e-05,end_lr=0e0,att=1/val_loss.txt'
logdir_path = exp_config["logdir"]
path_save = createPath(model_config_args['lr'], model_config_args['bert_lr'], model_config_args['end_lr'], model_config_args['bs'], model_config_args['att'])
model_dir = logdir_path + path_save

checkpoint_step = exp_config["eval_steps"][0]

model = inferer.load_model(model_dir, checkpoint_step)

from seq2struct.datasets.spider_lib.preprocess.get_tables import dump_db_json_schema
from seq2struct.datasets.spider import load_tables_from_schema_dict

def get_schema_dict_by_db_id(list_of_schemas_dicts, db_id):
    return [schema_info for schema_info in list_of_schemas_dicts if db_id in schema_info['db_id']][0]

def create_dfs_from_schema(schema):
    # Create DataFrame for table names
    table_names_df = pd.DataFrame({
        'table_names_original': schema['table_names_original'],
        'table_names': schema['table_names']
    })

    # Map table indices to table names
    table_index_to_name = {index: name for index, name in enumerate(schema['table_names'])}
    
    # Create DataFrame for column names with table names
    column_data = []
    for col_index, (table_index, col_name) in enumerate(schema['column_names']):
        table_name = table_index_to_name[table_index] if table_index != -1 else 'N/A'
        is_primary_key = col_index in schema['primary_keys']
        column_data.append((col_index, table_name, schema['column_names_original'][col_index][1], col_name, schema['column_types'][col_index], is_primary_key))

    column_names_df = pd.DataFrame(column_data, columns=['column_index', 'table_name', 'column_names_original', 'column_names', 'column_types', 'is_primary_key'])
    
    column_index_to_name = [name for index, name in schema['column_names']]

    # Create DataFrame for primary keys
    primary_keys_df = pd.DataFrame({
    'table_name': [table_index_to_name[schema['column_names'][x][0]] for x in schema['primary_keys']],
    'primary_key_column_index': schema['primary_keys'],
    'primary_key': [column_index_to_name[x] for x in schema['primary_keys']]
    })

    
    column_index_to_id = {index: name for index, name in enumerate(schema['column_names'])}
    
    foreign_keys_df = pd.DataFrame({
    'foreign_key_column': [x[0] for x in schema['foreign_keys']],
    'referenced_column': [x[1] for x in schema['foreign_keys']],
    'foreign_key_table': [table_index_to_name[column_index_to_id[x[0]][0]] for x in schema['foreign_keys']],
    'foreign_key_column_name': [column_index_to_id[x[0]][1] for x in schema['foreign_keys']],
    'referenced_table': [table_index_to_name[column_index_to_id[x[1]][0]] for x in schema['foreign_keys']],
    'referenced_column_name': [column_index_to_id[x[1]][1] for x in schema['foreign_keys']]
    }) 

    return table_names_df, column_names_df, primary_keys_df, foreign_keys_df

def infer(question, spider_schema):
    data_item = SpiderItem(
            text=None,  # intentionally None -- should be ignored when the tokenizer is set correctly
            code=None,
            schema=spider_schema,
            orig_schema=spider_schema.orig,
            orig={"question": question}
        )
    model.preproc.clear_items()
    enc_input = model.preproc.enc_preproc.preprocess_item(data_item, None)
    preproc_data = enc_input, None
    with torch.no_grad():
        output = inferer._infer_one(model, data_item, preproc_data, beam_size=1, use_heuristic=True)
    return output[0]["inferred_code"]

schemas = os.listdir(db_path)

schemas_list = load_json(db_path_for_json)

import random
N=len(schemas)

selected_schemas = random.choices(schemas, k=N)
#print('You can choose a database from the below:')
print(', '.join(selected_schemas))

db_id = input("Choose a database from above:': ")
#db_id = 'game_injury'

#selected_schema = dump_db_json_schema("{path}/{db_id}/{db_id}.sqlite".format(path=db_path, db_id=db_id), db_id)
selected_schema = get_schema_dict_by_db_id(schemas_list, db_id)

#from seq2struct.utils.api_utils import refine_schema_names
# If you want to change your schema name, then run this; Otherwise you can skip this.
#refine_schema_names(my_schema)

selected_schema

table_names_df, column_names_df, primary_keys_df, foreign_keys_df = create_dfs_from_schema(selected_schema)

print(table_names_df)

print(column_names_df)

print(primary_keys_df)

print(foreign_keys_df)

schema, eval_foreign_key_maps = load_tables_from_schema_dict(selected_schema)
#print(schema.keys())
#print(eval_foreign_key_maps) 

dataset = registry.construct('dataset_infer', {
   "name": "spider", "schemas": schema, "eval_foreign_key_maps": eval_foreign_key_maps, 
    "db_path": db_path
})

for _, schema_info in dataset.schemas.items():
    model.preproc.enc_preproc._preprocess_schema(schema_info)

spider_schema = dataset.schemas[db_id]

# question = "Who was the pilot who flew first?"

# code = infer(question, spider_schema)
# print(code)

try:
    while True:
        question = input("Enter your question (or type 'exit' to quit): ")
        if question.lower() == "exit":
            print("Exiting...")
            break
        
        # Assuming infer() function is defined somewhere
        code = infer(question, spider_schema)
        
        # printmd(f"**{code}**")  # Bold formatting
        print(code)
        print('-----------------')
    
except KeyboardInterrupt:
    print("\nKeyboard interrupt received. Exiting...")


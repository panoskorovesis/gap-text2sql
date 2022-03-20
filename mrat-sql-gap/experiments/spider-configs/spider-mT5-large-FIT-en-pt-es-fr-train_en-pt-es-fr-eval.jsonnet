{
    local exp_id = 1,
    logdir: "logdir/mt5-large-FIT-en-pt-es-fr-train",
    model_config: "experiments/spider-configs/mT5-large-FIT-en-pt-es-fr/mT5.jsonnet",
    model_config_args: {
        bs: 4,
        num_batch_accumulated: 2,
        t5_version: "google/mt5-large",
        pretrained_checkpoint: "models/mt5-large/pretrained_checkpoint/pytorch_model.bin",
        summarize_header: "avg",
        use_column_type: false,
        num_layers: 8,
        lr: 1e-4,
        bert_lr: 1e-5,
        att: 1,
        end_lr: 0,
        sc_link: true,
        cv_link: true,
        use_align_mat: true,
        use_align_loss: true,
        bart_token_type: true,
        decoder_hidden_size: 512,
        end_with_from: true, # equivalent to "SWGOIF" if true
        clause_order: null, # strings like "SWGOIF", it will be prioriotized over end_with_from 
    },

    eval_name: "mT5-large-190Ksteps-FIT-en-pt-es-fr-train_en-pt-es-fr-eval_%d_%s_%d" % [exp_id, self.eval_use_heuristic, self.eval_beam_size],
    eval_output: "ie_dirs/mt5-large-FIT-en-pt-es-fr-train",
    eval_beam_size: 1,
    eval_use_heuristic: true,
    eval_steps: [ 1000 * x + 100 for x in std.range(100, 190)] + [190300],
    eval_section: "val",
}

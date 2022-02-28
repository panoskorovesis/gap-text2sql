{
    local exp_id = 1,
    logdir: "logdir/T5-v1_1-large-en-train",
    model_config: "experiments/spider-configs/T5-v1_1-large-170Ksteps-en/T5-v1_1.jsonnet",
    model_config_args: {
        bs: 4,
        num_batch_accumulated: 2,
        t5_version: "google/t5-v1_1-large",
        pretrained_checkpoint: "None",
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

    eval_name: "T5-v1_1-large-170Ksteps-en-train_en-eval_%d_%s_%d" % [exp_id, self.eval_use_heuristic, self.eval_beam_size],
    eval_output: "ie_dirs/T5-v1_1-large-en-train",
    eval_beam_size: 1,
    eval_use_heuristic: true,
    eval_steps: [ 1000 * x + 100 for x in std.range(90, 170)] + [170300],
    eval_section: "val",
}

{
    logdir: "logdir/bertimbau-base_run",
    model_config: "configs/bertimbau-base/nl2code-bertimbau-base.jsonnet",
    model_config_args: {
        data_path: 'data/spider-bertimbau-base-pt/',
        bs: 6,
        num_batch_accumulated: 4,
        bert_version: "neuralmind/bert-base-portuguese-cased",
        summarize_header: "avg",
        use_column_type: false,
        max_steps: 81000,
        num_layers: 8,
        lr: 7.44e-4,
        bert_lr: 3e-6,
        att: 1,
        end_lr: 0,
        sc_link: true,
        cv_link: true,
        use_align_mat: true,
        use_align_loss: true,
        bert_token_type: true,
        decoder_hidden_size: 512,
        end_with_from: true, # equivalent to "SWGOIF" if true
        clause_order: null, # strings like "SWGOIF", it will be prioriotized over end_with_from 
    },

    eval_name: "bertimbau-base_run_%s_%d" % [self.eval_use_heuristic, self.eval_beam_size],
    eval_output: "ie_dirs/bertimbau-base",
    eval_beam_size: 1,
    eval_use_heuristic: true,
    eval_steps: [ 1000 * x + 100 for x in std.range(14, 17)] + [ 1000 * x + 100 for x in std.range(24, 26)],
    eval_section: "val",
}

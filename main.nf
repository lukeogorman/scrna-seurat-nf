/*

    MAIN WORKFLOW

*/

nextflow.enable.dsl = 2

/*
=========================================================================
IMPORT WORKFLOWS | SUBWORKFLOWS | MODULES
=========================================================================
*/
include { EXAMPLE }                         from './workflows/example.nf'
include { PIPELINE_INITIALISATION }         from './subworkflows/local/pipeline_initialisation.nf'
include { PIPELINE_COMPLETION }             from './subworkflows/local/pipeline_initialisation.nf'

workflow {
    main:
    PIPELINE_INITIALISATION (
        params.version,
        params.help,
        params.validate_params,
        params.monochromeLogs,
        params.outdir
    )

    EXAMPLE()

    PIPELINE_COMPLETION(
        params.email,
        params.email_on_fail,
        params.plaintext_email,
        params.outdir,
        params.monochrome_logs,
        params.hook_url
    )
}
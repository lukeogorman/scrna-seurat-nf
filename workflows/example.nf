/*
=========================================================================
IMPORT MODULES
=========================================================================
*/

include { FASTQC }          from '../modules/nf-core/fastqc.nf'
include { CHECK_INPUT }     from '../subworkflows/local/check_input.nf'


/*
=========================================================================
MAIN (SUB)WORKFLOW
=========================================================================
*/

workflow EXAMPLE {
    
    CHECK_INPUT(
        params.reads,
        params.singleEnd
    )

    CHECK_INPUT.out.meta.view()

    FASTQC(CHECK_INPUT.out.meta)
    
    // You can add a params.save_QC here with if statement
    FASTQC.out.html.map { inputFiles ->
        def outDir = file("${params.outdir}/fastqc")
        outDir.mkdir()
        inputFiles[1].each { inputFile ->
            file(inputFile).copyTo(file("${outDir}/${file(inputFile).getName()}"))
        }
    }
}
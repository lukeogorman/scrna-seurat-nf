/*

    Fetches sample reads and puts them into the right structure
    
*/

workflow CHECK_INPUT {
    take:
    reads
    singleEnd

    main:
    if (singleEnd) {
        sample_ch = Channel
            .fromPath(reads)
            .ifEmpty { exit 1, 'Cannot find any reads matching: ${reads}\n'}

    } else if (!singleEnd) {
        sample_ch = Channel
            .fromFilePairs(reads)
            .ifEmpty { exit 1, 'Cannot find any reads matching: ${reads}\n'}
    }

    meta_ch = sample_ch.map { arrayList ->
        def sample_id = arrayList[0]
        def files = arrayList[1]
        def meta = [:]
        meta.id = sample_id
        meta.single_end = params.singleEnd
        return tuple(meta, files)
    }

    emit:
    meta                    = meta_ch
}
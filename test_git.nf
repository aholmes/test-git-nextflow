nextflow.enable.dsl=2

params.output_dir = 'test_dir'
process Create_Test_Output {
    publishDir path: params.output_dir, mode: 'copy'

    input:
    path paths

    output:
        path(".command.sh")

    script:
    collected_paths = paths.collect { "'$it'" }.join(' ')
    """
    set -euo pipefail

    echo "random text to put in the file" > $collected_paths
    """
}

workflow {
    Create_Test_Output(
        Channel.fromPath( ["file_one", "file one"].collect() )
    )
}

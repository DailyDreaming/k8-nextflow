params.xyz = 'notset'

workflow {
    data = pim(params.xyz)
    pem(params.xyz, data)
    pem.out.view()
}

process pim {
    publishDir "s3://braingeneersdev/test/", mode: 'copy', overwrite: true
    container 'quay.io/ucsc_cgl/mqtt-nextflow-s3:0.0'
    cpus '1'
    memory '100 MB'
    disk '100 MB'

    input:
        val xyz

    output:
        path 'o.txt'

    script:
        """
        echo "Running PIM! UUID: ${xyz}" &> o.txt
        """
}

process pem {
    publishDir "s3://braingeneers/test/", mode: 'copy', overwrite: true
    container 'quay.io/ucsc_cgl/mqtt-nextflow-s3:0.0'
    cpus '1'
    memory '100 MB'
    disk '100 MB'

    input:
        val xyz
        path data

    output:
        path 'n.txt'

    script:
        """
        echo "Running PEM! UUID: ${xyz} AND " &> n.txt
        cat ${data} >> n.txt
        """
}

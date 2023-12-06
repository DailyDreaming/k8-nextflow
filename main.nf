// If you want the workflow to be triggered by an MQTT message you must define the MQTT_TOPIC_TRIGGER variable
MQTT_TOPIC_TRIGGER = 'experiments/upload'

// Define other variables that should be passed to the script, if the workflow is triggered by MQTT these
// variables must be available in the MQTT payload as a JSON dictionary with the variable name. For example
// for params.UUID the MQTT payload should include at a minimum {"UUID": "2020-01-01-e-demo"}
// params.UUID = 'not-set'
params.xyz = 'notset'

workflow {
    data = pim(params.xyz)
    pom(params.xyz, data)
    pom.out.view()
}

process pim {
    container 'ubuntu:latest'
    cpus 1
    memory '1 GB'
    disk '1 GB'

    input:
    val xyz

    output:
    path 'o.txt'

    """
    echo "Running PIM! UUID: ${xyz}" &> o.txt
    """
}

process pom {
    container 'ubuntu:latest'
    cpus 1
    memory '1 GB'
    disk '1 GB'

    input:
    val xyz
    path data

    output:
    path 'n.txt'

    """
    echo "Running POM! UUID: ${xyz} AND " &> n.txt
    cat ${data} >> n.txt
    """
}


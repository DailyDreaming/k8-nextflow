## A Toy Nextflow Workflow for Testing a Shared PVC on the [National Research Platform (NRP)](https://portal.nrp-nautilus.io)

This workflow launches two jobs that must successfully pass a file between them to produce a final output.    

### Running as a Nextflow Workflow triggered by an MQTT message

This workflow was written specifically to be tested in and be run by the service here: https://github.com/braingeneers/mission_control/tree/main/nextflow

To do this, one must publish an MQTT message with the following JSON file contents:

```json
{"url": "https://github.com/DailyDreaming/k8-nextflow", "xyz": "make_tea_and_not_war"}
```

If the file is called `k8-params.json`, one can run/trigger this workflow via:

```bash
mosquitto_pub -h mqtt.braingeneers.gi.ucsc.edu \
              -t "workflow/start" \
              -u braingeneers \
              -P $(awk '/profile-key/ {print $NF}' ~/.aws/credentials) \
              -f k8-params.json
```

### Running as a Nextflow Workflow locally

1. If you don't have it installed already, download the latest nextflow binary and make it executable:

```commandline
wget https://github.com/nextflow-io/nextflow/releases/download/v23.10.1/nextflow
sudo chmod 1777 nextflow
```

2. Copy this nextflow config to the current directory:

```commandline
wget https://raw.githubusercontent.com/DailyDreaming/k8-nextflow/master/nextflow.config
```

3. Then run the workflow with the following command (assuming a PVC called "whimvol" exists):

```commandline
./nextflow kuberun https://github.com/DailyDreaming/k8-nextflow -v whimvol:/workspace -head-cpus 1 -head-memory 1024Mi
```

To verify, one can check the output deposited in `s3://braingeneersdev/test/`:

```bash
(venv) quokka@qcore 01:22 PM ~/git/mission_control$ aws s3 cp s3://braingeneersdev/test/tea.txt .
    download: s3://braingeneersdev/test/tea.txt to ./tea.txt

(venv) quokka@qcore 01:23 PM ~/git/mission_control$ cat tea.txt
    Running PEM! UUID: make_tea_and_not_war AND 
    Running PIM! UUID: make_tea_and_not_war
```

### More Detailed Instructions on Running Nextflow on the [National Research Platform (NRP)](https://portal.nrp-nautilus.io)

See: https://github.com/braingeneers/mission_control/tree/main/nextflow/infra

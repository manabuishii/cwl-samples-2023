# streamflow

Advice from Iacopo Colonnelli (2024-05-17)

> 0.1.6 is little bit old
> 0.2.0.dev11 is better

```console
python3 -m venv venv
source venv/bin/activate
pip install streamflow==0.2.0.dev11
```

## files

- streamflow_workflow.yml
  - for streamflow
- hello_world_fileout.cwl
  - CommandLineTool
- hello_world_workflow.cwl
  - Workflow

### streamflow_workflow.yml

```yaml
version: v1.0
workflows:
  hello:
    type: cwl
    config:
      file: hello_world_workflow.cwl
    bindings:
      - step: /step1
        target:
          model: slurmenv
          service: example
          workdir: WORKDIR_IS_HERE

models:
  slurmenv:
    type: slurm
    config:
      maxConnections: 1
      services:
        example: {}
```

### hello_world_fileout.cwl

```yaml
cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["echo", "hello"]
inputs: []
outputs:
  output_file:
    type: File
    outputBinding:
      glob: output.txt
stdout: output.txt
```

### hello_world_workflow.cwl

```yaml
cwlVersion: v1.2
class: Workflow

inputs: {}

outputs:
  hello_out:
    type: File
    outputSource: step1/output_file

steps:
  step1:
    run: hello_world_fileout.cwl
    in: {}
    out: [output_file]

requirements:
  InlineJavascriptRequirement: {}
```

## how to execute

```
streamflow run streaflow_workflow.yml
```

### for debug

debug

```
streamflow run --debug streaflow_workflow.yml
```

To show options for slurm

```console
streamflow ext show connector slurm
```

To information of slurm job 616

```
scontrol show job 616
```

Actual command you can find following line in `--debug` output.

```
2024-05-17 20:21:00.441 DEBUG    EXECUTING command echo IyEvY(cut) | base64 -d
```

Execute `echo .... | base64 -d` you can get one more same thing,


```bash
#!/bin/sh

echo Y2QgL2x1(cut) | base64 -d | sh
```

Execute `echo .... | base64 -d` finally you get actual command

```
```

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
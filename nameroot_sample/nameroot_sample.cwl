cwlVersion: v1.2

class: Workflow

requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}

inputs:
  inputfile:
    type: File

steps:
  hello:
    run: ../hello_world_fileoutput.cwl
    in:
      message:
        valueFrom: $(inputs.inputfile.nameroot)
    out:
      - out

outputs:
  hello_out:
    type: File
    outputSource: hello/out

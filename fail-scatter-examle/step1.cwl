# step1.cwl
cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
inputs:
  - id: message
    type: string
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    outputBinding:
      glob: "stdout.txt"
stdout: stdout.txt
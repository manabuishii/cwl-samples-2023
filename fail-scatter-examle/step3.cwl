# step3.cwl
cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
inputs:
  - id: input_file
    type: File
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    outputBinding:
      glob: "final_output.txt"
stdout: final_output.txt
arguments:
  - "Final processing of $(inputs.input_file.path) completed"
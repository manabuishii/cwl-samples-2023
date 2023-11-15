#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: echo
stdout: $(inputs.param1)_$(inputs.param2).txt
inputs:
  param1:
    type: string
    inputBinding:
      position: 1
  param2:
    type: string
    inputBinding:
      position: 2
outputs:
  output_file:
    type: File
    outputBinding:
      glob: $(inputs.param1)_$(inputs.param2).txt
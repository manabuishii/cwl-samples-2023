cwlVersion: v1.2
class: CommandLineTool

baseCommand: bash

inputs:
  checkscript:
    type: File
    default: 
      class: File
      path: ./debuginfo.sh
    inputBinding:
      position: 1

outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: output.txt

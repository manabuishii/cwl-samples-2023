
cwlVersion: v1.2
class: CommandLineTool
baseCommand: grep

inputs:
  grepPattern:
    type: string
    inputBinding:
      position: 1
  inputFile:
    type: File
    inputBinding:
      position: 2

outputs:
  grepResult:
    type: File
    outputBinding:
      glob: grep-result.txt

stdout: grep-result.txt


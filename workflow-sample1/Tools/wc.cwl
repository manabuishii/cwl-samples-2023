cwlVersion: v1.2
class: CommandLineTool
baseCommand: wc
arguments:
  - valueFrom: "-l"
  - valueFrom: $(inputs.file.path)
inputs:
  file:
    type: File
outputs:
  - id: line_count
    type: File
    outputBinding:
      glob: wc_result.txt
stdout: wc_result.txt

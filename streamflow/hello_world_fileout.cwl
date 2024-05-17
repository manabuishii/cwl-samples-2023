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
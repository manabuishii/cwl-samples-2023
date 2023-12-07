cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
baseCommand: [ls] # ここにコマンドを指定

inputs:
  - id: input_file
    type: File
    inputBinding:
      position: 1
  - id: dest_filename
    type: string
    inputBinding:
      position: 2
      prefix: ">"
      shellQuote: false

outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: $(inputs.dest_filename)

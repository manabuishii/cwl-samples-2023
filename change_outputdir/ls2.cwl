cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: "$({class: 'Directory', listing: []})"
        entryname: $(inputs.dest_dir) 
        writable: true

baseCommand: [ls] # ここにコマンドを指定

arguments:
  - $(inputs.input_file.path)

inputs:
  - id: input_file
    type: File
    inputBinding:
      position: 1
  - id: dest_filename
    type: string
    inputBinding:
      position: 2
      prefix: "> aaa/"
      # prefix: "> "+$(inputs.dest_dir)+"/"
      separate: false
      shellQuote: false
  - id: dest_dir
    type: string

outputs:
  - id: output_file
    type: Directory
    outputBinding:
      glob: $(inputs.dest_dir)

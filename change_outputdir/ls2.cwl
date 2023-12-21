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
  - valueFrom: $(">")
    shellQuote: false
  - $(inputs.dest_dir)/$(inputs.dest_filename)

inputs:
  - id: input_file
    type: File
  - id: dest_filename
    type: string
  - id: dest_dir
    type: string

outputs:
  - id: output_file
    type: Directory
    outputBinding:
      glob: $(inputs.dest_dir)

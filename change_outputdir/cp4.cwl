cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      # - entry: "$({class: 'Directory', listing: []})"
      #   entryname: $(inputs.dest_dir)/$(inputs.dest_dir2)/$(inputs.dest_dir3)
      - entry: $(inputs.input_file)
        entryname: $(inputs.dest_dir)/$(inputs.dest_dir2)/$(inputs.dest_dir3)/$(inputs.input_file.basename)
        writable: true

baseCommand: ["true"] # ここにコマンドを指定


inputs:
  - id: input_file
    type: File
  - id: dest_dir
    type: string
  - id: dest_dir2
    type: string
  - id: dest_dir3
    type: string

outputs:
  - id: output_file
    type: Directory
    outputBinding:
      glob: $(inputs.dest_dir)

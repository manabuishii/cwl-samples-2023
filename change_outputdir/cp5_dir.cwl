cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      # - entry: "$({class: 'Directory', listing: []})"
      #   entryname: $(inputs.dest_dir)/$(inputs.dest_dir2)/$(inputs.dest_dir3)
      - entry: $(inputs.input_dir)
        entryname: $(inputs.dest_dir)/$(inputs.dest_dir2)/$(inputs.dest_dir3)/$(inputs.dest_dirname)
        writable: true

baseCommand: ["true"] # ここにコマンドを指定


inputs:
  - id: dest_dirname
    type: string
  - id: input_dir
    type: Directory
  - id: dest_dir
    type: string
  - id: dest_dir2
    type: string
  - id: dest_dir3
    type: string

outputs:
  - id: output_dir
    type: Directory
    outputBinding:
      glob: $(inputs.dest_dir)

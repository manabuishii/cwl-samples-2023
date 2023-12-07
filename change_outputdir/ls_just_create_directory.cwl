# ディレクトリを作るが、回収はしない。
# 存在は、 ls_result_with_directory.txt で確認できる。
class: CommandLineTool
cwlVersion: v1.2
baseCommand: ["ls", "-l"]
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: $(inputs.newname)
        entry: $(inputs.srcfile)
      - entry: "$({class: 'Directory', listing: []})"
        entryname: $(inputs.out_dir) 
        writable: true
inputs:
  srcfile: File
  newname: string
  out_dir: string
outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: ls_result_with_directory.txt

stdout: ls_result_with_directory.txt

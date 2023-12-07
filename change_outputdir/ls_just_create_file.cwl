# CWL の requirements 一巡り: InitialWorkDirRequirement
# https://zenn.dev/tom_tan/articles/568852ad644a02
# https://github.com/common-workflow-language/cwl-v1.2/blob/main/tests/rename.cwl
class: CommandLineTool
cwlVersion: v1.2
baseCommand: ["ls", "-l"]
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: $(inputs.newname)
        entry: $(inputs.srcfile)
      # 単にファイルを作るだけ
      - entryname: created_file.txt
        entry: created_file.txt
inputs:
  srcfile: File
  newname: string
outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: ls_result.txt

stdout: ls_result.txt

# CWL の requirements 一巡り: InitialWorkDirRequirement
# https://zenn.dev/tom_tan/articles/568852ad644a02
# https://github.com/common-workflow-language/cwl-v1.2/blob/main/tests/rename.cwl
class: CommandLineTool
cwlVersion: v1.2
baseCommand: "true"
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: $(inputs.newname)
        entry: $(inputs.srcfile)
inputs:
  srcfile: File
  newname: string
outputs:
  outfile:
    type: File
    outputBinding:
      glob: $(inputs.newname)
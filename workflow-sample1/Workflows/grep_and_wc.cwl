cwlVersion: v1.2
class: Workflow
inputs:
  inputFile:
    type: File
  grepPattern:
    type: string
outputs:
# save count_lines_step/line_count to line_count
  line_count:
    type: File
    outputSource: count_lines_step/line_count

steps:
  - id: grep_step
    run: ../Tools/grep_tool.cwl  # grepを実行するCWLツールの定義ファイル
    in:
      inputFile: inputFile
      grepPattern: grepPattern
    out: ["grepResult"]

  - id: count_lines_step
    run: ../Tools/wc.cwl  # 行数をカウントするCWLツールの定義ファイル
    in:
      file: grep_step/grepResult
    out: ["line_count"]
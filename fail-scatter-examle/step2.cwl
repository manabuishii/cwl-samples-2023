# step2.cwl
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [bash, -c]
inputs:
  - id: input_file
    type: File
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    outputBinding:
      glob: "processed.txt"
stdout: processed.txt
arguments: 
  - |
    if grep -q "error" $(inputs.input_file.path); then
      echo "Error detected" && exit 1;
    else
      echo "Processing $(inputs.input_file.path) completed";
    fi
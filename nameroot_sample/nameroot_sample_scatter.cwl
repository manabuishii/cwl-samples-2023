cwlVersion: v1.2
class: Workflow
requirements:
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
  - class: SubworkflowFeatureRequirement
inputs:
  - id: input_files
    type: File[]

outputs:
  - id: output_files
    type: File[]
    outputSource: scatter_step/out

steps:
  - id: scatter_step
    scatter: input_file
    run: ../hello_world_fileoutput2.cwl
    in:
      input_file: input_files
      message:
        # valueFrom: $("2")
        valueFrom: $(inputs.input_file.nameroot)
    out:
      - out

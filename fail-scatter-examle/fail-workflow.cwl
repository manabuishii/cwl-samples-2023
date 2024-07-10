# workflow.cwl
cwlVersion: v1.0
class: Workflow
requirements:
  - class: ScatterFeatureRequirement
inputs:
  input_messages:
    type: string[]
steps:
  - id: step1
    run: step1.cwl
    scatter: message
    # scatterMethod: dotproduct
    in:
      message: input_messages
    out: [output]

  - id: step2
    run: step2.cwl
    scatter: input_file
    in:
      input_file: step1/output
    out: [output]

  - id: step3
    run: step3.cwl
    scatter: input_file
    in:
      input_file: step2/output
    out: [output]

outputs:
  final_outputs:
    type: File[]
    outputSource: step3/output
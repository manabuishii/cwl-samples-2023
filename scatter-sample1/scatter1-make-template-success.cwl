#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
inputs:
  params:
    type:
      type: array
      items:
        - type: record
          name: ParamPair
          fields:
            - name: param1
              type: string
            - name: param2
              type: string

outputs:
  output_files:
    type: File[]
    outputSource: scatter_step/output_file

steps:
  scatter_step:
    # scatter: param1
    scatter: [param1, param2]
    scatterMethod: dotproduct
    run: echo_two_params.cwl
    in:
      param1:
        source: params
        valueFrom: $(self.param1)
      param2:
        source: params
        valueFrom: $(self.param2)
    out: [output_file]
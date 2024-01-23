cwlVersion: v1.2
class: Workflow
requirements:
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
  - class: SubworkflowFeatureRequirement
inputs:
  - id: outdir_prefix
    type: string
  - id: dest_dirname
    type: string
  - id: input_dir_list
    type: Directory[]

outputs:
  - id: output_files
    type: Directory[]
    outputSource: scatter_step/output_dir

  
    
steps:
    - id: scatter_step
      scatter: input_dir
      run: cp6_dir_structure_from_name.cwl
      in:
            outdir_prefix: outdir_prefix
            dest_dirname: dest_dirname
            input_dir: input_dir_list
      out:
            - output_dir



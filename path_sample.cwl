cwlVersion: v1.2

requirements:
  InlineJavascriptRequirement: {}

# What type of CWL process we have in this document.
class: CommandLineTool
# This CommandLineTool executes the linux "echo" command-line tool.
baseCommand: echo

arguments:
  - $(inputs.infile.location.split('/')[inputs.infile.location.split('/').length-2])/$(inputs.infile.basename)

# The inputs for this process.
inputs:
  infile:
    type: File
outputs: []


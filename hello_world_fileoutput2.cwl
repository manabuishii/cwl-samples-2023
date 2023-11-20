cwlVersion: v1.2

# What type of CWL process we have in this document.
class: CommandLineTool
# Requirements
requirements:
  - class: InlineJavascriptRequirement


# This CommandLineTool executes the linux "echo" command-line tool.
baseCommand: echo

# The inputs for this process.
inputs:
  input_file:
    type: File
  message:
    type: string
    # A default value that can be overridden, e.g. --message "Hola mundo"
    default: "Hello World"
    # Bind this message value as an argument to "echo".
    inputBinding:
      position: 1
outputs:
  - id: out
    type: stdout
stdout: $(inputs.input_file.nameroot).nameroot_example.txt

#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: sleep

inputs:
  sleep_duration:
    type: int
    default: 10
    inputBinding:
      position: 1

outputs: []

stdout: sleep.log

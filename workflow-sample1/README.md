## How to execute


### Tools

grep

```
cwltool  workflow-sample1/Tools/grep_tool.cwl  workflow-sample1/grep_tool.yaml
```

wc

```
cwltool workflow-sample1/Tools/wc.cwl workflow-sample1/wc.yaml   
```

### Workflows

```
cwltool  workflow-sample1/Workflows/grep_and_wc.cwl workflow-sample1/grep_tool.yaml
```
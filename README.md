# cwl-samples-2023

## How to setup cwl environment

### cwltool

Install cwltool with venv

```console
python3 -m venv venv-cwltool
source venv-cwltool/bin/activate
pip install cwltool==3.1.20230601100705
```

Check version

```console
$ cwltool --version
cwltool 3.1.20230601100705
```


### toil 5.12.0

Install toil with venv

```console
python3 -m venv venv-toil-5.12.0
source venv-toil-5.12.0/bin/activate
pip install toil[cwl]==5.12.0
```

Check verion

```console
$ toil-cwl-runner --version
5.12.0
```

### sapporo 1.6.2

Install sapporo with venv

```console
mkdir sapporo-1.6.2
cd sapporo-1.6.2
python3 -m venv venv-sapporo-1.6.2
source venv-sapporo-1.6.2/bin/activate
pip3 install sapporo==1.6.2
```

Check verion

```console
$ pip list | grep sapporo
sapporo                   1.6.2
```

#### exec via sapporo with cwltool docker

workflow_engine_parameters.json
```workflow_engine_parameters.json
{}
```

```
curl -O https://raw.githubusercontent.com/manabuishii/cwl-samples-2023/main/scatter-sample1/scatter-sample1.yaml
```

```
curl -s -X POST \
 -F "workflow_params=<scatter-sample1.yaml" \
 -F "workflow_type=CWL" \
 -F "workflow_type_version=v1.0" \
 -F "workflow_url=https://raw.githubusercontent.com/manabuishii/cwl-samples-2023/main/scatter-sample1/scatter1.cwl" \
 -F "workflow_engine_name=cwltool" \
 -F "workflow_engine_parameters=<workflow_engine_parameters.json" \
 http://0.0.0.0:1122/runs
```

```
curl http://0.0.0.0:1122/runs/RUNID
```

## samples

scatter sample

```console
cwltool scatter-sample1/scatter1.cwl scatter-sample1/scatter-sample1.yaml
```

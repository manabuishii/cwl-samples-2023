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

## samples

scatter sample

```console
cwltool scatter-sample1/scatter1.cwl scatter-sample1/scatter-sample1.yaml
```

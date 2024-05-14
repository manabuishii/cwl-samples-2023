# CWLCon2024 Examples

## command for slurm

```
CWL_SINGULARITY_CACHE=~/.singularity_cache_dfast \
toil-cwl-runner \
 --singularity \
 --writeLogs ./logs \
 --logFile ./toil.output.txt \
 --batchSystem grid_engine \
 --jobStore ./jobstore \
 --defaultMemory 16Gi \
 --maxMemory 16Gi \
 --relax-path-checks \
 --bypass-file-store \
 --outdir ./output \
  ${CWLFILE} ${JOBFILE}
```

### Toil will no longer warn about a missing XDG_RUNTIME_DIR

I always using this WORKAROUND -> `--coordinationDir /tmp`

But,

Update: toil 6.1.0 solve this problem

from [Release 6\.1\.0 · DataBiosphere/toil](https://github.com/DataBiosphere/toil/releases/tag/releases%2F6.1.0)

Toil will no longer warn about a missing XDG_RUNTIME_DIR (#4769)

[Stop complaining about XDG\_RUNTIME\_DIR by adamnovak · Pull Request \#4769 · DataBiosphere/toil](https://github.com/DataBiosphere/toil/pull/4769)

#### Download singularity images before run.

toil creates singularity images on the fly.
if network is stopped during singularity image creation process, toil will be stopped.

[common\-workflow\-language/cwl\-utils: Python utilities for CWL](https://github.com/common-workflow-language/cwl-utils?tab=readme-ov-file#pull-the-all-referenced-software-container-images)

copy from above URL

for singularity

```console
cwl-docker-extract --singularity --dir DIRECTORY path_to_my_workflow.cwl
```

#### Toil Memory Unit difference 8G, 8Gi and Java Memory Unit

In toil

8G  is 8 * 1000 * 1000 * 1000 = 8000000000 bytes
8Gi is 8 * 1024 * 1024 * 1024 = 8589934592 bytes

In Java (ex. GATK)

8G is 8 * 1024 * 1024 * 1024 = 8589934592 bytes

There is difference between toil and Java when you specify `8G`.

If Java uses less than 8G, there is no problem.
But if Java program (ex GATK) tries to use 8100000000.
From Java aspect it is okay 8100000000 < 8589934592.
But toil aspect it is problem 8100000000 >  8000000000.

If your cluster system has enough resource, I recommend `Gi` unit.
Of course `Mi` `Ki` is recommended.

#### Useful options 


`--relax-path-checks`
helps if file name has space, $ sign

`--bypass-file-store`
use symlink for inputs

#### WORKAROUND for qacct is slow

(actual shell script example is below)

If grid_engine accouting file is HUGE like millions lines.

`qacct -j xxxx` takes 10sec per job.
toil check job is finished by sequencially.

So if there is 100 job, only to check job 100(jobs) * 10(sec) = 1000(sec)
Image if there is 10000 jobs ...

WORKAROUND:
My WORKAROUND is to use small accounting file.
1. tail original accounting file.
2. grep only my own job.

PROS:

- fast

CONS:

- sometimes, it is too fast to write own accounting file.
  - this creates fail. I prepare WORKAROUND for this , it is retry several times, and set toil also retry options.
  - 

##### setup

`ORIGINAL_QACCT` is full path of actual `qacct` .
 Example is  `/usr/bin/qacct` , but your actual `qacct` found this `which qacct`.

`ORIGINAL_ACCOUNTING_FILE` is original `accounting` file. it maybe `$SGE_ROOT/$SGE_CELL/common/accounting`

if following
- SGE_ROOT is /usr/share/gridengine
- SGE_CELL is default

accounting file maybe be

`/usr/share/gridengine/default/common/accounting`


`PREFIX` is directory for our qacct.

create file inside script

`ACCOUNTINGFILE`


```bash
# setup these 2values
ORIGINAL_QACCT=/usr/bin/qacct
ORIGINAL_ACCOUNTING_FILE=$SGE_ROOT/$SGE_CELL/common/accounting
PREFIX=$PWD/forqacct
#
ACCOUNTINGFILE=$PWD/${PREFIX}/accounting.txt
mkdir -p ${PREFIX}
mkdir -p ${PREFIX}/bin
cat << EOS >  ${PREFIX}/bin/qacct
#!/bin/bash
for i in \`seq 1 10\`
do
  touch ${ACCOUNTINGFILE}
  if ${ORIGINAL_QACCT} -f ${ACCOUNTINGFILE} "\$@" &> /dev/null ; then
    break
  fi
  sleep 1
done
if ${ORIGINAL_QACCT} -f ${ACCOUNTINGFILE} "\$@" &> /dev/null ; then
  ${ORIGINAL_QACCT} -f ${ACCOUNTINGFILE} "\$@"
else
  ${ORIGINAL_QACCT} "\$@"
fi
EOS
chmod 755  ${PREFIX}/bin/qacct
PATH=${PREFIX}/bin:${PATH}

# qacct用
tail -f ${ORIGINAL_ACCOUNTING_FILE} | grep ":${USER}:" > ${ACCOUNTINGFILE} &
TAILPROCESS=$!
echo ${TAILPROCESS} > ${PREFIX}/tail.process.pid.txt
```

```bash
toil-cwl-runner
(cut)
TOILRESULT=$?

```

stop tail process and return actual


```bash
# stop tail process
kill ${TAILPROCESS}
exit ${TOILRESULT}
```

Example `run_toil.sh`

```bash
#!/bin/bash
# setup these 3values
ORIGINAL_QACCT=/usr/bin/qacct
ORIGINAL_ACCOUNTING_FILE=$SGE_ROOT/$SGE_CELL/common/accounting
PREFIX=$PWD/forqacct
#
ACCOUNTINGFILE=$PWD/${PREFIX}/accounting.txt
mkdir -p ${PREFIX}
mkdir -p ${PREFIX}/bin
cat << EOS >  ${PREFIX}/bin/qacct
#!/bin/bash
for i in \`seq 1 10\`
do
  touch ${ACCOUNTINGFILE}
  if ${ORIGINAL_QACCT} -f ${ACCOUNTINGFILE} "\$@" &> /dev/null ; then
    break
  fi
  sleep 1
done
if ${ORIGINAL_QACCT} -f ${ACCOUNTINGFILE} "\$@" &> /dev/null ; then
  ${ORIGINAL_QACCT} -f ${ACCOUNTINGFILE} "\$@"
else
  ${ORIGINAL_QACCT} "\$@"
fi
EOS
chmod 755  ${PREFIX}/bin/qacct
PATH=${PREFIX}/bin:${PATH}

# qacct用
tail -f ${ORIGINAL_ACCOUNTING_FILE} | grep ":${USER}:" > ${ACCOUNTINGFILE} &
TAILPROCESS=$!
echo ${TAILPROCESS} > ${PREFIX}/tail.process.pid.txt

# RUN toil
CWL_SINGULARITY_CACHE=~/.singularity_cache_dfast \
toil-cwl-runner \
 --singularity \
 --writeLogs ./logs \
 --logFile ./toil.output.txt \
 --batchSystem grid_engine \
 --jobStore ./jobstore \
 --defaultMemory 16Gi \
 --maxMemory 16Gi \
 --relax-path-checks \
 --bypass-file-store \
 --outdir ./output \
  ${CWLFILE} ${JOBFILE}

TOILRESULT=$?

# stop tail process
kill ${TAILPROCESS}
exit ${TOILRESULT}
```

#### Debug 

[Allow debugging jobs by name \(and status improvements\) by adamnovak · Pull Request \#4840 · DataBiosphere/toil](https://github.com/DataBiosphere/toil/pull/4840)



toil uses XDG_RUNTIME_DIR ( /run/users/UID/ )
Sometimes slurm does not set XDG_RUNTIME_DIR.
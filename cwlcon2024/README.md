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



#### Debug 

[Allow debugging jobs by name \(and status improvements\) by adamnovak · Pull Request \#4840 · DataBiosphere/toil](https://github.com/DataBiosphere/toil/pull/4840)



toil uses XDG_RUNTIME_DIR ( /run/users/UID/ )
Sometimes slurm does not set XDG_RUNTIME_DIR.
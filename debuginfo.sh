#!/bin/bash
DEBUGFILE=debuginfo.txt

touch ${DEBUGFILE}
date 2>> ${DEBUGFILE}
hostoname 2>> ${DEBUGFILE}
whoami 2>> ${DEBUGFILE}
id 2>> ${DEBUGFILE}
df -h 2>> ${DEBUGFILE}
env 2>> ${DEBUGFILE}
pwd 2>> ${DEBUGFILE}
ls -l 2>> ${DEBUGFILE}

which squeue 2>> ${DEBUGFILE}
which qstat 2>> ${DEBUGFILE}

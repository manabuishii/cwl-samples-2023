#!/bin/bash
# this script process only 1 cwl.
set -eu
# this script MUST be set CWL_SINGULARITY_CACHE
mkdir -p ${CWL_SINGULARITY_CACHE}
#
CWLFILE=$1

for DOCKERIMAGE in `grep dockerPull ${CWLFILE}  | awk '{print $NF}' | tr -d '"' | tr -d "'" | sort | uniq `
do
 SINGULARITY_IMAGE=`echo $DOCKERIMAGE| sed -e "s/\//_/g"`.sif
 singularity pull --force --name ${CWL_SINGULARITY_CACHE}/${SINGULARITY_IMAGE} docker://${DOCKERIMAGE}
done

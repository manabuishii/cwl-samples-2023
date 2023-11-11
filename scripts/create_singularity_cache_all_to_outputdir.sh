#!/bin/bash
set -eu
# check
if [ "$#" -ne 2 ]; then
  echo "USAGE: $0 output_directory cwl_files_top_directory"
  exit 1
fi
# this script MUST be set CWL_SINGULARITY_CACHE
OUTPUTDIR=$1
mkdir -p ${OUTPUTDIR}
#
CWLDIR=$2

for DOCKERIMAGE in `grep -r dockerPull ${CWLDIR}  | awk '{print $NF}' | tr -d '"' | tr -d "'" | sort | uniq `
do
 SINGULARITY_IMAGE=`echo $DOCKERIMAGE| sed -e "s/\//_/g"`.sif
 singularity pull --force --name ${OUTPUTDIR}/${SINGULARITY_IMAGE} docker://${DOCKERIMAGE}
done

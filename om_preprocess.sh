#!/bin/sh
#  om_run_matlab_code.sh
#SBATCH --job-name=om_preprocess
#SBATCH -t 6:00:00
#SBATCH --ntask=1
#SBATCH --array=1-2%1
#SBATCH --mem-per-cpu 10000
#SBATCH --exclude node017,node018
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ehoseini@mit.edu
#SBATCH --output=om_fmri_preprocess_%j.out
#SBATCH --error=om_fmri_preprocess_%j.err

strindex() {
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

data_dir=/mindhive/evlab/u/Shared/SUBJECTS/
suffix=_PL2017
dicom_suffix=_dicoms

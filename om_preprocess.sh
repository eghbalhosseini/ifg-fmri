#!/bin/sh
#  om_run_matlab_code.sh
#SBATCH --job-name=om_preprocess
#SBATCH -t 6:00:00
#SBATCH --ntask=1
#SBATCH --array=1-3%2
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

echo $SLURM_ARRAY_TASK_ID
subject_id=$(awk -v var="$SLURM_ARRAY_TASK_ID" 'BEGIN{ RS = "" ; FS = "\n" }{print $var}' subjects.txt)
echo $subject_id

mkdir "$data_dir$subject_id$suffix"
analysis_dir="$data_dir$subject_id$suffix"
dicom_dir="${a:$(strindex $a "FED"):$(strindex $a "_3T")-$(strindex $a "FED")}$dicom_suffix"
ln -s "$data_dir$subject_id$dicom_dir" $data_dir$subject_id$suffix$

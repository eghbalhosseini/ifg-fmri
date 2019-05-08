mkdir "$data_dir$subject_id$suffix"
analysis_dir="$data_dir$subject_id$suffix"
dicom_dir="${a:$(strindex $a "FED"):$(strindex $a "_3T")-$(strindex $a "FED")}$dicom_suffix"
ln -s "$data_dir$subject_id$dicom_dir" $data_dir$subject_id$suffix$
cd /mindhive/evlab/u/Shared/ANALYSIS
module add mit/matlab/2015b
matlab -nodisplay -signelCompThread -r "preprocess_PL2017($analysis_dir); \
fprintf({'finished',$subject_id, ''\n'});\
quit;"


echo $SLURM_ARRAY_TASK_ID
subject_id=$(awk -v var="$SLURM_ARRAY_TASK_ID" 'BEGIN{ RS = "" ; FS = "\n" }{print $var}' subjects.txt)
echo $subject_id

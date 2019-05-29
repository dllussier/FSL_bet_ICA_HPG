#!/bin/bash

module load fsl/5.0.11

filepath=<filepath to data>
T1MPRAGE=<T1-weighted structural nifti path and file name>

for i in <subjects>
do

#creates directories in which to move data that is needed for DTI preprocessing scripts
	mkdir $i
	mkdir $i/T1

#copies needed data from shared individual folder to working directory
	cp $filepath/$i/$T1MPRAGE $i/T1/T1.nii

#copies slurm script into subject folder
	cp bet_ica_run.sh $i/

#reorients T1 MPRAGE to standard space
	fslreorient2std $i/T1/T1.nii T1_reorient.nii 

#drops down into subject folder, pushes job to slurm, and returns to home folder
	cd $i/
	sbatch bet_run.sh
	cd ../

echo "completed for" $i
echo "moving on..."

done

#!/bin/bash

##################################
# Frances A H Pitsillides
# f.pitsillides@kew.org
##################################

#SBATCH -c 1
#SBATCH -p all
#SBATCH -J FastQC_test
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/PAFTOL/FastQC_test.out
#SBATCH -e /data/projects/gaya_lab/Frances/PAFTOL/FastQC_test.err

#1: Load fastqc and necessary modules from KewHPC
module load openjdk
module load fastqc/0.11.9

#2: Specify directories/pathways/files
SHAREDFOLDER=/data/projects/gaya_lab/Frances/PAFTOL
SCRIPTS=/data/projects/gaya_lab/Frances/PAFTOL
INFILE=00_raw_reads
OUTFILE=00_raw_reads

#3: Produce script to run FastQC in cluster 
$SHAREDFOLDER/$SCRIPTS/00_parallel_fastqc.sh \
-i $SHAREDFOLDER/$INFILE \
-o $SHAREDFOLDER/$OUTFILE \
-t 2 -m 16 -v 16; #change -t to the number of samples 

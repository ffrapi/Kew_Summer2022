#!/bin/bash
#SBATCH -c 8
#SBATCH -p all
#SBATCH -n 1
#SBATCH -J FastQC_test
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/PAFTOL/FastQC_test.out
#SBATCH -e /data/projects/gaya_lab/Frances/PAFTOL/FastQC_test.err

module load openjdk

module load fastqc

fastqc  RHW101_1.fastq.gz RHW101_2.fastq.gz

ls *.fastq.gz > fastqc_inputfiles.txt

#!/bin/bash 
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J Fastqc_test
#SBATCH -t 0-3:00:00
#SBATCH -a 0-6,8,10%3
#SBATCH -o /data/projects/gaya_lab/Frances/PAFTOL/FastQC_test.out
#SBATCH -e /data/projects/gaya_lab/Frances/PAFTOL/FastQC_test.err

module load openjdk

module load fastqc

#from text file
inputfiles=( $( cat ./fastqc_inputfiles.txt ) )

#uncomment to analyse all *.fq.gz files in directory
inputfiles=( $( ls /data/users_area/fpi10kg/input_files | grep *.fq.gz ) )


fastqc --input=/data/usersarea/fpi10kg/input_files/${inputfiles[$SLURM_ARRAY_TASK_ID]} --output=/data/usersarea/usr00kg/output_files/${inputfiles[$SLURM_ARRAY_TASK_ID]}_analysis.txt

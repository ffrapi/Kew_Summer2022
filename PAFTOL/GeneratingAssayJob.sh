#!/bin/bash

#SBATCH --job-name="Generating Assay"
#SBATCH --export=ALL

echo "Starting Generating Arrays"
Rscript GeneratingArrayJob3.R /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Output SampleList3 environment_file_template_singularity_v0.08249.env RscriptFP long 20 32 f.pitsillides@kew.org 10 projects/rbgk/projects/fungalTreeOfLife/apps/assembly_v0.08249_latest.sif master27.sh
echo "Job finished"

Rscript GeneratingArrayJob3.R /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Output Sample_list3 environment_file_template_singularity.env2024JanGenomes2 long 20 32 f.pitsillides@kew.org 10 projects/rbgk/projects/fungalTreeOfLife/apps/assembly_v0.08246_latest.sif master27.sh

input_path <-  /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input# # the place of libraries, also other files created by this script will be place here
output_path <- /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Output  # the folder where the genome anal out will be placed
samples <- SampleList3 #a txt file with the sample name (without the strand and fastq.gz suffix)
env_file <- environment_file_template_singularity.env2024JanGenomes2 # the name of the template environment file
slurm_job <- ? # slurm job name
partition <- long # cluster partition name "long"
cpu <- 20 # number of threads per task 20
mem <- 32# memory per task in gigabase 32
email <- my email address # email adress "t.varga@kew.org"
n_tasks <- 10 # number of task at a time 10
sif_file <- projects/rbgk/projects/fungalTreeOfLife/apps/assembly_v0.08246_latest.sif # container file with path to it "/home/tvarga/scratch/apps/assembly_v0.08246R_latest.sif"
script <- master27.sh # name of the master script in the docker




#!/bin/bash

#SBATCH --job-name="Generating Assay"
#SBATCH --export=ALL

echo "Starting Generating Arrays"
Rscript GeneratingArrayJob3.R /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/OutputSample_list environment_file_template_singularity.env2024JanGenomes2 long 20 32 f.pitsillides@kew.org 10 projects/rbgk/projects/fungalTreeOfLife/apps/assembly_v0.08246_latest.sif master27.sh
echo "Job finished"


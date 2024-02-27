#!/bin/bash

#SBATCH --job-name="Assembly_T1_SummerBatch_FP"
#SBATCH --export=ALL
#SBATCH --partition=long
#SBATCH --cpus-per-task=20
#SBATCH --mem=32G
#SBATCH --output=Assembly_T1_SummerBatch_FP%A_%a.log
#SBATCH --error=Assembly_T1_SummerBatch_FP%A_%a.elog
#SBATCH --mail-user=f.pitsillides@kew.org
#SBATCH --mail-type=END,FAIL
#SBATCH -a 1-45%10


#To set up environment variables I follow the following blog: https://blog.ronin.cloud/slurm-job-arrays/
# Specify the path to the config file
config=/home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input/2024SumGenomes.config
# Extract the environment file name for the current $SLURM_ARRAY_TASK_ID
envfile=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

lib=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
singularity run --cleanenv --no-home --env-file /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input/${envfile} --bind /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input:/home/repl/Input --bind $TMPDIR:/home/repl/Output /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/apps/assembly_v0.08249_latest.sif master27.sh
cd $TMPDIR; zip -r ${lib}.zip ${lib}
mv $TMPDIR/${lib}.zip /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Output/
cd /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Output/; unzip -r ${lib}.zip

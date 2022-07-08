#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J raxml_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/raxml


module load anaconda3
conda activate raxml-ng

#Convert file for RAxML-NG

raxml-ng --parse \
         --msa Neocucurbitaria_concat.phy \
         --model Neocucurbitaria_partition.txt \
         --prefix Neoc

#Run ML tree search and bootstrapping for 1000 iterations

raxml-ng --all \
         --msa Neocucurbitaria_concat.phy \
         --model Neocucurbitaria_partition.txt \
         --prefix Neoc \
         --seed 2 \
         --threads ${NSLOTS} \
         --bs-trees 1000

#Check convergence

raxml-ng --bsconverge \
         --bs-trees Neoc.raxml.bootstraps \
         --prefix Neoc_convergence_test \
         --seed 2

#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J raxml_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/raxml.its.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/raxml.its.err



module load anaconda
module load raxml-ng

#Convert file for RAxML-NG

raxml-ng --parse \
         --msa Neocucurbitaria_concat_its.phy \
         --model Neocucurbitaria_partition_its.txt \
         --prefix Neoc.its

#Run ML tree search and bootstrapping for 1000 iterations

raxml-ng --all \
         --msa Neocucurbitaria_concat_its.phy \
         --model Neocucurbitaria_partition_its.txt \
         --prefix Neoc.its \
         --seed 2 \
         --threads auto \
         --bs-trees 1000

#Check convergence

raxml-ng --bsconverge \
         --bs-trees Neoc.its.raxml.bootstraps \
         --prefix Neoc_its_convergence_test \
         --seed 2

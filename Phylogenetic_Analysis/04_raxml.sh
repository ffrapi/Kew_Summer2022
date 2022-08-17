#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J 05_raxml
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/04_Phylo/trial5_Aug17/05_raxml_concat.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/04_Phylo/trial5_Aug17/05_raxml_concat.err



module load anaconda
module load raxml-ng

#Convert file for RAxML-NG

raxml-ng --parse \
--msa 05a_Neoc_concat.phy \
--model 05a_Neoc_concat_partition.txt \
--prefix 05b_Neoc_concat

#Run ML tree search and bootstrapping for 1000 iterations

raxml-ng --all \
--msa 05a_Neoc_concat.phy \
--model 05a_Neoc_concat_partition.txt \
--prefix 05b_Neoc_concat \
--seed 2 \
--threads auto \
--bs-trees 1000

#Check convergence

raxml-ng --bsconverge \
--bs-trees 05b_Neoc_concat.raxml.bootstraps \
--prefix 05b_Neoc_concat_convergence_test \
--seed 2

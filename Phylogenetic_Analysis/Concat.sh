#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J Concat_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/concat.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/concat.err

#Concatenate gene alignments

module load AMAS

AMAS.py concat -f fasta -d dna -i marker_seqs_ITS_alntrimmed.fa marker_seqs_LSU_alntrimmed.fa marker_seqs_RBP2_alntrimmed.fa marker_seqs_SSU_alntrimmed.fa marker_seqs_Tef1_alntrimmed.fa marker_seqs_Tub2_alntrimmed.fa  -p Neocucurbitaria_partition.txt -t Neocucurbitaria_concat.phy -u phylip

#Add gene models
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition.txt

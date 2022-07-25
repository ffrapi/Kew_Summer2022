#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J concat_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/concat.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/concat.err

#Concatenate gene alignments

module load  python/3.7.9
module load amas

python AMAS.py concat -f fasta -d dna -i 03b_marker_seqs_ITS_alntrimmed_FP.fa 03b_marker_seqs_LSU_alntrimmed.fa 03b_marker_seqs_RPB2_alntrimmed.fa 03b_marker_seqs_SSU_alntrimmed_FP12.fa 03b_marker_seqs_Tef1_alntrimmed.fa 03b_marker_seqs_Tub2_alntrimmed.fa -p 06a_Neocucurbitaria_partition.txt -t 06a_Neocucurbitaria_concat.phy -u phylip

#Add gene models
sed -i 's/^/GTR+G, /' 06a_Neocucurbitaria_partition.txt

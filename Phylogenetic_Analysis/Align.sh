#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J align_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/align.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/align.err


#Create alignments for each gene

module load mafft

mafft ITS_aln_rename_FP1.fa > marker_seqs_ITS_aln.fa
mafft SSU_aln_rename_FP1.fa > marker_seqs_LSU_aln.fa
mafft LSU_aln_rename_FP1.fa > marker_seqs_RPB2_aln.fa
mafft RPB2_aln_rename_FP1.fa > marker_seqs_SSU_aln.fa
mafft TEF1_aln_rename_FP1.fa > marker_seqs_Tef1_aln.fa
mafft TUB2_aln_rename_FP1.fa > marker_seqs_Tub2_aln.fa

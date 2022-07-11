#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J align_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/align.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/align.err


#Create alignments for each gene

module load mafft

mafft marker_seqs_ITS.fa > marker_seqs_ITS_aln.fa
mafft marker_seqs_LSU.fa > marker_seqs_LSU_aln.fa
mafft marker_seqs_RPB2.fa > marker_seqs_RPB2_aln.fa
mafft marker_seqs_SSU.fa > marker_seqs_SSU_aln.fa
mafft marker_seqs_Tef1.fa > marker_seqs_Tef1_aln.fa
mafft marker_seqs_Tub2.fa > marker_seqs_Tub2_aln.fa


#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J align_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/align.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte/genes/align/align.err


#Create alignments for each gene

module load mafft

mafft marker_seqs_ITS_FINAl.fa > marker_seqs_ITS_aln.fa
mafft marker_seqs_LSU_FINAL.fa > marker_seqs_LSU_aln.fa
mafft marker_seqs_RPB2_FINAL.fa > marker_seqs_RPB2_aln.fa
mafft marker_seqs_SSU_FINAL.fa > marker_seqs_SSU_aln.fa
mafft marker_seqs_Tef1_FINAL.fa > marker_seqs_Tef1_aln.fa
mafft marker_seqs_Tub2_FINAL.fa > marker_seqs_Tub2_aln.fa

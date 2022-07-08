#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J Trim_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria

#Trim alignments

module load anaconda3
conda activate trimal

trimal -in marker_seqs_ITS.fa -fasta -gappyout > marker_seqs_ITS_alntrimmed.fa
trimal -in marker_seqs_LSU.fa -fasta -gappyout > marker_seqs_LSU_alntrimmed.fa
trimal -in marker_seqs_RPB2.fa -fasta -gappyout > marker_seqs_RPB2_alntrimmed.fa
trimal -in marker_seqs_SSU.fa -fasta -gappyout > marker_seqs_SSU_alntrimmed.fa
trimal -in marker_seqs_Tef1.fa -fasta -gappyout > marker_seqs_Tef1_alntrimmed.fa
trimal -in marker_seqs_Tub2.fa -fasta -gappyout > marker_seqs_Tub2_alntrimmed.fa

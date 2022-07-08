#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J altri_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria


#Create alignments for each gene

module load mafft

mafft marker_seqs_ITS.fa > marker_seqs_ITS_aln.fa
mafft marker_seqs_LSU.fa > marker_seqs_LSU_aln.fa
mafft marker_seqs_RPB2.fa > marker_seqs_RPB2_aln.fa
mafft marker_seqs_SSU.fa > marker_seqs_SSU_aln.fa
mafft marker_seqs_Tef1.fa > marker_seqs_Tef1_aln.fa
mafft marker_seqs_Tub2.fa > marker_seqs_Tub2_aln.fa

#Trim alignments

module load anaconda3
conda activate trimal

trimal -in marker_seqs_ITS.fa -fasta -gappyout > marker_seqs_ITS_alntrimmed.fa
trimal -in marker_seqs_LSU.fa -fasta -gappyout > marker_seqs_LSU_alntrimmed.fa
trimal -in marker_seqs_RPB2.fa -fasta -gappyout > marker_seqs_RPB2_alntrimmed.fa
trimal -in marker_seqs_SSU.fa -fasta -gappyout > marker_seqs_SSU_alntrimmed.fa
trimal -in marker_seqs_Tef1.fa -fasta -gappyout > marker_seqs_Tef1_alntrimmed.fa
trimal -in marker_seqs_Tub2.fa -fasta -gappyout > marker_seqs_Tub2_alntrimmed.fa
#Concatenate gene alignments

conda activate AMAS

AMAS.py concat -f fasta -d dna -i marker_seqs_ITS_alntrimmed.fa marker_seqs_LSU_alntrimmed.fa marker_seqs_RBP2_alntrimmed.fa marker_seqs_SSU_alntrimmed.fa marker_seqs_Tef1_alntrimmed.fa marker_seqs_Tub2_alntrimmed.fa  -p Neocucurbitaria_partition.txt -t Neocucurbitaria_concat.phy -u phylip

#Add gene models
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition.txt

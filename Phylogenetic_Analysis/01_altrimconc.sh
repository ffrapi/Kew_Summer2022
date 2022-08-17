#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J Neod_altrimconc.job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/04_Phylo/trial5_Aug17/01a_Neod.altrim.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/04_Phylo/trial5_Aug17/01a_Neod.altrim.err

#Create alignments for each gene

module load mafft

mafft 00_Neoc_markerSeqs_TEF1_Jul25.fa  > 01_Neoc_TEF1_aln.fa
mafft 00_Neoc_markerSeqs_RPB2_Aug17.fa  > 01_Neoc_RPB2_aln.fa
mafft 00_Neoc_markerSeqs_TUB2_Aug17.fa > 01_Neoc_TUB2_aln.fa


#Trim alignments

module load trimal

trimal -in 01_Neoc_RPB2_aln.fa -fasta -gappyout > 02_Neoc_RPB2_alntrimmed.fa
trimal -in 01_Neoc_TEF1_aln.fa -fasta -gappyout > 02_Neoc_TEF1_alntrimmed.fa
trimal -in 01_Neoc_TUB2_aln.fa -fasta -gappyout > 02_Neoc_TUB2_alntrimmed.fa


#Concatenate gene alignments

module load  python/3.7.9
module load amas



python AMAS.py concat -f fasta -d dna -i 02_Neoc_TUB2_alntrimmed.fa -p 03_Neoc_TUB2_partition.txt -t 03_Neoc_TUB2.phy -u phylip
sed -i 's/^/GTR+G, /' 03_Neoc_TUB2_partition.txt

python AMAS.py concat -f fasta -d dna -i 02_Neoc_RPB2_alntrimmed.fa -p 03_Neoc_RPB2_partition.txt -t 03_Neoc_RPB2.phy -u phylip
sed -i 's/^/GTR+G, /' 03_Neoc_RPB2_partition.txt

python AMAS.py concat -f fasta -d dna -i 02_Neoc_TEF1_alntrimmed.fa -p 03_Neoc_TEF1_partition.txt -t 03_Neoc_TEF1.phy -u phylip
sed -i 's/^/GTR+G, /' 03_Neoc_TEF1_partition.txt



python AMAS.py concat -f fasta -d dna -i 02_Neoc_TUB2_alntrimmed.fa 02_Neoc_RPB2_alntrimmed.fa 02_Neoc_TEF1_alntrimmed.fa -p 05a_Neoc_concat_partition.txt -t 05a_Neoc_concat.phy -u phylip
sed -i 's/^/GTR+G, /' 05a_Neoc_concat_partition.txt

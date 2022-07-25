#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J Trim_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/redo/trim.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/Jul25/redo/tritm.err

#Trim alignments

module load trimal

trimal -in marker_seqs_ITS_aln.fa -fasta -gappyout > 03b_marker_seqs_ITS_alntrimmed_FP.fa
trimal -in marker_seqs_LSU_aln.fa -fasta -gappyout > 03b_marker_seqs_LSU_alntrimmed_FP.fa
trimal -in marker_seqs_SSU_aln.fa -fasta -gappyout > 03b_marker_seqs_SSU_alntrimmed_FP.fa
trimal -in marker_seqs_RPB2_aln.fa -fasta -gappyout > 03b_marker_seqs_RPB2_alntrimmed_FP.fa
trimal -in marker_seqs_TEF1_aln.fa -fasta -gappyout > 03b_marker_seqs_TEF1_alntrimmed_FP.fa
trimal -in marker_seqs_TUB2_aln.fa -fasta -gappyout > 03b_marker_seqs_TUB2_alntrimmed_FP.fa



#Concatenate gene alignments

module load  python/3.7.9
module load amas

python AMAS.py concat -f fasta -d dna -i 03b_marker_seqs_RPB2_alntrimmed_FP.fa -p Neocucurbitaria_partition_RPB2.txt -t Neocucurbitaria_concat_RPB2.phy -u phylip
python AMAS.py concat -f fasta -d dna -i 03b_marker_seqs_TEF1_alntrimmed_FP.fa -p Neocucurbitaria_partition_TEF1.txt -t Neocucurbitaria_concat_TEF1.phy -u phylip
python AMAS.py concat -f fasta -d dna -i 03b_marker_seqs_TUB2_alntrimmed_FP.fa -p Neocucurbitaria_partition_TUB2.txt -t Neocucurbitaria_concat_TUB2.phy -u phylip
python AMAS.py concat -f fasta -d dna -i 03b_marker_seqs_ITS_alntrimmed_FP.fa -p Neocucurbitaria_partition_ITS.txt -t Neocucurbitaria_concat_ITS.phy -u phylip
python AMAS.py concat -f fasta -d dna -i 03b_marker_seqs_LSU_alntrimmed_FP.fa -p Neocucurbitaria_partition_LSU.txt -t Neocucurbitaria_concat_LSU.phy -u phylip
python AMAS.py concat -f fasta -d dna -i 03b_marker_seqs_SSU_alntrimmed_FP.fa -p Neocucurbitaria_partition_SSU.txt -t Neocucurbitaria_concat_SSU.phy -u phylip

#Add gene models
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition_ITS.txt
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition_LSU.txt
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition_SSU.txt
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition_RPB2.txt
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition_TEF1.txt
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition_TUB2.txt

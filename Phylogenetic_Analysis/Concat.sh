#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J concat_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/concat.out
#SBATCH -e /data/projects/gaya_lab/Frances/Neocucurbitaria/endophyte_genes/align/example_phylogeny/concat.err


#Concatenate gene alignments

module load  python/3.7.9
module load amas
module load ./amas-amas.py

AMAS.py concat -f fasta -d dna -i marker_seqs_ITS_alntrimmed_edit.fa marker_seqs_LSU_alntrimmed.fa marker_seqs_RBP2_alntrimmed.fa marker_seqs_SSU_alntrimmed.fa marker_seqs_Tef1_alntrimmed.fa marker_seqs_Tub2_alntrimmed.fa  -p Neocucurbitaria_partition.txt -t Neocucurbitaria_concat.phy -u phylip

#Add gene models
sed -i 's/^/GTR+G, /' Neocucurbitaria_partition.txt


#!/bin/bash
#SBATCH -c 1
#SBATCH -p all
#SBATCH -J concat_Neoc_job
#SBATCH -t 0-3:00:00
#SBATCH -o /data/projects/gaya_lab/Frances/example_phylogeny/concat.out
#SBATCH -e /data/projects/gaya_lab/Frances/example_phylogeny/concat.err


#Concatenate gene alignments

module load  python/3.7.9
module load amas

python3 AMAS.py concat -f fasta -d dna -i fusarium_rpb*_alntrimmed.fa -p fusarium_partition.txt -t fusariu$
#Add gene models
sed -i 's/^/GTR+G, /' fusarium_partition.txt

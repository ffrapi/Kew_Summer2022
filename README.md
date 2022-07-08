# Kew_Summer2022

1) Seed Microbiome Project (SMP)


2) Phylogenetic Analysis: 

Steps for phylogenetic analysis: 


      1.	Do a literature search to find papers undertaking a phylogenetic analysis within the taxon of the species of interest
      2.	Do more literature digging to cross check sampling – find papers with more species from the taxon of interest
      3.	Check if alignments are available on online databases
      a.	If NOT available, extract accession numbers from tables in the papers and create a spreadsheet with all species of interest, including their accession numbers for each gene region
      4.	Use R script “GenBank_seq_pull_Neocurcubitaria_FP.r” to extract sequences from GenBank accession numbers for each gene region separately
                a. 	Using this script, a fasta file for each gene region will be created and ready for alignment
      5.	Use GenePull (https://github.com/Rowena-h/MiscGenomicsTools/tree/main/GenePull) to get the same markers out of our own genome and add to the other sequences; genome assemblies are here:   endophyte_genomes.zip.
      6.	Alignment and phylogenetic analysis: 
                a.	Alignment using MAFFT in Kew clusters using scripts found on Rowenas GitHub page
                    i.	Visually check the alignment with AliView to make sure it’s sensible
                b.	Trim and concatenate alingments using Rowenas scripts
                c.	Run RAxML-NG for phylogenetic analysis
                d.	Visualize results in FigTree (use sensible outgroups)

# Phylogenetic analysis: 

### 1) Individual gene trees
### 2) Concatenated tree


   ## 1) Individual gene trees

### Summary of steps: 

````

a) Creating alignments for each gene using data from literature
                i) Do a literature search to find papers undertaking a phylogenetic analysis within the taxon of the species of interest 

                ii) Do more literature digging to cross check sampling – find papers with more species from the taxon of interest 

                iii) Check if alignments are available on online databases 

                iiii) If NOT available, extract accession numbers from tables in the papers and create a spreadsheet with all species of interest, including their accession numbers for each gene region (Example spreadsheet: https://rbgkew.sharepoint.com/:x:/s/KewMycology/EaX-y-T3SYVFqwsKF7p8rSYBcHWXjfwh5czLr-z7XnMvjQ?e=BaeK07) **Make sure to include sensible outgroups in the alignment to root the trees.

                v) Use R script “GenBank_seq_pull_Neocurcubitaria_FP.r” to extract sequences from GenBank accession numbers for each gene region separately 

                  **Using this script, a fasta file for each gene region will be created and ready for alignment**
````

  **b) Use GenePull (https://github.com/Rowena-h/MiscGenomicsTools/tree/main/GenePull) to get the same markers out of our own genome and add to the other sequences; genome assemblies are here: ​zip icon endophyte_genomes.zip. **  
````        
		i) To download GENEPULL: wget https://raw.githubusercontent.com/Rowena-h/MiscGenomicsTools/main/GenePull/GenePull
		ii) Make script executable: chmod +x GenePull
		iii) BLAST + Bedtools need to be installed for genepull to work.
   Both bedtools and blast are installed on kew clusters so ignore step 1+2 and do this:
			module load blas
			module load bedtools/2.30.0**

		iiii)Extract gene from assembly:

./GenePull -a assembly.fa -g marker_seqs_LSU.fa -o Neoc.LSU_result
./GenePull -a assembly.fa -g marker_seqs_ITS.fa -o Neoc.ITS_result
./GenePull -a assembly.fa -g marker_seqs_SSU.fa -o Neoc.SSU_result
./GenePull -a assembly.fa -g marker_seqs_RPB2.fa -o Neoc.RPB2_result
./GenePull -a assembly.fa -g marker_seqs_TEF1.fa -o Neoc.TEF1_result
./GenePull -a assembly.fa -g marker_seqs_TUB2.fa -o Neoc.TUB2_result

-Assembly.fa is the endophyte genome that we are looking to taxonomise
-Marker_seqs_X.fa is the assembly of each gene extracted in the first step for each gene X
-Neoc.X_result are the results from GenePull - i.e. the blast hits from NBCI database that is almost identical to the endophyte genome of interest.
````
````
*Results for some genes could have mutliple hits for multiple reasons: 
	1) Contamination from other species present in the culture - called ‘blobtools’ that helps us visualise how much contamination there might be by mapping the assembly to the entire genbank database. 
		Solution: Use the tool called blobtools to visualise the amount of contamination that might be present in the culture by mapping the assembly to the 	  	     entire genbank database
		If contamination is present: blast the hits you get from GenePULL to check whether any of the hits are from the contamination taxa and 		   		   remove from assembly
	2) The gene is split across multiple sequences, which we should be able to visualize to check whether this is the case using AliView, if sequences align to different regions of the assembly.
		Solution: Can select the multiple sequences and use AliView's 'Edit > Merge 2 selected sequences' . 
	3) The taxon actually has multiple copies for that gene. (can check paralogues, multi-copy genes and their use in phylogenetics).
		Solution: Keep all the hits, run raxml for just that alignment to see where the different copies fall in the gene tree.
````
#STEP 6: 

#6.	Alignment and phylogenetic analysis: 
           # a.	Alignment using MAFFT in Kew clusters using scripts found on Rowenas GitHub page (Align.sh)
                        #i. Transfer final alignment files to computer 
                        #i. Visually check the alignment with AliView to make sure it’s sensible
                        #Remove duplicates (saved as aln.edit.fa)
                        #Tranfser back to computer clusters
                        #Rename using sed
                        
                        sed 's/[^> ]* //' marker_seqs_SSU_aln_edit.fa > SSU_aln_rename.fa
                        #This command line removes the accession number
                        
 sed 's/18S.*//' SSU_aln_rename.fa | sed 's/small.*//' | sed 's/internal.*//' | sed 's/genomic.*//' | sed 's/genes.*//' | sed 's/strain.*//' > SSU_aln_rename_FP.fa                        
           cat SSU_aln_rename_FP1.fa | sed 's/ /_/g' > SSU_aln_rename_FP2.fa    
           
           
           sed 's/[^> ]* //' marker_seqs_RPB2_aln_edit.fa>  RPB2_aln_rename.fa
	sed 's/18S.*//' RPB2_aln_rename.fa | sed 's/small.*//' | sed 's/internal.*//' | sed 's/genomic.*//' | sed 's/genes.*//' | sed 's/strain.*//' | sed 's/gene.*//' | sed 's/:.*//' | sed 's/(.*//' | sed 's/).*//' | sed 's/largest.*//' | sed 's/RNA.*//' | sed 's/;.*//'  | sed 's/,.*//'  | sed 's/’.*//' | sed 's/partial.*//' | sed 's/culture.*//'   | sed 's/RBP2.*//'  > RPB2_aln_rename_FP.fa
cat RPB2_aln_rename_FP.fa | sed 's/ /_/g' > RPB2_aln_rename_FP1.fa

           
           
           
           
           
           
#b.	Trim and concatenate alingments using Rowenas scripts (Trim.sh), (Concat.sh)

#c.	Run RAxML-NG for phylogenetic analysis (raxml.sh)


#d.	Visualize results in FigTree (use sensible outgroups)



# Phylogenetic analysis: 

### 1) Individual gene trees
### 2) Concatenated tree


   ## 1) Individual gene trees

### Summary of steps: 


##### a) Creating alignments for each gene using data from literature

````
		i) Do a literature search to find papers undertaking a phylogenetic analysis within the taxon of the species of interest 

                ii) Do more literature digging to cross check sampling – find papers with more species from the taxon of interest 

                iii) Check if alignments are available on online databases 

                iiii) If NOT available, extract accession numbers from tables in the papers and create a spreadsheet with all species of interest, including their accession numbers for each gene region (Example spreadsheet: https://rbgkew.sharepoint.com/:x:/s/KewMycology/EaX-y-T3SYVFqwsKF7p8rSYBcHWXjfwh5czLr-z7XnMvjQ?e=BaeK07) **Make sure to include sensible outgroups in the alignment to root the trees.

                v) Use R script “GenBank_seq_pull_Neocurcubitaria_FP.r” to extract sequences from GenBank accession numbers for each gene region separately 

                  **Using this script, a fasta file for each gene region will be created and ready for alignment**
````

##### b) Use GenePull (https://github.com/Rowena-h/MiscGenomicsTools/tree/main/GenePull) to get the same markers out of our own genome and add to the other sequences; genome assemblies are here: ​zip icon endophyte_genomes.zip. **  
````        
		i) To download GENEPULL: wget https://raw.githubusercontent.com/Rowena-h/MiscGenomicsTools/main/GenePull/GenePull
		ii) Make script executable: chmod +x GenePull
		iii) BLAST + Bedtools need to be installed for genepull to work.
   Both bedtools and blast are installed on kew clusters so ignore step 1+2 and do this:
			module load blas
			module load bedtools/2.30.0**

		iiii)Extract gene from assembly:

./GenePull -a assembly.fa -g LSU.fa -o Neoc.LSU_result
./GenePull -a assembly.fa -g ITS.fa -o Neoc.ITS_result
./GenePull -a assembly.fa -g SSU.fa -o Neoc.SSU_result
./GenePull -a assembly.fa -g RPB2.fa -o Neoc.RPB2_result
./GenePull -a assembly.fa -g TEF1.fa -o Neoc.TEF1_result
./GenePull -a assembly.fa -g TUB2.fa -o Neoc.TUB2_result

-Assembly.fa is the endophyte genome that we are looking to taxonomise
-g option should be the sequence of a single gene picked out randomly from the assembly created in the first step
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

##### c) Open both assembly of genes (Step a) and the extracted sequences (Step b) of interest (from GenePull) in AliView**

````
	1) Copy and paste the extracted sequence of interest (Step b) into the assembly of genes (Step a)
	2) Do a fast realignment in AliView to ensure that the alignment looks sensible. Two outcomes could occur during this step: 
		i. The extracted sequence of interest might not align properly
			Solution: Reverse complement the extracted sequence of interest and realign again.
		ii. The extracted sequence of interest aligns properly
	3) When the realignment looks sensible, save as .fa and transfer from local computer to cluster
	4) Continue with next steps
````
*To transfer files from local computer to cluster, I prefer to use FileZilla. Instructions on transferring files from and to the cluster are found here: https://rbg-kew-bioinformatics-utils.readthedocs.io/en/latest/kewhpc/ *

##### d) Rename files**

````
The first command gets rid of accession number, the second command gets rid of any extra words in the sequence name (e.g. strain, RNA etc), the third command adds an underscore ('_') where there are spaces in the file (because Trimmomatic cuts out the second part of the species name if spaces exist)

 sed 's/[^> ]* //' marker_seqs_RPB2_aln_edit.fa>  RPB2_aln_rename.fa
 sed 's/18S.*//' RPB2_aln_rename.fa | sed 's/small.*//' | sed 's/internal.*//' | sed 's/genomic.*//' | sed 's/genes.*//' | sed 's/strain.*//' | sed 's/gene.*//' |  sed 's/:.*//' | sed 's/(.*//' | sed 's/).*//' | sed 's/largest.*//' | sed 's/RNA.*//' | sed 's/;.*//'  | sed 's/,.*//'  | sed 's/’.*//' | sed 's/partial.*//' | sed 's/culture.*//'   | sed 's/RBP2.*//'  > RPB2_aln_rename_FP.fa
cat RPB2_aln_rename_FP.fa | sed 's/ /_/g' > RPB2_aln_rename_FP1.fa
````
##### e) Alignment using MAFFT

````
	1) Run the script align.sh in the clusters
		i. Ensure that -i and -o show the correct pathways to the cluster folders where the renamed alignments are
		ii. Make sure that the renamed aligments are correctly named for the script to run
	2) After alignment is complete, transfer files to local computer and visualize in Aliview to ensure that alignments look sensible before continuing on with the next steps
````

##### f) Trim and concatenate alignments (Trim.sh), (Concat.sh)

````
You can either do the trim and concat separately (Trim.sh) and (Concat.sh) or together (Trimconcat.sh)

	1) Modify scripts accordingly, especially pathway -i, -o and file names
	2) Copy and paste AMAS.py into the cluster folder where trimming and concatenating of sequences will take place
	3) Run scripts
````
      
##### g) Run RaxML for genes separately:

````
Modify raxml.sh file accordingly and submit
````
           
##### h) Check the convergenceTest.log file to see if the trees have converged within 1000 bootstraps
##### i) Copy .support files from raxml to local computer and visualize in FigTree using sensible outgroups


 ## 2) Concatenated gene tree
 ### Summary of steps: 
 
 ##### Steps a-e are exactly the same as the individual gene trees, up to the trimming step:
 ##### a) Use the Trim.sh script (NOT the Trimconcat.sh script) to trim the aligmnets of each gene separately
 ##### b) Use the Concat_allgenes.sh script to concatenate all the alignments together (Modify -e, -o, file names etc accordingly)
 ##### c) Use the raxml.sh script to run a concatenated phylogenetic analysis
 		 i. Check the convergenceTest.log file to see if the trees have converged within 1000 bootstraps
	        ii. Copy .support files from raxml to local computer 
 ##### d) Visualize .support files in FigTree using sensible outgroups
 
 [Phylogenetics_Steps_Diagram.pptx](https://github.com/ffrapi/Kew_Summer2022/files/9182191/Phylogenetics_Steps_Diagram.pptx)

 

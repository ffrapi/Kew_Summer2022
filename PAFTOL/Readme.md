ls
![paftol](https://github.com/ffrapi/RGB_KEW_PROJECTS_22-24/assets/70023430/6684715d-8963-4912-8681-a9d2c2b1f8a5)

# Steps after obtaining raw sequences from company

## Summary of steps (DRAFT 1)
1. Transfer files to cluster
2. Use md5sum -c md5sum.txt command to make sure that the raw sequences have been transferred properly
3. Run Rscript "GeneratingArrayJob.R" <br />
     a. Create a .txt file including all genome names (once) without the .fastq.gz extension (e.g. "SampleList") 
           ls *gz > SampleListDRAFT.txt > sed 's/.fastq.gz//g' SampleList.txt  _**FIX SED COMMAND**_ <br />
     b. Request interactive session to run RScipt ("Rscript GeneratingArrayJob.R").<br />
     c. Run Rscript by changing the necessary arguments in the command (Check script for information on each argument). $TMDIR is specified in the scirpt <br />
   
          Rscript GeneratingArrayJob3.R /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Output SampleList3             
         environment_file_template_singularity.env2024JanGenomes2 long 20 32 f.pitsillides@kew.org 10 projects/rbgk/projects/fungalTreeOfLife/apps/assembly_v0.08246_latest.sif master27.sh

        Rscript GeneratingArrayJob3.R /home/fpitsill/projects/rbgk/projects/fungalTreeOfLife/RawGenomeAssembly/Input "$TMPDIR" SampleList3  environment_file_template_singularity_v0.08249.env 2024SumGenomes long 20 32 f.pitsillides@kew.org 10 projects/rbgk/projects/fungalTreeOfLife/apps/assembly_v0.08249_latest.sif master27.sh

   ***POSSIBLE ERROR MESSAGE: $RStudio: command not found
            Will need to install or download R - refer to cluster instructions for this (https://help.cropdiversity.ac.uk/bioconda.html#listing-packages)
             If you are in an interactive node, exit and install the appropriate programs:
             
   **install-bioconda
             conda install -c r rstudio**
          
   Now, when you use rstudio the above command should work

** The RScript that was just run should have generated 2 files (names are dependent on the command you used): 
     1) RscriptFP_array_job.sh
     2) RscriptFP.config

4. Run job using sbatch
     a. Make sure that the array job file and .config file look good (examples found in Github Project main page)
     b. Run the script:

          sbatch RscriptFP_array_job.sh
   




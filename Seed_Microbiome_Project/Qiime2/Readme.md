# Installing Qiime2 <br>

## Useful links:  <br>
Overview: https://docs.qiime2.org/2024.2/install/ , https://docs.qiime2.org/2024.2/install/virtual/wsl/ <br>

## Step 1: Installing WSL on local computer: https://learn.microsoft.com/en-us/windows/wsl/install <br>

    wsl --install 
    wsl --list --online #to see list of Linux distributions 
    wsl --install -d Ubuntu #install Linux distribution Ubuntu 

Following the last command, a window should pop up for Ubuntu <br>

Once you have set up the WSL, you can follow the native conda installation guide, choosing the Windows (via WSL) instructions to finish setting up QIIME 2. <br>
Link for this: https://docs.qiime2.org/2024.2/install/native/ <br>

## Step 2: Install miniconda for Linux: <br>
Link: https://docs.anaconda.com/free/miniconda/ <br>

These four commands quickly and quietly install the latest 64-bit version of the installer and then clean up after themselves. To install a different version or architecture of Miniconda for Linux, change the name of the .sh installer in the wget command. <br>

    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh

After installing, initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells: <br>
It is important to follow all of the directions provided in the Miniconda instructions, particularly ensuring that you run conda init at the end of the installation process, to ensure that your Miniconda installation is fully installed and available for the following commands. <br>

    ~/miniconda3/bin/conda init bash
    ~/miniconda3/bin/conda init zsh

### I specified the path to conda as follows: *CHECK IF THIS IS OKAY"  <br>

    conda=~/miniconda3/bin/conda 

## Step 3: Update and install miniconda: <br>

    ~/miniconda3/bin/conda update conda <br>
    ~/miniconda3/bin/conda install wget <br>

or alternatively, using the path specified above: <br>

    $conda update conda <br>
    $conda install wget  <br>

## Step 4: Install QIIME2 within a conda enviornment  <br>
Once you have Miniconda installed, create a conda environment and install the QIIME 2 2024.2 distribution of your choice within the environment. We highly recommend creating a new environment specifically for the QIIME 2 distribution and release being installed, as there are many required dependencies that you may not want added to an existing environment. You can choose whatever name you’d like for the environment. In this example, we’ll name the environments qiime2-<distro>-2024.2 to indicate what QIIME 2 release is installed (i.e. 2024.2). <br>
Link: https://docs.qiime2.org/2024.2/install/native/ <br>

#### This code can also be run on the cluster to download qiime2
### The code below will download the amplicon "package of qiime2" <br>
    wget https://data.qiime2.org/distro/amplicon/qiime2-amplicon-2024.2-py38-linux-conda.yml
    $conda env create -n qiime2-amplicon-2024.2 --file qiime2-amplicon-2024.2-py38-linux-conda.yml

### To download the other packages: <br>
    wget https://data.qiime2.org/distro/shotgun/qiime2-shotgun-2024.2-py38-linux-conda.yml
    conda env create -n qiime2-shotgun-2024.2 --file qiime2-shotgun-2024.2-py38-linux-conda.yml

optional cleanup: <br>

    rm qiime2-amplicon-2024.2-py38-linux-conda.yml
    rm qiime2-tiny-2024.2-py38-linux-conda.yml

## Step 4:Activate conda environment of Qiime2: <br>
    conda activate qiime2-amplicon-2024.2
    conda activate qiime2-shotgun-2024.2

If you want to deacivate: <br>

    conda deactivate

## Step 5: Check that qiime works <br>

    qiime --help


### EXTRA: UPDATING AND RE-ACTIVATING QIIME2 <br>

### Updating: In order to to update/upgrade to the newest release, you simply install the newest version in a new conda environment by following the instructions above. Then you will have two conda environments, one with the older version of QIIME 2 and one with the newer version.  <br>
        conda activate qiime2-amplicon-2024.2
        conda info

![download](https://github.com/ffrapi/RGB_KEW_PROJECTS_22-24/assets/70023430/5a53f901-f39e-4652-9501-beb691ae5bcf) <br>
## Useful qiime links/commands: 
For visualizing qza, qzv files: https://view.qiime2.org/


# Importing our data
## Importing data can be done wqith the "qiime tools import" method. 
Our data is in the Casava 1.8 paired-end demultiplexed fastq format - so refer to this section of the link below to import your data
Link : https://docs.qiime2.org/2024.2/tutorials/importing/#id34 <br>
####Usage: qiime tools import [OPTIONS] (Linux print out message)

  Import data to create a new QIIME 2 Artifact. See https://docs.qiime2.org/ <br>
  for usage examples and details on the file types and associated semantic<br>
  types that can be imported.<br>

Options:<br>
  --type TEXT             The semantic type of the artifact that will be<br>
                          created upon importing. Use `qiime tools list-types`<br>
                          to see what importable semantic types are available<br>
                          in the current deployment.                [required]<br>
  --input-path PATH       Path to file or directory that should be imported.<br>
                                                                    [required]<br>
  --output-path ARTIFACT  Path where output artifact should be written.<br>
                                                                    [required]<br>
  --input-format TEXT     The format of the data to be imported. If not<br>
                          provided, data must be in the format expected by the<br>
                          semantic type provided via --type. Use `qiime tools<br>
                          list-formats --importable` to see which formats of<br>
                          input data are importable.<br>
  --validate-level [min|max]<br>
                          How much to validate the imported data before<br>
                          creating the artifact. A value of "max" will<br>
                          generally read the entire file or directory, whereas<br>
                          "min" will not usually do so.       [default: "max"]<br>
  --help                  Show this message and exit.<br>

Command used for my data: 

    qiime tools import   --type 'SampleData[PairedEndSequencesWithQuality]'   --input-path /home/frapi/miniconda3/envs/importing_SMP_data   --input-format CasavaOneEightSingleLanePerSampleDirFmt   --output-path SMP_demux-paired-end.qza

**After using this command, a single file ending in .qza should be created. This is the qiime artifact that will be used for future analyses.** <br>

# Demultiplexin sequences 
Our samples have already been demultiplexed so we can skip this step and continue with the enxt one: denoising

# Removing adapters: ** need to revise this**
https://docs.qiime2.org/2018.2/plugins/available/cutadapt/trim-paired/ <br>

    qiime cutadapt trim-paired \
      --i-demultiplexed-sequences SMP_demux-paired-end.qza \
      --p-front-f TAGAGGAAGTAAAAGTCGTAA \
      --p-error-rate 0 \
      --p-front-r CWGYGTTCTTCATCGATG \
      --o-trimmed-sequences SMP_demux-paired-end_trimmed.qza \
      --verbose

Creating a summary of the demultiplexing results. THIS ALLOWS YOU TO DETERMINE HOW MANY SEQUENCES WERE OBTAINED PER SAMPLE, AND ALSO TO GET A SUYMMARY of he distribution of sequence qualities at each position in your sequence data. <br>

    qiime demux summarize \
      --i-data SMP_demux-paired-end_trimmed.qza \
      --o-visualization SMP_demux-paired-end_trimmed.qzv

  View the results: 
  
          qiime tools view SMP_demux-paired-end_trimmed.qzv
# Denoising and clustering

## Steps:  <br>
### 1. Denoise <br>
### 2. Dereiplicate <br>
### 3. Cluster  <br>

## De-noising + De-replicating

QIIME 2 plugins are available for several quality control methods, including DADA2, Deblur, and basic quality-score-based filtering. In this tutorial we present this step using DADA2 and Deblur. These steps are interchangeable, so you can use whichever of these you prefer. The result of both of these methods will be a FeatureTable[Frequency] QIIME 2 artifact, which contains counts (frequencies) of each unique sequence in each sample in the dataset, and a FeatureData[Sequence] QIIME 2 artifact, which maps feature identifiers in the FeatureTable to the sequences they represent. <br> 
Link: https://docs.qiime2.org/2024.2/tutorials/moving-pictures/ <br>

#### OPTION 1: DADA2
DADA2 is a pipeline for detecting and correcting (where possible) Illumina amplicon sequence data. As implemented in the q2-dada2 plugin, this quality control process will additionally filter any phiX reads (commonly present in marker gene Illumina sequence data) that are identified in the sequencing data, and will filter chimeric sequences.<br>

The dada2 denoise-single method requires two parameters that are used in quality filtering: --p-trim-left m, which trims off the first m bases of each sequence, and --p-trunc-len n which truncates each sequence at position n. This allows the user to remove low quality regions of the sequences. To determine what values to pass for these two parameters, you should review the Interactive Quality Plot tab in the demux.qzv file that was generated by qiime demux summarize above.<br>
Link: https://docs.qiime2.org/jupyterbooks/cancer-microbiome-intervention-tutorial/020-tutorial-upstream/040-denoising.html <br>

Based on the Interative quality plot (https://view.qiime2.org/visualization/?type=html&src=663c6f9e-3b11-4708-8472-b06d337639a9) I will truncate my forward sequences at position 265 and my reverse sequences at 210 bases.<br>

    qiime dada2 denoise-paired \
      --i-demultiplexed-seqs SMP_demux-paired-end_trimmed.qza \
      --p-trunc-len-f 265 \
      --p-trunc-len-r 210 \
      --p-trim-left-r 40 \
      --o-representative-sequences SMP_rep-seqs-dada2.qza \
      --o-table SMP_table-dada2.qza \
      --o-denoising-stats SMP_stats-dada2.qza

This command usually takes the most time out of the whole pipeline (around 10 minutes?). <br>
The output artifacts are as follows: <br>
- stats-dada2.qza
- table-dada2.gza
- rep-seqs-dada2.gza

Next, we want to explore the resulting data by visualizing it: 

    qiime feature-table summarize \
      --i-table SMP_table-dada2.qza \
      --o-visualization SMP_table-dada2.qzv \
      
    qiime feature-table tabulate-seqs \
      --i-data SMP_rep-seqs-dada2.qza \
      --o-visualization SMP_rep-seqs-dada2.qzv \



## Clustering sequences into OTUs 
De novo, closed-reference, and open-reference clustering are currently supported in QIIME 2.<br>
Link: https://docs.qiime2.org/2024.2/tutorials/otu-clustering/ <br>
Create directory to work in
    mkdir qiime2-otu-clustering-SMP
    cd qiime2-otu-clustering-SMP

### 1: De-novo clustering 
    qiime vsearch cluster-features-de-novo \
      --i-table SMP_table-dada2.qza \
      --i-sequences SMP_rep-seqs-dada2.qza \
      --p-perc-identity 0.99 \
      --o-clustered-table SMP_table-dn-99.qza \
      --o-clustered-sequences SMP_rep-seqs-dn-99.qza

 qiime feature-table tabulate-seqs \
      --i-data SMP_rep-seqs-dada2.qza \
      --o-visualization SMP_rep-seqs-dada2.qzv \

### 2: Closed-reference clustering ** to do in future **<br>
### 3: Open-reference clustering ** to do in future **<br>


## Chimera filtering 
Link: https://docs.qiime2.org/2024.2/tutorials/chimera/ <br>
*** Do we need to run this on the previously clustered files or? ***<br>

### Run de novo chimera checking<br>

    qiime vsearch uchime-denovo \
      --i-table SMP_table-dn-99.qza \
      --i-sequences SMP_rep-seqs-dn-99.qza \
      --output-dir SMP_uchime-dn-out
### Visualize summary stats 

    qiime metadata tabulate \
      --m-input-file SMP_uchime-dn-out/stats.qza \
      --o-visualization SMP_uchime-dn-out/stats.qzv

### Fitler input tables and sequences<br>
#### Exclude chimeras and "borderline chimeras"<br>

    qiime feature-table filter-features \
      --i-table SMP_table-dn-99.qza \
      --m-metadata-file SMP_uchime-dn-out/nonchimeras.qza \
      --o-filtered-table SMP_uchime-dn-out/table-nonchimeric-wo-borderline.qza
    qiime feature-table filter-seqs \
      --i-data SMP_rep-seqs-dn-99.qza \
      --m-metadata-file SMP_uchime-dn-out/nonchimeras.qza \
      --o-filtered-data SMP_uchime-dn-out/rep-seqs-nonchimeric-wo-borderline.qza
    qiime feature-table summarize \
      --i-table SMP_uchime-dn-out/table-nonchimeric-wo-borderline.qza \
      --o-visualization SMP_uchime-dn-out/table-nonchimeric-wo-borderline.qzv


# Taxonomic assignment

## Training feature classifier

    mkdir training-feature-classifiers
    cd training-feature-classifiers

### 1: Obtain and import reference data sets

Two things are required for training the classifier: 1) the reference sequences and the corresponding taxonomic classifications <br>
Link: https://doi.plutof.ut.ee/doi/10.15156/BIO/2959336 , https://unite.ut.ee/repository.php<br>
Download the latest qiime2 release (.tgz) file<br>
Add this to Ubuntu and unzip twice - all files should appear (6 files, 1 pdf, 2 fasta, 2 txt etc)<br>

    qiime tools import \
      --type 'FeatureData[Sequence]' \
      --input-path /home/frapi/miniconda3/envs/training-feature-classifiers/sh_qiime_release_04.04.2024/sh_refs_qiime_ver10_97_04.04.2024.fasta \
      --output-path /home/frapi/miniconda3/envs/training-feature-classifiers/sh_qiime_release_04.04.2024/sh_refs_qiime_ver10_97_04.04.2024.qza
    
    qiime tools import \
      --type 'FeatureData[Taxonomy]' \
      --input-format HeaderlessTSVTaxonomyFormat \
      --input-path /home/frapi/miniconda3/envs/training-feature-classifiers/sh_qiime_release_04.04.2024/sh_taxonomy_qiime_ver10_97_04.04.2024.txt \
      --output-path UNITE_ref-taxonomy.qza

### 2: Extract reference reads<br>
This command will need specific modifications based on our system - check what Sam from FERA used for this part <br>

    qiime feature-classifier extract-reads \
      --i-sequences sh_refs_qiime_ver10_97_04.04.2024.qza \
      --p-f-primer TAGAGGAAGTAAAAGTCGTAA \
      --p-r-primer CWGYGTTCTTCATCGATG \
      --p-trunc-len 120 \
      --p-min-length 100 \
      --p-max-length 400 \
      --o-reads UNITE_ref-seqs.qza

### 3: Train the classifier: 
Train our Naive Bayes classifier, using the reference reads and taxonomy that we just created

    qiime feature-classifier fit-classifier-naive-bayes \
      --i-reference-reads UNITE1_ref-seqs.qza \
      --i-reference-taxonomy UNITE_ref-taxonomy.qza \
      --o-classifier UNITE1_classifier.qza

### 4: Test the classifier
Verify that the classifier works by classifying the representative sequences in our sample and viwualizing the resulting taxonomic assignments 

    qiime feature-classifier classify-sklearn \
      --i-classifier UNITE1_classifier.qza \
      --i-reads SMP_rep-seqs-dn-99.qza \
      --o-classification SMP_taxonomy.qza
    
    qiime metadata tabulate \
      --m-input-file SMP_taxonomy.qza \
      --o-visualization SMP_taxonomy.qzv

### Use pre-trained classifier: 
     qiime feature-classifier classify-sklearn \
      --i-classifier unite_ver10_dynamic_all_04.04.2024-Q2-2024.2.qza \
      --i-reads6_SMP_DADA2_Trim6_Trunc240_FP.qza \
      --o-classification T1_SMP_taxonomy_dynamic_all.qza

          qiime metadata tabulate \
      --m-input-file T1_SMP_taxonomy_dynamic_all.qza \
      --o-visualization T1_SMP_taxonomy_dynamic_all.qzv


# Analyzing feature tables

## Taxonomic analysis/visualization
    qiime taxa barplot \
    --i-table 6_SMP_DADA2_table_Trim6_Trunc240_FP.qza \
    --i-taxonomy T1_SMP_taxonomy_dynamic_all.qza \
    --o-visualization T1_taxa-bar-plots.qzv

## building phylogenetic tree
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences 6_SMP_DADA2_Trim6_Trunc240_FP.qza \
  --o-alignment 6_SMP_DADA2_Trim6_Trunc240_FP_aligned.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza

## diversity
  qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table 6_SMP_DADA2_table_Trim6_Trunc240_FP.qza \
  --p-sampling-depth 1103 \
  --output-dir core-metrics-results

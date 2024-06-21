# DADA2 Pipeline in Qiime2 FP 

Check Readme.md file for how to install Qiime2 on WSL 
If you need any help during the pipeline use the following command: 

    qiime --help

For visualizing qza, qzv files: https://view.qiime2.org/

## Before you start: Activate qiime2 plugin in your terminal

    conda activate qiime2-amplicon-2024.2
    #conda activate qiime2-shotgun-2024.2
## 0. Getting started
It is important to keep the directory you are working in tidy and consistent. In the following code, I will use the names of folders and files that I used when analyzing my data. <br>
Before you start your analysis, create one main directory called "SMP_2024". <br>
In this directory, create 2 further folders named "importing_SMP_data" and "FREE_NAME". In the first folder, transfer all your raw sequences while making sure that nothing else exists in that folder. In the second folder, feel free to name it as you would like. Here I will use T5_21JUNE2024 - that indicates my 5th trial of this analysis and the date I started this trial. <br>
Now you are ready to go! <br>


## 1. Importing your data

**Source**: https://docs.qiime2.org/2024.5/tutorials/importing/

**Format description** <br>
In Casava 1.8 demultiplexed (paired-end) format, there are two fastq.gz files for each sample in the study, each containing the forward or reverse reads for that sample. The file name includes the sample identifier. The forward and reverse read file names for a single sample might look like L2S357_15_L001_R1_001.fastq.gz and L2S357_15_L001_R2_001.fastq.gz, respectively. The underscore-separated fields in this file name are:
the sample identifier, the barcode sequence or a barcode identifier, the lane number, the direction of the read (i.e. R1 or R2), and the set number. <br>

One of my example files: ITS-WS1_S45_L001_R1_001 + ITS-WS1_S45_L001_R2_001  <br>
**Note**: My samples are already demultiplexed so I will indicate this in the output file <br>
Make sure to change the input and output path to yours:

    qiime tools import  --type 'SampleData[PairedEndSequencesWithQuality]' --input-path /home/frapi/SMP_2024/importing_SMP_data/   --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path /home/frapi/SMP_2024/T5_21JUNE2024/S0_DADA2_FP.qza

Check that your imported sequences are in the correct format - confirming that import worked as expected: 

    qiime tools peek S0_DADA2_FP.qza

Generate summary of the demultiplexnig results. Here we will be able to see how many sequences were obtained per sample, and also to get a summary of the distribuion of sequence qualities at each position in your sequence data. 

    qiime demux summarize \
      --i-data S0_DADA2_FP.qza \
      --o-visualization S0_DADA2_FP.qzv

This command will produce the .qzv file that you can view using either this website: https://view.qiime2.org/ or this command (this command will not work on Ubuntu or linux): 

      qiime tools view S0_DADA2_FP.qzv

## 2: Cutadapt - removing non-biological sequences

    qiime cutadapt trim-paired \
      --i-demultiplexed-sequences S0_DADA2_FP.qza \
      --p-cores 4 \
      --p-front-f TAGAGGAAGTAAAAGTCGTAA \
      --p-front-r CWGYGTTCTTCATCGATG \
      --o-trimmed-sequences S1_DADA2_FP.qza \
      --verbose

      
Convert the file to .qzv and check the quality read profiles - you will see that the first reads will change. 

        qiime demux summarize \
              --i-data S1_DADA2_FP.qza \
              --o-visualization S1_DADA2_FP.qzv

## 3. Denoising using DADA2 plugin 

**Source**: https://docs.qiime2.org/2024.5/plugins/available/dada2/denoise-paired/ <br>

DADA2 is a pipeline for detecting and correcting Illumina amplicon sequence data. The parameters selected here were based on the read quality plots and prior testing of the different parameters (See DADA2-denoising_trials_Readme.md)  <br>

#For ITS sequencing, it is usually undesirable to truncate reads to a fixed length due to the large length variation at that locus. That is OK, just leave out truncLen. See the DADA2 ITS workflow for more information

     qiime dada2 denoise-paired \
          --i-demultiplexed-seqs S1_DADA2_FP.qza \
          --p-trim-left-f 0 \
          --p-trim-left-r 0 \
          --p-trunc-len-f 0 \
          --p-trunc-len-r 0 \
          --p-max-ee-f 2.0 \
          --p-max-ee-r 2.0 \
          --p-trunc-q 2 \
          --o-representative-sequences S2_DADA2_FeatureTable_FP_T1.qza \
          --o-table S2_DADA2_Table_FP_T1.qza \
          --o-denoising-stats S2_DADA2_stats_FP_T1.qza

Denoising samples that have not been through cutadapt - i.e. non biological parts of the reads have not been removed - for comparison purposes only.
           
        qiime dada2 denoise-paired \
          --i-demultiplexed-seqs S0_DADA2_FP.qza \
          --p-trim-left-f 0 \
          --p-trim-left-r 0 \
          --p-trunc-len-f 0 \
          --p-trunc-len-r 0 \
          --p-max-ee-f 2.0 \
          --p-max-ee-r 2.0 \
          --p-trunc-q 2 \
          --o-representative-sequences S2.0_DADA2_FeatureTable_FP_T1.qza \
          --o-table S2.0_DADA2_Table_FP_T1.qza \
          --o-denoising-stats S2.0_DADA2_stats_FP_T1.qza

Generate summaries for the feature table, the corresponding feature sequences and DADA2 denoising statistics. 

    qiime feature-table tabulate-seqs \
      --i-data S2_DADA2_FeatureTable_FP_T1.qza \
      --o-visualization S2_DADA2_FeatureTable_FP_T1.qzv
      
      qiime feature-table summarize \
      --i-table S2_DADA2_Table_FP_T1.qza \
      --o-visualization S2_DADA2_Table_FP_T1.qzv
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime metadata tabulate \
      --m-input-file S2_DADA2_stats_FP_T1.qza \
      --o-visualization S2_DADA2_stats_FP_T1.qzv


# 4: Taxonomic assignment

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
      --p-max-length 500 \
      --o-reads UNITE_ref-seqs.qza

### 3: Train the classifier: 
Train our Naive Bayes classifier, using the reference reads and taxonomy that we just created

    qiime feature-classifier fit-classifier-naive-bayes \
      --i-reference-reads UNITE_ref-seqs.qza \
      --i-reference-taxonomy UNITE_ref-taxonomy.qza \
      --o-classifier UNITE_classifier_ML500_TL_120.qza

### 4: Test the classifier
Verify that the classifier works by classifying the representative sequences in our sample and visualizing the resulting taxonomic assignments 

    qiime feature-classifier classify-sklearn \
      --i-classifier UNITE_classifier_ML500_TL_120.qza \
      --i-reads 6_SMP_DADA2_Trim6_Trunc240_FP.qza \
      --o-classification SMP_Taxonomy_T1_11JUNE.qza
    
    qiime metadata tabulate \
      --m-input-file SMP_Taxonomy_T1_11JUNE.qza \
      --o-visualization SMP_Taxonomy_T1_11JUNE.qzv



#### Trial 1: Training classifiers

    qiime feature-classifier extract-reads \
      --i-sequences sh_refs_qiime_ver10_97_04.04.2024.qza \
      --p-f-primer TAGAGGAAGTAAAAGTCGTAA \
      --p-r-primer CWGYGTTCTTCATCGATG \
      --p-trunc-len 0 \
      --p-min-length 100 \
      --p-max-length 700 \
      --o-reads UNITE_ref-seqs_T1.qza
      
    qiime feature-classifier fit-classifier-naive-bayes \
      --i-reference-reads UNITE_ref-seqs_T1.qza \
      --i-reference-taxonomy UNITE_ref-taxonomy.qza \
      --o-classifier UNITE_classifier_ML700_TL_0.qza


      qiime feature-classifier classify-sklearn \
      --i-classifier UNITE_classifier_ML700_TL_0.qza \
      --i-reads 6_SMP_DADA2_Trim6_Trunc240_FP.qza \
      --o-classification SMP_Taxonomy_T1_11JUNE.qza
    
    qiime metadata tabulate \
      --m-input-file SMP_Taxonomy_T1_11JUNE.qza \
      --o-visualization SMP_Taxonomy_T1_11JUNE.qzv



 qiime feature-classifier classify-sklearn \
      --i-classifier /home/frapi/SMP_2024/T3_4JUNE/training-feature-classifiers/sh_qiime_release_04.04.2024/UNITE_classifier_ML700_TL_0.qza \
      --i-reads 6_SMP_DADA2_Trim6_Trunc240_FP.qza \
      --o-classification 6_SMP_Taxonomy_T1_18JUNE.qza
    
    qiime metadata tabulate \
      --m-input-file 6_SMP_Taxonomy_T1_18JUNE.qza \
      --o-visualization 6_SMP_Taxonomy_T1_18JUNE.qzv

          qiime taxa barplot \
      --i-table 6_SMP_DADA2_table_Trim6_Trunc240_FP.qza \
      --i-taxonomy 6_SMP_Taxonomy_T1_18JUNE.qza \
      --o-visualization taxa-bar-plots.qzv

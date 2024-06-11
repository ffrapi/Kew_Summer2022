# DADA2 Pipeline in Qiime2 FP 

Check Readme.md file for how to install Qiime2 on WSL 
If you need any help during the pipeline use the following command: 

    qiime --help

For visualizing qza, qzv files: https://view.qiime2.org/

## Before you start: Activate qiime2 plugin in your terminal

    conda activate qiime2-amplicon-2024.2
    #conda activate qiime2-shotgun-2024.2

## 1. Importing your data
**Source**: https://docs.qiime2.org/2024.5/tutorials/importing/

**Format description** <br>
In Casava 1.8 demultiplexed (paired-end) format, there are two fastq.gz files for each sample in the study, each containing the forward or reverse reads for that sample. The file name includes the sample identifier. The forward and reverse read file names for a single sample might look like L2S357_15_L001_R1_001.fastq.gz and L2S357_15_L001_R2_001.fastq.gz, respectively. The underscore-separated fields in this file name are:
the sample identifier, the barcode sequence or a barcode identifier, the lane number, the direction of the read (i.e. R1 or R2), and the set number. <br>

One of my example files: ITS-WS1_S45_L001_R1_001 + ITS-WS1_S45_L001_R2_001  <br>
**Note**: My samples are already demultiplexed so I will indicate this in the output file <br>

    qiime tools import  --type 'SampleData[PairedEndSequencesWithQuality]' --input-path /home/frapi/SMP_2024/importing_SMP_data   --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path /home/frapi/SMP_2024/T3_4JUNE/SMP_demux-paired-end_FP.qza

Check that your imported sequences are in the correct format - confirming that import worked as expected: 

    qiime tools peek SMP_demux-paired-end_FP.qza

Generate summary of the demultiplexnig results. Here we will be able to see how many sequences were obtained per sample, and also to get a summary of the distribuion of sequence qualities at each position in your sequence data. 

    qiime demux summarize \
      --i-data SMP_demux-paired-end_FP.qza \
      --o-visualization SMP_demux-paired-end_FP.qzv

This command will produce the .qzv file that you can view using either this website: https://view.qiime2.org/ or this command: 

      qiime tools view SMP_demux-paired-end_FP.qzv

## 2. Denoising using DADA2 plugin 

**Source**: https://docs.qiime2.org/2024.5/plugins/available/dada2/denoise-paired/ <br>

DADA2 is a pipeline for detecting and correcting Illumina amplicon sequence data. <br>

#### Trial 1: 
    qiime dada2 denoise-paired \
      --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
      --p-trim-left-f 25 \
      --p-trim-left-r 25 \
      --p-trunc-len-f 300 \
      --p-trunc-len-r 300 \
      --o-representative-sequences SMP_DADA2_Trim25_Trunc250_FP.qza \
      --o-table SMP_DADA2_table_Trim25_Trunc300_FP.qza \
      --o-denoising-stats SMP_DADA2_stats_Trim25_Trunc300_FP.qza

#### Trial 2: 
     qiime dada2 denoise-paired \
          --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
          --p-trim-left-f 2 \
          --p-trim-left-r 2 \
          --p-trunc-len-f 300 \
          --p-trunc-len-r 300 \
          --o-representative-sequences SMP_DADA2_Trim2_Trunc250_FP.qza \
          --o-table SMP_DADA2_table_Trim2_Trunc300_FP.qza \
          --o-denoising-stats SMP_DADA2_stats_Trim2_Trunc300_FP.qza

         qiime feature-table summarize \
      --i-table SMP_DADA2_table_Trim2_Trunc300_FP.qza \
      --o-visualization 2_SMP_DADA2_table_Trim2_Trunc300_FP.qzv 
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data SMP_DADA2_Trim2_Trunc250_FP.qza \
      --o-visualization 2_SMP_DADA2_Trim2_Trunc250_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file SMP_DADA2_stats_Trim2_Trunc300_FP.qza \
      --o-visualization 2_SMP_DADA2_stats_Trim2_Trunc300_FP.qzv


### Trial 3: 

 qiime dada2 denoise-paired \
          --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
          --p-trim-left-f 6 \
          --p-trim-left-r 6 \
          --p-trunc-len-f 300 \
          --p-trunc-len-r 300 \
          --o-representative-sequences 3_SMP_DADA2_Trim6_Trunc250_FP.qza \
          --o-table 3_SMP_DADA2_table_Trim6_Trunc300_FP.qza \
          --o-denoising-stats 3_SMP_DADA2_stats_Trim6_Trunc300_FP.qza

         qiime feature-table summarize \
      --i-table  3_SMP_DADA2_table_Trim6_Trunc300_FP.qza \
      --o-visualization 3_SMP_DADA2_table_Trim6_Trunc300_FP.qzv 
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data 3_SMP_DADA2_Trim6_Trunc250_FP.qza \
      --o-visualization 3_SMP_DADA2_Trim6_Trunc250_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file  3_SMP_DADA2_stats_Trim6_Trunc300_FP.qza \
      --o-visualization  3_SMP_DADA2_stats_Trim6_Trunc300_FP.qzv

### Trial 4: 

 qiime dada2 denoise-paired \
          --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
          --p-trim-left-f 50 \
          --p-trim-left-r 50 \
          --p-trunc-len-f 300 \
          --p-trunc-len-r 300 \
          --o-representative-sequences 4_SMP_DADA2_Trim50_Trunc300_FP.qza \
          --o-table 4_SMP_DADA2_table_Trim50_Trunc300_FP.qza \
          --o-denoising-stats 4_SMP_DADA2_stats_Trim50_Trunc300_FP.qza

         qiime feature-table summarize \
      --i-table  4_SMP_DADA2_table_Trim50_Trunc300_FP.qza \
      --o-visualization 4_SMP_DADA2_table_Trim50_Trunc300_FP.qzv
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data 4_SMP_DADA2_Trim50_Trunc300_FP.qza \
      --o-visualization 4_SMP_DADA2_Trim50_Trunc300_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file  4_SMP_DADA2_stats_Trim50_Trunc300_FP.qza \
      --o-visualization   4_SMP_DADA2_stats_Trim50_Trunc300_FP.qzv


### Trial 5: Reducing truncation length 

     qiime dada2 denoise-paired \
          --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
          --p-trim-left-f 6 \
          --p-trim-left-r 6 \
          --p-trunc-len-f 250 \
          --p-trunc-len-r 250 \
          --o-representative-sequences 5_SMP_DADA2_Trim6_Trunc250_FP.qza \
          --o-table 5_SMP_DADA2_table_Trim6_Trunc250_FP.qza \
          --o-denoising-stats 5_SMP_DADA2_stats_Trim6_Trunc250_FP.qza

         qiime feature-table summarize \
      --i-table 5_SMP_DADA2_table_Trim6_Trunc250_FP.qza \
      --o-visualization 5_SMP_DADA2_table_Trim6_Trunc250_FP.qzv
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data  5_SMP_DADA2_Trim6_Trunc250_FP.qza \
      --o-visualization 5_SMP_DADA2_Trim6_Trunc250_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file  5_SMP_DADA2_stats_Trim6_Trunc250_FP.qza \
      --o-visualization   5_SMP_DADA2_stats_Trim6_Trunc250_FP.qzv


### Trial 6: Reducing truncation length 

     qiime dada2 denoise-paired \
          --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
          --p-trim-left-f 6 \
          --p-trim-left-r 6 \
          --p-trunc-len-f 240 \
          --p-trunc-len-r 240 \
          --o-representative-sequences 6_SMP_DADA2_Trim6_Trunc240_FP.qza \
          --o-table 6_SMP_DADA2_table_Trim6_Trunc240_FP.qza \
          --o-denoising-stats 6_SMP_DADA2_stats_Trim6_Trunc240_FP.qza

         qiime feature-table summarize \
      --i-table 6_SMP_DADA2_table_Trim6_Trunc240_FP.qza \
      --o-visualization 6_SMP_DADA2_table_Trim6_Trunc240_FP.qzv
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data  6_SMP_DADA2_Trim6_Trunc240_FP.qza \
      --o-visualization 6_SMP_DADA2_Trim6_Trunc240_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file  6_SMP_DADA2_stats_Trim6_Trunc240_FP.qza \
      --o-visualization   6_SMP_DADA2_stats_Trim6_Trunc240_FP.qzv


### Trial 7: Reducing truncation length 

     qiime dada2 denoise-paired \
          --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
          --p-trim-left-f 6 \
          --p-trim-left-r 6 \
          --p-trunc-len-f 225 \
          --p-trunc-len-r 225 \
          --o-representative-sequences 7_SMP_DADA2_Trim6_Trunc225_FP.qza \
          --o-table 7_SMP_DADA2_table_Trim6_Trunc225_FP.qza \
          --o-denoising-stats 7_SMP_DADA2_stats_Trim6_Trunc225_FP.qza

         qiime feature-table summarize \
      --i-table 7_SMP_DADA2_table_Trim6_Trunc225_FP.qza \
      --o-visualization 7_SMP_DADA2_table_Trim6_Trunc225_FP.qzv
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data  7_SMP_DADA2_Trim6_Trunc225_FP.qza \
      --o-visualization 7_SMP_DADA2_Trim6_Trunc225_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file  7_SMP_DADA2_stats_Trim6_Trunc225_FP.qza \
      --o-visualization   7_SMP_DADA2_stats_Trim6_Trunc225_FP.qzv


### Trial 8: Reducing truncation length 

     qiime dada2 denoise-paired \
          --i-demultiplexed-seqs SMP_demux-paired-end_FP.qza \
          --p-trim-left-f 6 \
          --p-trim-left-r 6 \
          --p-trunc-len-f 200 \
          --p-trunc-len-r 200 \
          --o-representative-sequences 8_SMP_DADA2_Trim6_Trunc200_FP.qza \
          --o-table 8_SMP_DADA2_table_Trim6_Trunc200_FP.qza \
          --o-denoising-stats 8_SMP_DADA2_stats_Trim6_Trunc200_FP.qza

         qiime feature-table summarize \
      --i-table 8_SMP_DADA2_table_Trim6_Trunc200_FP.qza \
      --o-visualization 8_SMP_DADA2_table_Trim6_Trunc200_FP.qzv
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data  8_SMP_DADA2_Trim6_Trunc200_FP.qza \
      --o-visualization 8_SMP_DADA2_Trim6_Trunc200_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file  8_SMP_DADA2_stats_Trim6_Trunc200_FP.qza \
      --o-visualization   8_SMP_DADA2_stats_Trim6_Trunc200_FP.qzv







Generate summaries for the feature table, the corresponding feature sequences and DADA2 denoising statistics. 

    qiime feature-table summarize \
      --i-table SMP_DADA2_table_Trim25_Trunc300_FP.qza \
      --o-visualization SMP_DADA2_table_Trim25_Trunc300_FP.qzv 
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime feature-table tabulate-seqs \
      --i-data SMP_DADA2_Trim25_Trunc250_FP.qza \
      --o-visualization SMP_DADA2_Trim25_Trunc250_FP.qzv
    
    qiime metadata tabulate \
      --m-input-file SMP_DADA2_stats_Trim25_Trunc300_FP.qza \
      --o-visualization SMP_DADA2_stats_Trim25_Trunc300_FP.qzv



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

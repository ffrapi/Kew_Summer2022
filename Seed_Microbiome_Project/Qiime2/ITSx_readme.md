### Installing + verify 

#### ITSx works only for fasta
    conda install bioconda::itsx
    ITSx --version

## Example command: 

ITSx -i input.fasta -o output.fasta

# ITSxpress

### useful links: 
https://library.qiime2.org/plugins/q2-itsxpress/8/
https://forum.qiime2.org/t/q2-itsxpress-a-tutorial-on-a-qiime-2-plugin-to-trim-its-sequences/5780

### install
    conda install -c bioconda itsxpress
    pip install q2-itsxpress
    qiime dev refresh-cache

#### check 
    qiime itsxpress


### 1: import sequences (if not done already)

    qiime tools import  --type 'SampleData[PairedEndSequencesWithQuality]' --input-path /home/fpi10kg/SMP_2024/raw_reads/Zipped   --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path /home/fpi10kg/SMP_2024/T6_27JUNE2024/S0_DADA2_FP.qza

qiime demux summarize \
    
      --i-data S0_DADA2_FP.qza \
      --o-visualization S0_DADA2_FP.qzv

### 2: Trim reads with ITSxpress for DADA2 
ITSxpress trim-pair-output-unmerged takes paired-end QIIME artifacts
SampleData[PairedEndSequencesWithQuality] for
trimming. It merges the reads, temporally clusters the reads, then looks for
the ends of the ITS region with Hmmsearch. HMM models are available for 18
different clades. itsxpress trim-pair-output-unmerged returns the unmerged, trimmed sequences. itsxpress trim-pair-output-merged returns merged, trimmed sequences. You can adjust the --p-cluster-id value, which is the percent identity for clustering reads range [0.995-1.0], set to 1 for exact de-replication.

#### 99.5% clustering: 
    qiime itsxpress trim-pair-output-unmerged\
      --i-per-sample-sequences S0_DADA2_FP.qza \
      --p-region ITS1 \
      --p-taxa F \
      --p-cluster-id 0.995 \
      --p-threads 16 \
      --o-trimmed S1.1_DADA2_FP_99.5.qza

     qiime demux summarize \
      --i-data S1.1_DADA2_FP_99.5.qza \
      --o-visualization S1.1_DADA2_FP_99.5.qzv
      
  #### 100% clustering: 
      qiime itsxpress trim-pair-output-unmerged\
      --i-per-sample-sequences S0_DADA2_FP.qza \
      --p-region ITS1 \
      --p-taxa F \
      --p-cluster-id 1.0 \
      --p-threads 16 \
      --o-trimmed S1.1_DADA2_FP_100.qza
    
    
  
### 3: Identify sequence variants using DADA2
    qiime dada2 denoise-paired \
      --i-demultiplexed-seqs S1.1_DADA2_FP_99.5.qza \
      --p-trunc-len-r 0 \
      --p-trunc-len-f 0 \
      --o-representative-sequences S2.1_DADA2_FeatureTable_FP_T1_99.5.qza \
      --o-table S2.1_DADA2_Table_FP_T1_99.5.qza \
      --o-denoising-stats S2.1_DADA2_stats_FP_T1_99.5.qza

    qiime feature-table tabulate-seqs \
      --i-data S2.1_DADA2_FeatureTable_FP_T1_99.5.qza \
      --o-visualization S2.1_DADA2_FeatureTable_FP_T1_99.5.qzv
      
      qiime feature-table summarize \
      --i-table S2.1_DADA2_Table_FP_T1_99.5.qza \
      --o-visualization S2.1_DADA2_Table_FP_T1_99.5.qzv
     # --m-sample-metadata-file sample-metadata.tsv
    
    qiime metadata tabulate \
      --m-input-file S2.1_DADA2_stats_FP_T1_99.5.qza \
      --o-visualization S2.1_DADA2_stats_FP_T1_99.5.qzv

### 3: Classifying the reads
Firstly, download the UNITE database if you haven't done so already <br>
Create a directory called "UNITE_database" in your working directory and download this sh_qiime_release_04.04.2024.tar <br>


#### import 
qiime tools import \
  --type 'FeatureData[Sequence]' \
  --input-path /home/fpi10kg/SMP_2024/T6_27JUNE2024/sh_refs_qiime_ver10_99_04.04.2024.fasta \
  --output-path unite_99.qza
  
qiime tools import \
--type 'FeatureData[Taxonomy]' \
--input-format HeaderlessTSVTaxonomyFormat \
--input-path /home/fpi10kg/SMP_2024/T6_27JUNE2024/sh_taxonomy_qiime_ver10_99_04.04.2024.txt \
--output-path unite-taxonomy_99.qza

#### train classifier 
qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads unite_99.qza \
  --i-reference-taxonomy unite-taxonomy_99.qza \
  --o-classifier classifier_99.qza

#### clsassify sequence variants 
qiime feature-classifier classify-sklearn \
  --i-classifier classifier_99.qza \
  --i-reads S2.1_DADA2_FeatureTable_FP_T1_99.5.qza \
  --o-classification S3.1_DADA2_Taxonomy_FP_T1_99.5_99all.qza

  #### summarize results

  qiime metadata tabulate \
  --m-input-file S3.1_DADA2_Taxonomy_FP_T1_99.5_99all.qza \
  --o-visualization S3.1_DADA2_Taxonomy_FP_T1_99.5_99all.qzv

  ## create interactive barplot

  qiime taxa barplot \
  --i-table S2.1_DADA2_Table_FP_T1_99.5.qza  \
  --i-taxonomy S3.1_DADA2_Taxonomy_FP_T1_99.5_99all.qza \
  #--m-metadata-file mapping.txt \
  --o-visualization S4.1_DADA2_taxa_barplot_FP_T1_99.5_99all.tsv








# DNA-BSAM PIPELINE
python DNA-BSAM-QIIME2.py \
--input /home/fpi10kg/SMP_2024/raw_reads/Zipped \
--output /home/fpi10kg/SMP_2024/matias/DNA-BSAM/TRIAL1_FP  \
--q2_classifier /home/fpi10kg/SMP_2024/pre_trained_classifiers/V2024.5/unite_ver10_99_s_all_04.04.2024-Q2-2024.5.qza \
--amplicon ITS \
--primer_file primers1.tsv \
--cutadapt_times 2 \
--filter_m_ie exclude \
--filter_list mitochondria,chloroplast,archaea \
--classify_threads 60 \
--classify_conf 0.8 \



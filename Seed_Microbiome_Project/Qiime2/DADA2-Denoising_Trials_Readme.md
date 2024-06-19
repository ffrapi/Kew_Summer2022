This document contains information on the different trials used to denoise my gymnosperm and angiosperm data using DADA2 in Qiime2 (https://qiime2.org/)

## 3. Denoising using DADA2 plugin 

**Source**: https://docs.qiime2.org/2024.5/plugins/available/dada2/denoise-paired/ <br>

DADA2 is a pipeline for detecting and correcting Illumina amplicon sequence data. <br>

#### Trial 1: 
    qiime dada2 denoise-paired \
      --i-demultiplexed-seqs SMP_demux-paired-end_cutadapt_FP.qza \
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
          --i-demultiplexed-seqs SMP_demux-paired-end_cutadapt_FP.qza \
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


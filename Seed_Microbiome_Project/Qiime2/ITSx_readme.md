### Installing + verify 

    conda install bioconda::itsx
    ITSx --version

## Example command: 

ITSx -i input.fasta -o output.fasta

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

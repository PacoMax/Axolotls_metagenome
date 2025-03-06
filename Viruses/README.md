# Viruses in skin microbiome metagenomes from neotenic axolotls
Scripts for processing and analyzing viruses in skin microbiome metagenomes from the neotenic axolotls.

## Step 1
Run ASSEMBLE.sh to assemble viral genomes and evaluate quality of genome assembles.

Programs used:
* PenguiN Version: 5.cf8933
* QUAST Version: 5.0.2

    `ASSEMBLE.sh`
## Step 2
Run VIR_DETECT.sh to detect viral genomes in assembled contigs and evaluate genome completeness and contamination.

Programs used:
* VIBRANT v1.2.1
* CheckV v0.9.0

    `VIR_DETECT.sh`

After running VIR_DETECT.sh we selected viral contigs with medium to high checkv quality, and four viral contigs predicted from MAGs with low quality but completeness > 25% and contamination = 0. To extract selected viral contigs run EXTRACT_VIR.sh:

Programs used:
* SeqKit Version: 2.9.0

    `EXTRACT_VIR.sh`
## Step 3
Run HOST_PRED.sh to predict hosts for viral metagenome-assembled genomes (vMAGs).

Programs used:
* SeqKit Version: 2.9.0
* iPHoP v1.1.0

     `HOST_PRED.sh`
## Step 4
Run ANNOTATE.sh to annotate vMAGs and prophages with pharokka.

Programs used:
* pharokka 1.3.0

     `ANNOTATE.sh`
## Step 5
Run CLASSIFY.sh to classify vMAGs and prophages with vcontact2.

Programs used:
* vConTACT2 0.11.3

     `CLASSIFY.sh`

After running CLASSIFY.sh output files c1_ntw.csv and genome_by_genome_overview.csv where used as input edge and node tables, respectively, for network visualization. 

Programs used:
* Cytoscape 3.10.3

## Step 6
First, we downloaded Pfam functional categories dataset from Jahn et al. (2019) Supplementary Data S1 (sheet: Auxiliary_genes_mapping (Fig 3)) https://doi.org/10.1016/j.chom.2019.08.019. Such table is available here as pfam2function.tsv. Then run FUNCTIONS1.sh to predict protein domains and assign them to specific functional categories.

Programs used:
* split_multi_fasta.py and get_pfam_functions.py. Available at https://github.com/AleCisMar/GenomicTools
* VirTaK. Available at https://github.com/AleCisMar/VirTaK

     `FUNCTIONS1.sh`

After running FUNCTIONS1.sh, download protein HMMs from:
* Anti-CRISPR-associated proteins https://github.com/boweny920/AcaFinder/tree/main/HMM/AcaHMMs
* Antibiotic resistance genes http://dantaslab.wustl.edu/resfams/Resfams-full.hmm.gz

Unpack if necessary and prepare the profile databases for hmmscan:
`hmmpress AcaHMMs.hmm`

*  HMMER 3.3.2
* virsorter version 2.2.3
* DRAM v1.5.0

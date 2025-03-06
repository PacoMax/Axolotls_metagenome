# Viruses in skin microbiome metagenomes from neotenic axolotls
Scripts for processing and analyzing viruses in skin microbiome metagenomes from the neotenic axolotls

## Step 1
Run ASSEMBLE.sh to assemble viral genomes and evaluate quality of genome assembles.

Programs used:
* PenguiN Version: 5.cf8933
* QUAST Version: 5.0.2

    `ASSEMBLE.sh`
## Step 2
Run VIR_DETECT.sh to detect viral genomes in assembled contigs and evaluate genome completeness and contamination

Programs used:
* VIBRANT v1.2.1
* CheckV v0.9.0

    `VIR_DETECT.sh`

# Axolotls_metagenome
Scripts for processing and analyzing skin microbiome metagenomes from axolotls

## Step 1
Run QC.sh for filtering poor-quality reads and deleting adapters.

Programs used:
* trim galore version 6.7

    `QC.sh`

## Step 2
Run MAP.sh for filtering reads from the host (axolotl) and human.

Programs used:
* bwa version 7.17-r1188

    `MAP.sh`

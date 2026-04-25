# Axolotls_metagenome
Scripts for processing and analyzing skin microbiome metagenomes from the neotenic axolotls

## Step 1
Run QC.sh to filter poor-quality reads and delete adapters.

Programs used:
* trim galore version 6.7

    `QC.sh`

## Step 2
Run MAP.sh to filter reads from the host (axolotl) and human.

Programs used:
* Bowtie2 version 2.3.4.1

    `MAP.sh`

## Step 3

Run KAJU.sh to annotate the filter reads.

Programs used:
* Kaiju version 1.7.2

    `KAJU.sh`


## Step 4
Run MASA.sh to obtain meta-assemblies

Programs used:
* Megahit version 1.2.9

    `MASA.sh`

## Step 5
Run BING.sh to obtain the bacterial MAGs

Programs used:
* MetaWRAP pipeline version 0.7
* maxbin2 version 2
* metabat2 version 2.18
* concoct version 1.1.0

    `BING.sh`

## Step 6
Run MAG_anot.sh to obtain bacterial MAG annotations

Programs used:
* BUSCO version 5.1.2
* GTDB-Tk version 2.1.1
* dbCAN (run_dbcan) version 3
* antiSMASH version 7
* eggNOGmapper version 2.1.13

    `MAG_anot.sh`

#!/bin/bash

#######################################################################
####################   MAG functional annotation   ####################
#######################################################################

mkdir -p MAGs_busco MAGs_bt_tax MAGs_bt_caz MAGs_bt_anti MAGs_bt_egg MAGs_pro

#########################
# GTDB-Tk taxonomy
# Run once for all MAGs
#########################

gtdbtk classify_wf \
--genome_dir MAGs_bt \
--out_dir MAGs_bt_tax \
--extension fa \
--cpus 20

#########################
# Process each MAG
#########################

for i in MAGs_bt/*.fa
do
    [ -e "$i" ] || continue

    file=$(basename "$i")
    name="${file%.fa}"

    echo "Processing MAG: $name"

    #########################
    # BUSCO completeness
    #########################

    busco \
    -i "$i" \
    -o "MAGs_busco/${name}_busco" \
    -m genome \
    --auto-lineage-prok

    #########################
    # CAZyme annotation
    #########################

    run_dbcan "$i" prok \
    --hmm_cpu 20 \
    --eCAMI_jobs 20 \
    --dia_cpu 20 \
    --tf_cpu 20 \
    --db_dir /home/fgonzale/fgonzale/db \
    --out_dir "MAGs_bt_caz/${name}.can"

    #########################
    # Biosynthetic clusters
    #########################

    antismash \
    -c 20 \
    --cb-general \
    --cc-mibig \
    --cb-knownclusters \
    --rre \
    --asf \
    --pfam2go \
    --smcog-trees \
    --genefinding-tool prodigal \
    --output-dir "MAGs_bt_anti/${name}_antismash" \
    "$i"


    #########################
    # eggNOG mapper
    #########################

    prodigal -p meta \
    -i "$i" \
    -o MAGs_pro/"${i%.fasta}"_position.gff \
    -a MAGs_pro/"${i%.fasta}"_cds.faa  \
    -d MAGs_pro/"${i%.fasta}"_ncl.fa

    emapper.py \
    --cpu 30 \
    -m diamond \
    --itype CDS \
    --translate \
    --evalue 0.00001 \
    -i MAGs_bt_pro/"${i%.fasta}"_ncl.fasta \
    -o MAGs_bt_egg/"${i%.fasta}"_egg \
    --decorate_gff yes \
    --excel \
    --report_orthologs \
    --data_dir /data6/bases/eggnogdb

done

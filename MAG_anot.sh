#!/bin/bash

#######################################################################
####################   MAG functional annotation   ####################
#######################################################################

mkdir -p MAGs_busco MAGs_bt_tax MAGs_bt_caz MAGs_bt_anti

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

done

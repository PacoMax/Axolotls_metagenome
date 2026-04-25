#!/bin/bash

#######################################################################
####################   Annotate reads with Kaiju   ####################
#######################################################################


# Download Kaiju database

mkdir -p Kaiu_db
cd Kaiu_db

wget https://kaiju-idx.s3.eu-central-1.amazonaws.com/2023/kaiju_db_nr_euk_2023-05-10.tgz
tar -xvzf kaiju_db_nr_euk_2023-05-10.tgz

cd ..

# Process sample folders

for folder in AA AD AM AT
do
    echo "Processing folder: $folder"

    cd "$folder" || continue

    mkdir -p "kaiju_${folder,,}"

    # Process paired reads

    for r1 in MAP/*_human_unmap.1.fastq
    do
        [ -e "$r1" ] || continue

        i=$(basename "$r1" _human_unmap.1.fastq)

        echo "Sample: $i"

        # Taxonomic assignment
        
        kaiju \
        -t ../Kaiu_db/nodes.dmp \
        -f ../Kaiu_db/kaiju_db_nr_euk.fmi \
        -a greedy \
        -e 5 \
        -m 11 \
        -s 75 \
        -E 0.01 \
        -x \
        -v \
        -i MAP/${i}_human_unmap.1.fastq \
        -j MAP/${i}_human_unmap.2.fastq \
        -o kaiju_${folder,,}/${i}_kaiju.out

        # Create Krona input

        kaiju2krona \
        -t ../Kaiu_db/nodes.dmp \
        -n ../Kaiu_db/names.dmp \
        -i kaiju_${folder,,}/${i}_kaiju.out \
        -o kaiju_${folder,,}/${i}_kaiju.krona

        # Generate Krona plot

        ktImportText \
        -o kaiju_${folder,,}/${i}_kaiju.html \
        kaiju_${folder,,}/${i}_kaiju.krona

        # Add taxonomy names

        kaiju-addTaxonNames \
        -t ../Kaiu_db/nodes.dmp \
        -n ../Kaiu_db/names.dmp \
        -i kaiju_${folder,,}/${i}_kaiju.out \
        -o kaiju_${folder,,}/${i}_kaiju_names.out

        # Summary table

        kaiju2table \
        -t ../Kaiu_db/nodes.dmp \
        -n ../Kaiu_db/names.dmp \
        -r class \
        -e \
        -p \
        -o kaiju_${folder,,}/${i}_class_summary.tsv \
        kaiju_${folder,,}/${i}_kaiju.out

    done

    cd ..
done

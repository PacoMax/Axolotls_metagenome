#######################################################################
####################### Classify viral contigs ########################
################ classify viral contigs with vConTACT2 ################
#######################################################################
# Used after annotating viruses with ANNOTATE.sh

mkdir vcontact2

# Prepare input files for vcontact2
awk -F' ' '
    BEGIN { OFS = ","; print "protein_id,contig_id,keywords" }
    /^>/ {
        gsub(">", "")
        genes = $1; gsub(/_CDS_0{1,3}/, "-gene_", genes)
        genomes = $1; sub(/_CDS_.*/, "", genomes)
        functions = substr($0, index($0, $2))
        print genes, genomes, functions
    }
' genomes/pharokka/phanotate.faa > vcontact2/gene-to-genome.csv

sed -E 's/_CDS_0{1,3}/-gene_/' genomes/pharokka/phanotate.faa > vcontact2/proteins.faa

# execute vcontact2
cd vcontact2
mkdir results

conda activate vcontact2

vcontact2 -r proteins.faa -p gene-to-genome.csv -o results

conda deactivate

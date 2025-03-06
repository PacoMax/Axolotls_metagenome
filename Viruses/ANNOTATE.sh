#######################################################################
####################### Annotate viral contigs ########################
################ annotate viral genomes with Pharokka #################
#######################################################################
# Used after detecting viruses with VIR_DETECT.sh

cd genomes
mkdir pharokka

conda activate pharokka

pharokka.py -i all_genomes.fna -o pharokka -t 20 -f -m

conda deactivate

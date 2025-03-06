#######################################################################
################## Get functions based on pfam domains ################
############# Read comments on the script before executing ############
#######################################################################
# Used after FUNCTIONS1.sh

cd virtak/panphylo

# Since several domains were classified as unknown or other, or even not found in the Pfam functional categories dataset, we downloaded protein HMMs for: 
#   Anti-CRISPR-associated proteins https://github.com/boweny920/AcaFinder/tree/main/HMM/AcaHMMs
#   Antibiotic resistance genes http://dantaslab.wustl.edu/resfams/Resfams-full.hmm.gz
# Then we searched our protein sequences against both HMMs with hmmscan

conda activate hmmer

# hmmpress AcaHMMs.hmm
# hmmpress Resfams-full.hmm

hmmscan --tblout aca_neotenic.tblout --noali -E 1e-05 --cpu 20 AcaHMMs.hmm ../../genomes/pharokka/phanotate.faa
hmmscan --tblout resfams_neotenic.tblout --noali -E 1e-05 --cpu 20 Resfams-full.hmm ../../genomes/pharokka/phanotate.faa

conda deactivate

# The unique query_name(s) were obtained from the hmmscan output tables and mapped against the pfam_scan.pl output files (created during the VirTaK process) to obtain the name of the domains present in the proteins with significant matches in the hmm databases.
for i in $(grep -v '#' aca_neotenic.tblout | sed 's/  */\t/g' | cut -f3 | sort -u) 
    do grep $i ../*.pfamscan
done | sed 's/  */\t/g' | cut -f7 | sort -u > aca_domains_neotenic.txt

for i in $(grep -v '#' aca_neotenic.tblout | sed 's/  */\t/g' | cut -f3 | sort -u) 
    do grep $i ../*.pfamscan
done | sed 's/  */\t/g' | cut -f7 | sort -u > resfams_domains_neotenic.txt

# To search for potential auxiliary metabolic genes (AMGs) we execeuted virsorter2 on genomes/all_genomes.fna to obtain the viral-affi-contigs-for-dramv.tab file. Then we executed DRAM-v annotate and distill sccripts. 
mkdir vs2

conda activate virsorter2

virsorter run -w vs2 -i ../../genomes/all_genomes.fna --include-groups dsDNAphage,RNA,ssDNA --keep-original-seq --prep-for-dramv --provirus-off

conda deactivate

mkdir dramv
mkdir dramv/distilled

conda activate DRAM1

DRAM-v.py annotate -i vs2/for-dramv/final-viral-combined-for-dramv.fa -v vs2/for-dramv/viral-affi-contigs-for-dramv.tab -o dramv --threads 20 --verbose
DRAM-v.py distill -i dramv/annotations.tsv -o dramv/distilled

conda deactivate

# AMG category was assigned to domains present in proteins with auxiliary score 1-3 with M flag (not V, A, P, B). Flags are defined in Shaffer et al. (2020) https://doi.org/10.1093/nar/gkaa621.
# AMG, Anti-CRISPR-associated and Antibiotic resistance-associated categories where added accordingly in the domain_info_with_function.tsv file.

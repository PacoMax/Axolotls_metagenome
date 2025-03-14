#######################################################################
################## Get functions based on pfam domains ################
############# Read comments on the script before executing ############
#######################################################################
# Used after annotating vMAGs with ANNOTATE.sh

mkdir virtak

# Split multi-fasta genomes and proteins
# https://github.com/AleCisMar/GenomicTools/blob/main/split_multi_fasta.py

split_multi_fasta.py -i genomes/all_genomes.fna -t nt -o virtak
split_multi_fasta.py -i genomes/pharokka/phanotate.faa -t aa -o virtak

# Execute VirTaK pipeline. https://github.com/AleCisMar/VirTaK
cd virtak
ls *.fna > list.txt

conda activate virtak

VirTaK.py -l list.txt -d ~/db/virtak_db/VMR_MSL38_v1_complete_genomes -p ~/db/virtak_db/ -o virtak_results.tsv
PanPhylo.py -l list.txt -d ~/db/virtak_db/VMR_MSL38_v1_complete_genomes -o panphylo
cd panphylo
get_domain_info.py domains.txt ~/db/virtak_db/Pfam-A.seed

conda deactivate

# Among several tasks performed by VirTaK.py, pfam_scan.pl is used to get domain annotations against Pfam-A database
# Among several tasks performed by PanPhylo.py, the script reads domain annotations generated by VirTaK.py and writes the full set of unique domains present in all genomes to a file named domains.txt
# it also creates a domain count per genome table named transposed_counts.txt which is later used for plotting a heatmap.
# get_domain_info.py extracts accessions, descriptions and comments from Pfam-A.seed for each domain (pfam_id) in domains.txt. It writes such information to a file named domain_info.tsv

# We downloaded Pfam functional categories dataset from Jahn et al. (2019) Supplementary Data S1 (sheet: Auxiliary_genes_mapping (Fig 3)).  https://doi.org/10.1016/j.chom.2019.08.019
# The functional categories were writen to a tab-delimited file named pfam2function.tsv
# A custom script was used to map our accessions in domain_info.tsv to the accession in pfam2function.tsv. https://github.com/AleCisMar/GenomicTools/blob/main/get_pfam_functions.py

get_pfam_functions.py -i domain_info.tsv -p ~/db/pfam2function.tsv -o domain_info_with_function.tsv

#######################################################################
########################## Virus detection ############################
######## detect viral genomes from assembled contigs and MAGs #########
#######################################################################
# Used after assembling with PENGUIN

# List of MAGs
# AA_bin_1_orig.fna
# AD_bin_1_orig.fna
# AD_bin_2_strict.fna
# AD_bin_3_permissive.fna
# AD_bin_4_permissive.fna
# AM_X1_bin_1_permissive.fna
# AM_X1_bin_2_permissive.fna
# AM_X1_bin_3_permissive.fna
# AM_X1_bin_4_strict.fna
# AM_X3_bin_1_permissive.fna
# AM_X3_bin_2_permissive.fna
# AM_X3_bin_3_strict.fna
# AM_X3_bin_4_strict.fna
# AM_X3_bin_5_orig.fna
# AM_X4_bin_1_strict.fna
# AM_X4_bin_2_strict.fna
# AM_X4_bin_3_strict.fna
# AM_X4_bin_4_strict.fna
# AM_X4_bin_5_orig.fna
# AM_X4_bin_6_strict.fna
# AM_X4_bin_7_strict.fna
# AT_bin_1_permissive.fna

# List of PenguiN assemblies
# penguin_scaffolds_AA.fasta
# penguin_scaffolds_AD.fasta
# penguin_scaffolds_AM.fasta
# penguin_scaffolds_AT.fasta

mkdir vibrant

cat *.fna *.fasta > vibrant/data.fasta

cd vibrant

conda activate vibrant

VIBRANT_run.py -i data.fasta -t 20

conda deactivate

mkdir checkv

checkv end_to_end VIBRANT_data/VIBRANT_phages_data/data.phages_combined.fna checkv

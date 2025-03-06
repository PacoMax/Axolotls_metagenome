#######################################################################
################### Extract selected viral contigs ####################
########### extract sequences from checkv outout fna files ############
#######################################################################
# Used after detecting viruses with VIR_DETECT.sh

# The following list was written to a file named list.txt
# k141_135924_AM_X3_bin_5_orig
# k141_274931_AM_X3_bin_5_orig_fragment_1
# N_13867_len_8452_cycle_0
# N_16293_len_28863_cycle_0
# N_19721_len_20494_cycle_0
# N_20041_len_5750_cycle_0
# N_28022_len_19338_cycle_0
# N_28103_len_38393_cycle_1
# N_3_len_7569_cycle_0
# N_33012_len_6679_cycle_0
# N_33136_len_5615_cycle_0
# N_39617_len_27357_cycle_0
# N_42827_len_9992_cycle_0
# N_47847_len_3980_cycle_0
# N_52381_len_15490_cycle_0
# N_71313_len_8431_cycle_0
# N_8053_len_9432_cycle_1
# N_8296_len_5415_cycle_0
# N_85270_len_9569_cycle_0
# N_9769_len_5672_cycle_0
# NODE_1_length_26585_cov_5.614735_AM_X3_bin_2_permissive
# NODE_29_length_35341_cov_10.260577_AM_X1_bin_4_strict
# NODE_3_length_14900_cov_4.022195_AM_X3_bin_1_permissive
# NODE_64_length_14526_cov_6.215171_AM_X3_bin_3_strict

mkdir genomes

seqkit grep -f list.txt vibrant/checkv/viruses.fna -o genomes/all_genomes.fna

# Then, all headers from de novo assembled vMAGs where complemented with the abreviation of the animal host from which the metagenome was generated:
# k141_135924_AM_X3_bin_5_orig
# k141_274931_AM_X3_bin_5_orig_fragment_1
# N_13867_len_8452_cycle_0_AM
# N_16293_len_28863_cycle_0_AM
# N_19721_len_20494_cycle_0_AM
# N_20041_len_5750_cycle_0_AM
# N_28022_len_19338_cycle_0_AM
# N_28103_len_38393_cycle_1_AM
# N_3_len_7569_cycle_0_AT
# N_33012_len_6679_cycle_0_AM
# N_33136_len_5615_cycle_0_AM
# N_39617_len_27357_cycle_0_AM
# N_42827_len_9992_cycle_0_AM
# N_47847_len_3980_cycle_0_AM
# N_52381_len_15490_cycle_0_AM
# N_71313_len_8431_cycle_0_AM
# N_8053_len_9432_cycle_1_AM
# N_8296_len_5415_cycle_0_AD
# N_85270_len_9569_cycle_0_AM
# N_9769_len_5672_cycle_0_AM
# NODE_1_length_26585_cov_5.614735_AM_X3_bin_2_permissive
# NODE_29_length_35341_cov_10.260577_AM_X1_bin_4_strict
# NODE_3_length_14900_cov_4.022195_AM_X3_bin_1_permissive
# NODE_64_length_14526_cov_6.215171_AM_X3_bin_3_strict

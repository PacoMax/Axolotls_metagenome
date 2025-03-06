#######################################################################
###################     Host prediction         #######################
###################### Predict hosts with iPHoP #######################
#######################################################################
# Used after viral contigs detection and quality assesement
# Host prediction was performed only for viral contigs assembled de novo from metagenomes

# The following list was written to a file named list_mvcs.txt
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

mkdir iphop

seqkit grep -f list_mvcs.txt genomes/all_genomes.fna -o iphop/mvcs.fna

# Then, execute iphop
cd iphop
mkdir results

conda activate iphop

iphop predict -f mvcs.fna -o results -t 20 -d /space40/data/iphop/Sept_2021_pub # -d /path/to/iphop/data/base

conda deactivate

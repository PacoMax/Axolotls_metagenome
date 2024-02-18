#######################################################
#################     Binning         #################
###### getting bins from metagenomes assembled ########
#######################################################
#Using it after the assembly of the metagenomes

#In case the architecture of the server or cluster is in another language
export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8

conda activate metawrap

#folder for bins
mkdir INBIN_am
#folder for refined bins
mkdir REBIN_am

for i in $(ls MAP | grep "M" |cut -d'_' -f1 | sort | uniq)
do

#Getting bins
#using metabat2

metawrap binning --universal \
-t 30 \
-m 100 \
-o INBIN_am/${i}_inbin \
-a megahit_am/${i}_megahit/final.contigs.fa \
--metabat2 \
MAP/${i}_human_unmap_1.fastq \
MAP/${i}_human_unmap_2.fastq


#using maxbin2

metawrap binning --universal \
-t 30 \
-m 100 \
-o INBIN_am/${i}_inbin \
-a megahit_am/${i}_megahit/final.contigs.fa \
--maxbin2 \
MAP/${i}_human_unmap_1.fastq \
MAP/${i}_human_unmap_2.fastq



#using concoct

metawrap binning --universal \
-t 30 \
-m 100 \
-o INBIN_am/${i}_inbin \
-a megahit_am/${i}_megahit/final.contigs.fa \
--concoct \
MAP/${i}_human_unmap_1.fastq \
MAP/${i}_human_unmap_2.fastq


#Doing bin refining

metawrap bin_refinement \
-o REBIN_am/${i}_rebin \
-t 30 \
-m 100 \
-A INBIN_am/${i}_inbin/metabat2_bins/ \
-B INBIN_am/${i}_inbin/maxbin2_bins/ \
-C INBIN_am/${i}_inbin/concoct_bins/ \
-c 50 \
-x 10

done










#######################################################
#################     Binning         #################
###### getting bins from metagenomes assembled ########
#######################################################
#Using it after the assembly of the metagenomes

#In case the architecture of the server or cluster is in another language
export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8

conda activate metawrap

mkdir INBIN_am


for i in $(ls MAP | grep "M" |cut -d'_' -f1 | sort | uniq)
do


#metabat2

metawrap binning --universal \
-t 30 \
-m 100 \
-o INBIN_am/${i}_inbin \
-a megahit_am/${i}_megahit/final.contigs.fa \
--metabat2 \
MAP/${i}_human_unmap_1.fastq \
MAP/${i}_human_unmap_2.fastq


#maxbin2

metawrap binning --universal \
-t 30 \
-m 100 \
-o INBIN_am/${i}_inbin \
-a megahit_am/${i}_megahit/final.contigs.fa \
--maxbin2 \
MAP/${i}_human_unmap_1.fastq \
MAP/${i}_human_unmap_2.fastq



#concoct

metawrap binning --universal \
-t 30 \
-m 100 \
-o INBIN_am/${i}_inbin \
-a megahit_am/${i}_megahit/final.contigs.fa \
--concoct \
MAP/${i}_human_unmap_1.fastq \
MAP/${i}_human_unmap_2.fastq



done

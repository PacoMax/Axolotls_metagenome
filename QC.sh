########################################################
###########     Quality filter         #################
##### removing adapters and poor quality reads (>20) ###
########################################################
#Using it after downloading the data in the folder data_am
tree data_am
#output should looks:
#data_am/
#|-- M-X1M01
#|   |-- M-X1M01_1.fq.gz
#|   |-- M-X1M01_2.fq.gz

#Create a directory where the quality filtered reeds will be kept
mkdir QR

#In case the architecture of the server or cluster is in another language 
export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8

#Cicle for proccesing all data at once
for i in $(ls data_am/ | grep -v '\.')
do

#Using trim galore
trim_galore \
--fastqc \
--illumina \
--paired \
data_am/${i}/${i}_1.fq.gz \
data_am/${i}/${i}_2.fq.gz \
--length 75 \
-q 20 \
-o QR/${i}_trim
done

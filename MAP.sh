#######################################################################
#################     Mapping filter         ##########################
####### removing reads mapped against axolotl and human genomes #######
#######################################################################
#Using it after quality-filer the data in the folder data_am
tree QC
#QR/
#|-- M-X1M01_trim
#|   |-- M-X1M01_1.fq.gz_trimming_report.txt
#|   |-- M-X1M01_1_val_1.fq.gz
#|   |-- M-X1M01_1_val_1_fastqc.html
#|   |-- M-X1M01_1_val_1_fastqc.zip
#|   |-- M-X1M01_2.fq.gz_trimming_report.txt
#|   |-- M-X1M01_2_val_2.fq.gz
#|   |-- M-X1M01_2_val_2_fastqc.html
#|   `-- M-X1M01_2_val_2_fastqc.zip

#It is necessary to have the human and axolotl genome indexed using bwa
#inside the folder genomes_re
#genomes_ref/
#|-- GCA_002915635.3_AmbMex60DD_genomic.fna
#|-- GCA_002915635.3_AmbMex60DD_genomic.fna.amb
#|-- GCA_002915635.3_AmbMex60DD_genomic.fna.ann
#|-- GCA_002915635.3_AmbMex60DD_genomic.fna.bwt
#|-- GCA_002915635.3_AmbMex60DD_genomic.fna.pac
#|-- GCA_002915635.3_AmbMex60DD_genomic.fna.sa
#|-- GRCh38_latest_genomic.fna
#|-- GRCh38_latest_genomic.fna.amb
#|-- GRCh38_latest_genomic.fna.ann
#|-- GRCh38_latest_genomic.fna.bwt
#|-- GRCh38_latest_genomic.fna.pac
#|-- GRCh38_latest_genomic.fna.sa

##cd ref_genomes
#Axolotl
##bwa index GCA_002915635.3_AmbMex60DD_genomic.fna
#Human
##bwa index GRCh38_latest_genomic.fna
##cd ../

#Creating the directory where the mapped sequences were kept
mkdir MAP

#Files where stats of the results of mapping
#For host
echo "Stats file host" > MAP/Stats_host.txt
#For human
echo "Stats file human" > MAP/Stats_human.txt

#Cycle for mapping each sample
for i in $(ls data_am/ | grep -v '\.')
do
#Mapping against host
bwa mem -t 20 \
#reference genome
genomes_ref/GCA_002915635.3_AmbMex60DD_genomic.fna \
#reads quality-filtered inside QR folder from the previous run
QR/${i}_trim/${i}_1_val_1.fq.gz \
QR/${i}_trim/${i}_2_val_2.fq.gz \
> MAP/${i}_host_paired.bam


#Getting R1 & R2 unmapped
samtools view -u -f 12 -F 256 MAP/${i}_host_paired.bam > MAP/${i}_host_unmap_unmap.bam
#Sorting
samtools sort -n  MAP/${i}_host_unmap_unmap.bam -o MAP/${i}_host_unmap_unmap.sort
#Extracing the flagstats
echo "$i" >> MAP/Stats_host.txt
samtools flagstat MAP/${i}_host_unmap_unmap.sort  >> MAP/Stats_host.txt
#Getting the R1 & R2 in fastq format
bamToFastq -i MAP/${i}_host_unmap_unmap.sort -fq MAP/${i}_host_unmap.1.fastq -fq2 MAP/${i}_host_unmap.2.fastq

#Deleting temporary files for memory optimization
rm MAP/${i}_host_unmap_unmap.bam
rm MAP/${i}_host_unmap_unmap.sort

#Now mapping against human genome
bwa mem -t 20 \
genomes_ref/GRCh38_latest_genomic.fna \
MAP/${i}_host_unmap.1.fastq \
MAP/${i}_host_unmap.2.fastq \
> MAP/${i}_human_paired.bam


# R1 & R2 unmapped
samtools view -u -f 12 -F 256 MAP/${i}_human_paired.bam > MAP/${i}_human_unmap_unmap.bam
#Sort
samtools sort -n  MAP/${i}_human_unmap_unmap.bam -o MAP/${i}_human_unmap_unmap.sort
#Flagstat
echo "$i" >> MAP/Stats_human.txt
samtools flagstat MAP/${i}_human_unmap_unmap.sort >> MAP/Stats_human.txt
#get R1 & R2
bamToFastq -i MAP/${i}_human_unmap_unmap.sort -fq MAP/${i}_human_unmap_1.fastq -fq2 MAP/${i}_human_unmap_2.fastq


rm MAP/${i}_human_unmap_unmap.bam
rm MAP/${i}_human_unmap_unmap.sort


done

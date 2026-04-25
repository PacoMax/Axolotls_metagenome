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


#Creating the directory where the mapped sequences were kept

#######################################################################
###################   Host read removal pipeline   ####################
#######################################################################

for j in AA AD AM AT
do

mkdir MAP

#########################
# Process each sample
#########################

for i in $(ls ${j}/QR | sed 's/_trim//')
do

#######################################################################
######################   Remove axolotl reads   #######################
#######################################################################

#########################
# Map to axolotl genome
#########################

bowtie2 --sensitive --dovetail \
-p 20 \
-x genomes_ref/AXO \
-1 ${j}/QR/${i}_trim/${i}_1_val_1.fq.gz \
-2 ${j}/QR/${i}_trim/${i}_2_val_2.fq.gz \
-S ${j}/MAP/${i}_AX_paired_bo.sam

#########################
# Convert SAM to BAM
#########################

samtools view -bS \
${j}/MAP/${i}_AX_paired_bo.sam \
> ${j}/MAP/${i}_AX_paired_bo.bam

#########################
# Keep unmapped pairs
#########################

samtools view -u -f 12 -F 256 \
${j}/MAP/${i}_AX_paired_bo.bam \
> ${j}/MAP/${i}_AX_unmap_unmap_bo.bam

#########################
# Sort by read name
#########################

samtools sort -n \
${j}/MAP/${i}_AX_unmap_unmap_bo.bam \
-o ${j}/MAP/${i}_AX_unmap_unmap_bo.sort

#########################
# Save statistics
#########################

echo "$i" >> ${j}/MAP/Stats_AX_bo.txt
samtools flagstat \
${j}/MAP/${i}_AX_unmap_unmap_bo.sort \
>> ${j}/MAP/Stats_AX_bo.txt

#########################
# Recover FASTQ pairs
#########################

bamToFastq \
-i ${j}/MAP/${i}_AX_unmap_unmap_bo.sort \
-fq ${j}/MAP/${i}_AX_unmap_bo.1.fastq \
-fq2 ${j}/MAP/${i}_AX_unmap_bo.2.fastq

#########################
# Remove temp files
#########################

rm ${j}/MAP/${i}_AX_paired_bo.bam
rm ${j}/MAP/${i}_AX_unmap_unmap_bo.bam
rm ${j}/MAP/${i}_AX_unmap_unmap_bo.sort

#######################################################################
#######################   Remove human reads   ########################
#######################################################################

#########################
# Map to human genome
#########################

bowtie2 --sensitive --dovetail \
-p 20 \
-x genomes_ref/HU \
-1 ${j}/MAP/${i}_AX_unmap_bo.1.fastq \
-2 ${j}/MAP/${i}_AX_unmap_bo.2.fastq \
-S ${j}/MAP/${i}_HU_paired_bo.sam

#########################
# Convert SAM to BAM
#########################

samtools view -bS \
${j}/MAP/${i}_HU_paired_bo.sam \
> ${j}/MAP/${i}_HU_paired_bo.bam

#########################
# Keep unmapped pairs
#########################

samtools view -u -f 12 -F 256 \
${j}/MAP/${i}_HU_paired_bo.bam \
> ${j}/MAP/${i}_HU_unmap_unmap_bo.bam

#########################
# Sort by read name
#########################

samtools sort -n \
${j}/MAP/${i}_HU_unmap_unmap_bo.bam \
-o ${j}/MAP/${i}_HU_unmap_unmap_bo.sort

#########################
# Save statistics
#########################

echo "$i" >> ${j}/MAP/Stats_HU_bo.txt
samtools flagstat \
${j}/MAP/${i}_HU_unmap_unmap_bo.sort \
>> ${j}/MAP/Stats_HU_bo.txt

#########################
# Recover FASTQ pairs
#########################

bamToFastq \
-i ${j}/MAP/${i}_HU_unmap_unmap_bo.sort \
-fq ${j}/MAP/${i}_HU_unmap_bo.1.fastq \
-fq2 ${j}/MAP/${i}_HU_unmap_bo.2.fastq

#########################
# Remove temp files
#########################

rm ${j}/MAP/${i}_HU_paired_bo.bam
rm ${j}/MAP/${i}_HU_unmap_unmap_bo.bam
rm ${j}/MAP/${i}_HU_unmap_unmap_bo.sort

done
done

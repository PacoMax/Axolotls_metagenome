#######################################################################
####################     Coassembles         ##########################
###### assemble viral genomes from concatenated paired-end reads ######
#######################################################################
# Used after quality filter and read mapping against axolotl and human genomes

mkdir coassembles

# Merge forward and reverse reads
cat M-AnZa*1.fastq > coassembles/AA_1.fastq
cat M-AnZa*2.fastq > coassembles/AA_2.fastq

cat M-DuPa*1.fastq > coassembles/AD_1.fastq
cat M-DuPa*2.fastq > coassembles/AD_2.fastq

cat M-X*1.fastq > coassembles/AM_1.fastq
cat M-X*2.fastq > coassembles/AM_2.fastq

cat M-TaAl*1.fastq > coassembles/AT_1.fastq
cat M-TaAl*2.fastq > coassembles/AT_2.fastq

cd coassembles

# List all *_1.fastq files, remove suffix, and prepare pairs
ls *_1.fastq | sed 's/_1.fastq//' > sample_names.txt

# Assemble with PenguiN
conda activate plass

while read sample; do
    file1="${sample}_1.fastq"
    file2="${sample}_2.fastq"
    
    penguin guided_nuclassemble "$file1" "$file2" "penguin_scaffolds_${sample}.fasta" tmp

done < sample_names.txt

conda deactivate

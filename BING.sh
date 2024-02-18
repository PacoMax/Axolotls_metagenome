

mkdir INBIN_am
for i in $(ls MAP | grep "M" |cut -d'_' -f1 | sort | uniq)
do
metawrap binning --universal -t 30 -m 100 -o INBIN_am/${i}_inbin -a megahit_am/${i}_megahit/final.contigs.fa --metabat2 --metabat --maxbin2 --concoct MAP/${i}_human_unmap.*.fastq
done

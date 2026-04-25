#######################################################################
#################     Metagenome assembly         #####################
####### assembly the metagenomes per specie or mesocosm ###############
#######################################################################

#It is necessary to have the reads without human and axolotl host contamination

#A. andersoni

cd AA

megahit -t 10 --presets meta-sensitive \
-1 $(ls MAP/M*_HU_unmap_bo.1.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-2 $(ls MAP/M*_HU_unmap_bo.2.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-o megahit_aa/M-AA_megahit

cd ../

#A. dumerilii

cd AD

megahit -t 10 --presets meta-sensitive \
-1 $(ls MAP/M*_HU_unmap_bo.1.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-2 $(ls MAP/M*_HU_unmap_bo.2.fastq|sed -z 's/\n/,/g' | sed 's/,$//g') \
-o megahit_ad/M-AD_megahit

cd ../

#A. mexicanum (per mesocosm)

megahit -t 10 --presets meta-sensitive \
-1 $(ls MAP/M-X1*_HU_unmap_bo.1.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-2 $(ls MAP/M-X1*_HU_unmap_bo.2.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-o megahit_am/M-X1_megahit

megahit -t 10 --presets meta-sensitive \
-1 $(ls MAP/M-X3*_HU_unmap_bo.1.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-2 $(ls MAP/M-X3*_HU_unmap_bo.2.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-o megahit_am/M-X3_megahit

megahit -t 10 --presets meta-sensitive \
-1 $(ls MAP/M-X4*_HU_unmap_bo.1.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-2 $(ls MAP/M-X4*_HU_unmap_bo.2.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-o megahit_am/M-X4_megahit

cd ../

#A. taylori

cd AT

megahit -t 10 --presets meta-sensitive \
-1 $(ls MAP/M*_HU_unmap_bo.1.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-2 $(ls MAP/M*_HU_unmap_bo.2.fastq |sed -z 's/\n/,/g' | sed 's/,$//g') \
-o megahit_at/M-AT_megahit

cd ../

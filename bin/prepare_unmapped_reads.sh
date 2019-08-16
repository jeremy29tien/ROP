#!/bin/bash
#This shell script extracts unmapped reads from the PIVUS fastq files located under /srv/gsfs0/projects/montgomery/bballiu/PIVUS/DATA/RNAseq/FASTQ/ . 

if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Please use the '-s' flag to specify the PIVUS sample."
    exit 1
fi

while getopts ":s:" opt; do
  case ${opt} in
    s )
      sample=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
	exit 1
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument. Please provide the correct sample name (eg., 'PIVUS003')" 1>&2
	exit 1
      ;;
  esac
done
shift $((OPTIND -1))

#Genome index is located at '/srv/gsfs0/projects/montgomery/bballiu/PIVUS/DATA/RNAseq/STAR_INDEX_Overhang75'
#scp -r j29tien@crick.stanford.edu:/srv/gsfs0/projects/montgomery/bballiu/PIVUS/DATA/RNAseq/STAR_INDEX_Overhang75 /users/j29tien/ROP/data

#Copy over PIVUS .fastq files (before STAR alignment) to rerun STAR with --outSAMunmapped Within option (this keeps the unmapped reads in the output file
#scp j29tien@crick.stanford.edu:/srv/gsfs0/projects/montgomery/bballiu/PIVUS/DATA/RNAseq/FASTQ/${sample}_merge_R1.trimmed.fastq.gz /users/j29tien/ROP/data/fastq
#scp j29tien@crick.stanford.edu:/srv/gsfs0/projects/montgomery/bballiu/PIVUS/DATA/RNAseq/FASTQ/${sample}_merge_R2.trimmed.fastq.gz /users/j29tien/ROP/data/fastq
#scp j29tien@crick.stanford.edu:/srv/gsfs0/projects/montgomery/bballiu/PIVUS/DATA/RNAseq/FASTQ/\{${sample}_merge_R1.trimmed.fastq.gz,${sample}_merge_R2.trimmed.fastq.gz\} /users/j29tien/ROP/data/fastq
#scp your_username@remote.edu:/some/remote/directory/\{a,b,c\} ./


#Re-run STAR on PIVUS .fastq files in order to produce bam file with unmapped reads
genomeDir=/users/j29tien/ROP/data/STAR_INDEX_Overhang75/
cd /users/j29tien/ROP/data/STAR_Unmapped 
STAR-2.5.2b --runThreadN 4 \
 --genomeDir $genomeDir \
 --readFilesIn /users/j29tien/ROP/data/fastq/${sample}_merge_R1.trimmed.fastq.gz /users/j29tien/ROP/data/fastq/${sample}_merge_R2.trimmed.fastq.gz \
 --readFilesCommand zcat \
 --outFileNamePrefix ${sample}_ \
 --outSAMunmapped Within \
 --outSAMtype BAM Unsorted

#View file, -f 4 is flag that specifies unmapped reads. Make sure that file is not empty.
#samtools view -f 4  ${sample}_Aligned.out.bam | less -S

#Extract unmapped reads from file and save to new file. Convert that file to .fastq for ROP
# -b option specifies the file in .bam format (for bam2fq) and -h option ensures that the file has a proper header (to prevent complaints from samtools)
samtools view -f 4 -bh ${sample}_Aligned.out.bam | samtools bam2fq - >${sample}_Aligned.unmapped.out.fastq

#View created fastq file of unmapped reads as sanity check.
#less -S ${sample}_Aligned.unmapped.out.fastq 




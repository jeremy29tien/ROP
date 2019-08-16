#!/bin/bash
#This shell script copies a given range of PIVUS fastq files all at once. This is run before the rest of the ROP scripts are run in order to avoid typing in password multiple times.

#Copy over PIVUS .fastq files (before STAR alignment) to rerun STAR with --outSAMunmapped Within option (this keeps the unmapped reads in the output file
scp j29tien@crick.stanford.edu:/srv/gsfs0/projects/montgomery/bballiu/PIVUS/DATA/RNAseq/FASTQ/\{\*_merge_R1.trimmed.fastq.gz,\*_merge_R2.trimmed.fastq.gz\} /users/j29tien/ROP/data/fastq
#scp your_username@remote.edu:/some/remote/directory/\{a,b,c\} ./



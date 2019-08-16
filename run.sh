#!/bin/bash
#This script runs prepares unmapped reads from PIVUS fastq files and runs them through ROP. 

#Options: -all for running on all PIVUS, -sample for running on just one sample

if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Please use the '-s' flag to specify the PIVUS sample, or the '-a' flag to run on multiple samples."
    exit 1
fi

while getopts ":as:" opt; do
  case ${opt} in
    s )
      sample=$OPTARG
      ;;
    a )
      sample=""
      read -p 'Starting PIVUS sample in ROP run: ' sampleStart
      read -p 'Ending PIVUS sample in ROP run: ' sampleEnd      
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
        exit 1
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument." 1>&2
        exit 1
      ;;
  esac
done
shift $((OPTIND -1))

#running on multiple samples
if [ -z "$sample" ]; then

   startNumber=${sampleStart:5}
   #echo "$(($startNumber + 1))"
   endNumber=${sampleEnd:5}
   number=$startNumber
   while [ "$number" != $(printf %03d "$((10#$endNumber + 1))") ]
   do
     sampleName=$(printf PIVUS%03d "$((10#$number))")
#     if [ ${#number} -eq 1 ]
#     then	
#	sampleName=PIVUS00$number
#     fi
#     if [ ${#number} -eq 2 ]
#     then
#        sampleName=PIVUS0$number
#     fi
#     if [ ${#number} -eq 3 ]
#     then
#        sampleName=PIVUS$number
#     fi
     echo *-------------*
     echo ${sampleName}
     echo *-------------*
     /users/j29tien/ROP/bin/prepare_unmapped_reads.sh -s ${sampleName}
     /users/j29tien/ROP/bin/run-rop.sh -s ${sampleName}
     number=$(printf %03d "$((10#$number + 1))")
   done
else
	##For now, just use these to run one sample at a time.
	#place these commands in loop to loop through all PIVUS
	/users/j29tien/ROP/bin/prepare_unmapped_reads.sh -s ${sample}

	/users/j29tien/ROP/bin/run-rop.sh -s ${sample}
fi



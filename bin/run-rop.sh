#!/bin/bash
#This shell script runs ROP on a given PIVUS sample of unmapped reads (that exists) in the .fastq format.

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

/users/j29tien/ROP/rop/rop.sh  /users/j29tien/ROP/data/STAR_Unmapped/${sample}_Aligned.unmapped.out.fastq /users/j29tien/ROP/results/${sample}_ROP



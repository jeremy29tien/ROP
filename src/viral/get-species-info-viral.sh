#!/bin/bash
#This script will runi species-name-from-GB.py on all sequences from {sample}_Aligned--07c_viral_viproutput.bam in order to discover common viral species trends over age.

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

#Access {sample}_Aligned--07c_viral_viproutput.bam file 
echo "Getting reference sequence names and counts from ${sample}_Aligned--07c_viral_viproutput.bam ... "
samtools view /users/j29tien/ROP/results/${sample}_ROP/07c_viral/${sample}_Aligned--07c_viral_viproutput.bam | cut -f3 | sort | uniq -c | sort -k 1 -n -r > /users/j29tien/ROP/results/${sample}_ROP/07c_viral/RefSeqName.txt

#Extract GenBank ID from 3rd column
#Method for finding index of string
strindex() { 
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

#Input GenBank ID into species-name-from-GB.py (will need to make this able to take command line input)
echo "Fetching species name and taxonomy and writing to file ...  " 
input="/users/j29tien/ROP/results/${sample}_ROP/07c_viral/RefSeqName.txt"
echo -e  "Sequence Count\tSequence Name\tLOCUS\tACCESSION\tVERSION\tDEFINITION\tSOURCE\tORGANISM\tTAXONOMY" > /users/j29tien/ROP/results/${sample}_ROP/07c_viral/${sample}_viral-sequence-to-species.out.txt
while read line
do
if [ ${#line} -gt 10 ]
then
  startIndex=$(strindex "$line" "gb")
  endIndex=$(strindex "$line" "Strain")
  gbID=${line:$(($startIndex+3)):$(($endIndex-$startIndex-4))}
  arr=($line)
  #input into species-name-from-GB.py
  #write output to RefSeqName.txt
  #printf "%s\t%s\t%s" "${arr[0]}" "${arr[1]}" "$(python /users/j29tien/ROP/src/species-name-from-GB.py $gbID)" >> viral-sequence-to-species.out.txt
  echo -e "${arr[0]}\t${arr[1]}\t$(python /users/j29tien/ROP/src/viral/species-name-from-GB.py $gbID)" >> /users/j29tien/ROP/results/${sample}_ROP/07c_viral/${sample}_viral-sequence-to-species.out.txt
fi
done < "$input"

#output for all sequences for a sample, put in excel file
awk 'BEGIN{ FS="\t"; OFS="\t"; print "Sequence Count\tSequence Name\tLOCUS\tACCESSION\tVERSION\tDEFINITION\tSOURCE\tORGANISM\tTAXONOMY"}; NR > 1{print $1, $2, $3, $4, $5, $6, $7, $8, $9;}' /users/j29tien/ROP/results/${sample}_ROP/07c_viral/${sample}_viral-sequence-to-species.out.txt > /users/j29tien/ROP/results/${sample}_ROP/07c_viral/${sample}_viral-sequence-to-species.out.tsv






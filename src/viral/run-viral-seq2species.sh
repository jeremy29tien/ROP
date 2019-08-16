#!/bin/bash

sample=""
read -p 'Starting PIVUS sample in run: ' sampleStart
read -p 'Ending PIVUS sample in run (not included in run): ' sampleEnd

sample=$sampleStart
while [ "$sample" != $sampleEnd ]
   do
     echo *-------------*
     echo ${sample}
     echo *-------------*
     /users/j29tien/ROP/src/viral/get-species-info-viral.sh -s $sample
     number=${sample:5}
     number=$(printf %03d "$((10#$number + 1))")
     sample=$(printf PIVUS%03d "$((10#$number))")
done





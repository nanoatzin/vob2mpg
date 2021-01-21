#!/bin/bash
# US copyright law only permits 2 copies without permission of the owner
# This script bulk converts vob files to mpg from one or more DVD on Linux systems
# Mount DVD and copy files from each disk into individual directories 
# Copy this file into the directory that holds the directories containing the DVD copies
# Make executable 
#   chmod +x vob2mpg.bash
# Check if ffmpeg is available with the following command  
#   which ffmpeg
# If not present, then install with the following command 
#   sudo apt install ffmpeg
# Run the conversion with the following command 
#   ./vob2mpg.bash
for d in *
do
  echo "$d" \n
  if cd "$d"; then   
    if [ ! -f $d.mpg ]; then
      rm *.mpg
      for e in VTS_*.VOB
      do
        f=${e%.*}
        ffmpeg -i $e -c:v copy -c:a copy -f dvd $f.mpg
      done
      cat VTS_*.VOB > $d.mpg
    fi
    cd ..
  fi  
done

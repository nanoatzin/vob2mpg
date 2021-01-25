#!/bin/bash
# US copyright law only permits "fair use" copies without permission of the owner 
# Fair use allows a copy for a video player that will be used instead of the DVD (computer) 
# This script bulk converts vob files to mpg from one or more DVD on Linux systems
# Mount DVD and make a directory with the name of the DVD that will hold the VOB files 
# Copy VOB files from the disk into the directories
# Repeate the previous 2 steps for each DVD
# Copy this file into the directory that holds the directories containing the DVD copies
# Make this file executable 
#   chmod +x vob2mpg.bash
# Check if ffmpeg is available with the following command  
#   which ffmpeg
# If not present, then install ffmpeg with the following command 
#   sudo apt install ffmpeg
# Run the file conversion with the following command 
#   ./vob2mpg.bash
# Output are in the directories with the VOB filesi, but with file prefix the same name as the directory 
# 
# Walk the directory 
for d in *
do
  # report current directory
  echo "$d" 
  # change to the next directory
  if cd "$d"; then
    # convert just the non-empty files `
    for e in VTS_0[1-9]_[1-9].VOB
    do
      # report current file 
      echo $e
      # set the output file name
      f=${e%.VOB}.mp4
      # convert vob to mp4
      ffmpeg -i $e -c:v libx264 -c:a aac -strict experimental $f
      # put the file name in the list to concatenate
      echo file ./$f >> filelist.txt
    done
    # concatenate all of the converted files
    ffmpeg -f concat -safe 0 -i filelist.txt -c copy $d.mp4
    # prepare to move to the next directory
    cd ..
  fi
done

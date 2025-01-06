#!/bin/bash

### name: rename_fastqs.sh
### usage: bash rename_fastqs.sh

# Directory containing the .fastq.gz files
directory=./inputs/absinta/fastq # change the input directory file path as needed
# we also ran this script for the schirmer fastq files
# directory=./inputs/schirmer/fastq

# Change to the target directory
cd "$directory" || { echo "Directory not found: $directory"; exit 1; }

# Iterate over the .fastq.gz files
for file in *.fastq.gz; do
  # Check if the file matches the pattern SRRXXXXXXX_1.fastq.gz or SRRXXXXXXX_2.fastq.gz
  if [[ $file =~ ^(SRR[0-9]+)_(1|2)\.fastq\.gz$ ]]; then
    # Extract the base name and the read number
    base="${BASH_REMATCH[1]}"
    read_num="${BASH_REMATCH[2]}"
    
    # Determine the new read number and file suffix
    if [ "$read_num" -eq 1 ]; then
      new_file="${base}_S1_R1_001.fastq.gz"
    elif [ "$read_num" -eq 2 ]; then
      new_file="${base}_S1_R2_001.fastq.gz"
    else
      # Skip files that do not match the expected pattern
      continue
    fi
    
    # Rename the file
    mv "$file" "$new_file"
    echo "Renamed $file to $new_file"
  fi
done

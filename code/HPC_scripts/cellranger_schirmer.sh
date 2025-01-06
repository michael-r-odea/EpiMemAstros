#!/bin/bash
#SBATCH --partition=cpu_medium # partition on which to run
#SBATCH --job-name=schirmer_cr_count # name
#SBATCH --mail-type=ALL #Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --ntasks=1 #Run on # of CPUs
#SBATCH --cpus-per-task=16
#SBATCH --mem=128gb #Job memory request ##max 128GB
#SBATCH --time=3-00:00:00 #Time limit hrs:min:sec
#SBATCH --output=./cellranger_count_%a.log #Standard output and error log
#SBATCH --no-kill
#SBATCH --array=0-20

cd ./inputs/schirmer/CellRanger

cat ../Schirmer_SraRunTable.txt | cut -d',' -f35 | uniq | grep -P '\S' > schirmer_samples.txt

mapfile -t samples < schirmer_samples.txt

sample_ids=$(grep ${samples[$SLURM_ARRAY_TASK_ID]} ../Schirmer_SraRunTable.txt | cut -d',' -f1 | tr '\n' ',' | sed 's/\(.*\),/\1 /')

# id		 name for output directory corresponding to sample
# fastqs         Path of folder created by 10x demultiplexing or bcl2fastq
# transcriptome  Path of folder containing 10X-compatible transcriptome

/.../CellRanger/cellranger-7.0.1/cellranger count \
--id "${samples[$SLURM_ARRAY_TASK_ID]}" \
--localmem 128 \
--localcores 16 \
--transcriptome=/.../CellRanger/references/refdata-gex-GRCh38-2024-A \
--fastqs ../fastq \
--include-introns=true \
--sample $sample_ids

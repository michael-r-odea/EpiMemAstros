#!/bin/bash
#SBATCH --partition=gpu4_short,gpu8_short,gpu4_medium,gpu8_medium # partition on which to run
#SBATCH --job-name=absinta_cellbender # name
#SBATCH --mail-type=ALL #Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --ntasks=1 #Run on # of CPUs
#SBATCH --mem=64G #Job memory request ##max 128GB
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00 #Time limit hrs:min:sec
#SBATCH --output=./cellbender_%a.log #Standard output and error log
#SBATCH --no-kill
#SBATCH --array=0-19

source /.../anaconda3/bin/activate cellbenderv3

cd ./inputs/absinta/CellRanger

mapfile -t samples < absinta_samples.txt

mkdir -p "../cellbender/""${samples[$SLURM_ARRAY_TASK_ID]}"
cd "../cellbender/""${samples[$SLURM_ARRAY_TASK_ID]}"

cellbender remove-background \
	--input "../../CellRanger/""${samples[$SLURM_ARRAY_TASK_ID]}""/outs/raw_feature_bc_matrix.h5" \
	--output "./""${samples[$SLURM_ARRAY_TASK_ID]}""_output.h5" \
	--cuda \
	--learning-rate 0.000005 \
	--fpr 0.05

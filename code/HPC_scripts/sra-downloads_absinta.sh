#!/bin/bash
#SBATCH --partition=cpu_long,fn_long # partition on which to run
#SBATCH --job-name=sra_absinta # name
#SBATCH --mail-type=ALL #Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=michael.odea@nyulangone.org #Where to send mail
#SBATCH --ntasks=6 #Run on # of CPUs
#SBATCH --mem-per-cpu=8gb #Job memory request ##max 128GB
#SBATCH --time=28-00:00:00 #Time limit hrs:min:sec
#SBATCH --output=./sra_downloads_%a.log #Standard output and error log
#SBATCH --no-kill
#SBATCH --array=0-37

source /.../anaconda3/bin/activate sra-downloads

cd ./inputs/absinta/fastq

mapfile -t samples < ../Absinta_SRR_Acc_List.txt # change the file path to this input file as needed

vdb-config --prefetch-to-cwd

prefetch --max-size u ${samples[$SLURM_ARRAY_TASK_ID]}

vdb-validate ${samples[$SLURM_ARRAY_TASK_ID]}

fasterq-dump -e 6 ${samples[$SLURM_ARRAY_TASK_ID]}

gzip "${samples[$SLURM_ARRAY_TASK_ID]}"_*".fastq"

# EpiMemAstros

Description pending.

## Requirements

- Installing the package dependencies will require a working installation of `mamba` or `conda` on your system. If you do not already have `mamba ` installed, we recommend [the Miniforge distribution.](https://github.com/conda-forge/miniforge)
- These notebooks require several input files, most of which will be downloaded from our [Zenodo repository](https://zenodo.org/records/14567478) in the Step 0b notebook.
- The Steps 1-4 and Step 9 notebooks make use of data from the [Allen Brain Cell atlas](). These data are downloaded in the Step 1 notebook and require approximately 300 GB of disk space. A large anndata object is created from this downloaded data in the Step 2 script, which requires an additional 300 GB disk space. This large anndata object will be used in Steps 3, 4, & 9. If you wish to avoid this large memory requirement, you may skip Steps 1-4 & Step 9 and can still run the remaining notebooks without issue.

# Optional:
- The Step 11 & Step 13 notebooks include optional code blocks formatted as raw text for (1) downloading FASTQ files from the NCBI Sequence Read Repository (SRA) using [sra-tools](https://github.com/ncbi/sra-tools), (2) running [Cell Ranger (10X Genomics)](https://www.10xgenomics.com/support/software/cell-ranger/latest), and (3) running [CellBender](https://github.com/broadinstitute/CellBender) ([Fleming et al 2023, PMID: 37550580](https://pubmed.ncbi.nlm.nih.gov/37550580/)) for the two human single-nucleus RNA-seq datasets from [Absinta et al 2021 (PMID: 34497421)](https://pubmed.ncbi.nlm.nih.gov/34497421/) and [Schirmer et al 2019 (PMID: 31316211)](https://pubmed.ncbi.nlm.nih.gov/31316211/). These code blocks are written for a Linux HPC system using the SLURM resource scheduler and are not executed in the notebooks but may be copied and run separately. Individual bash scripts containing code from these blocks are provided in the `code/HPC_scripts` directory. These scripts will require a Linux operating system, a working installation of [Cell Ranger (version 7.0.1)](https://www.10xgenomics.com/support/software/cell-ranger/latest/release-notes/cr-release-notes#v7-0-1), and a CUDA-capable GPU for CellBender. These scripts will need to be modified if using a job scheduler other than SLURM. The CellBender script may be modified to run on CPU alone if a GPU is not available ([see CellBender documentation for details](https://cellbender.readthedocs.io/en/latest/)).

## Installation

1. Clone the repository to your local computer.
2. Change directory into the cloned repository folder:

```sh
cd EpiMemAstros
```

4. Create a conda environment from the provided `environment.yml` file in the `code/environments` directory using `mamba` or  `conda`.
   
```sh
mamba env create --name EpiMemAstros -f code/environments/environment.yml
```

5. Two additional packages need to be installed using the Step 0a notebook. Change directory into the `code` folder and start Jupyter Lab.

```sh
cd code
jupyter lab
```

6. Run the Step 0a notebook to install the last few packages.
7. Then run the Step 0b notebook to download the input files from the [Zenodo repository](https://zenodo.org/records/14567478).

You're now all set to run the remaining notebooks in this repository!

# Optional:
- If you will be running the optional SRA downloads and CellBender code on your own Linux HPC system, you can create the respective conda environments for these steps:

```sh
mamba env create --name sra-downloads -f code/environments/sra-downloads.yml
mamba env create --name cellbenderv3 -f code/environments/cellbenderv3.yml
```

## Usage


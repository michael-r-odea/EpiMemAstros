# EpiMemAstros

This repository contains code for our reanalysis of data from [Lee et al 2024 (PMID: 38509377)](https://pubmed.ncbi.nlm.nih.gov/38509377/), which we present in annotated Jupyter notebook files containing both Python and R code.

## Requirements

- Installing the package dependencies will require a working installation of `mamba` or `conda` on your system. If you do not already have `mamba` installed, we recommend [the Miniforge distribution.](https://github.com/conda-forge/miniforge)
- These notebooks require several input files, most of which will be downloaded from our [Zenodo repository](https://zenodo.org/records/14567478) in the Step 0b notebook.
- Disk space & RAM: The Steps 1-4 and Step 9 notebooks make use of data from the Allen Brain Cell Atlas ([Yao et al 2023, PMID: 38092916](https://pubmed.ncbi.nlm.nih.gov/38092916/])). These data are downloaded in the Step 1 notebook and require approximately 300 GB of disk space. A large anndata object is created from this downloaded data in the Step 2 script, which requires an additional 300 GB disk space. This large anndata object will be used in Steps 3, 4, & 9. If you wish to avoid this large memory requirement, you may skip Steps 1-4 & and can still run the remaining notebooks without issue. (Step 9 can still be run but will be adjusted. See the notebook for details.) 

### Optional:
- The Step 11 & Step 13 notebooks include optional code blocks in markdown format for (1) downloading FASTQ files from the NCBI Sequence Read Repository (SRA) using [sra-tools](https://github.com/ncbi/sra-tools), (2) running [Cell Ranger (10X Genomics)](https://www.10xgenomics.com/support/software/cell-ranger/latest), and (3) running [CellBender](https://github.com/broadinstitute/CellBender) ([Fleming et al 2023, PMID: 37550580](https://pubmed.ncbi.nlm.nih.gov/37550580/)) for the two human single-nucleus RNA-seq datasets from [Absinta et al 2021 (PMID: 34497421)](https://pubmed.ncbi.nlm.nih.gov/34497421/) and [Schirmer et al 2019 (PMID: 31316211)](https://pubmed.ncbi.nlm.nih.gov/31316211/). These code blocks are written for a Linux HPC system using the SLURM resource scheduler and are not executed in the notebooks but may be copied and run separately. Individual bash scripts containing code from these blocks are provided in the `code/HPC_scripts` directory. These scripts will require a Linux operating system, a working installation of [Cell Ranger (version 7.0.1)](https://www.10xgenomics.com/support/software/cell-ranger/latest/release-notes/cr-release-notes#v7-0-1), and a CUDA-capable GPU for CellBender. These scripts will need to be modified if using a job scheduler other than SLURM. The CellBender script may be modified to run on CPU alone if a GPU is not available ([see CellBender documentation for details](https://cellbender.readthedocs.io/en/latest/)).

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

   Note: This conda environment was created for a Mac `osx-64` system. If using an alternative operating system/platform, you may need to relax some of the dependency versions in the `environment.yml` file.

5. Two additional packages need to be installed using the Step 0a notebook. Activate the conda environment, change directory into the `code` folder, and start Jupyter Lab.

   ```sh
   mamba activate EpiMemAstros
   cd code
   jupyter lab
   ```

6. Run the Step 0a notebook to install the last few packages.
7. Then run the Step 0b notebook to download the input files from the [Zenodo repository](https://zenodo.org/records/14567478).

You're now all set to run the remaining notebooks in this repository!

### Optional:
- If you will be running the optional SRA downloads and CellBender code on your own Linux HPC system, you can create the respective conda environments for these steps:

   ```sh
   mamba env create --name sra-downloads -f code/environments/sra-downloads.yml
   mamba env create --name cellbenderv3 -f code/environments/cellbenderv3.yml
   ```

## Usage

- Notebooks are organized into Groups, below. Notebooks within a given group must be run in numeric order as these notebooks will require inputs generated from each previous step within the group. 
- Step 0a and Step 0b (from notebook Group A) ***must*** be run before all other scripts to download additional R packages and input files. See the Installation section above for details.
- To run each notebook, activate the conda environment, change directory into the `code` folder, and start the Jupter Lab server:
  
   ```sh
   mamba activate EpiMemAstros
   cd code
   jupyter lab
   ```
   
- A web browser window will open with your Juptyer Lab interace, and you can select and run the notebook of your choosing.

### Notebook Groups

#### Group A: Dependency & input file downloads (\*MUST BE RUN FIRST\*)
- [**Step 0a: Install remaining R packages.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/0a_install_remaining_R_packages.ipynb?flush_cache=true) This notebook downloads two additional R packages which we could not obtain using conda due to dependency issues.
- [**Step 0b: Download input files from Zenodo.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/0b_download_input_files_from_zenodo.ipynb?flush_cache=true) This notebook downloads input files necessary for the all following notebooks from Zenodo.

#### Group B: Using the Allen Brain Cell Atlas to evaluate the epigenetic memory astrocyte gene signatures
- [**Step 1: Download Allen Brain Cell atlas data.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/1__download_abc_atlas.ipynb?flush_cache=true) This notebook downloads the whole mouse brain atlas 10X v2, v3, and multiome preprocessed .h5ad files and associated metadata from AWS using the [abc_atlas_access package](https://github.com/AllenInstitute/abc_atlas_access).
- [**Step 2: Create anndata object from Allen Brain Cell Atlas.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/2__create_abc_atlas_object.ipynb?flush_cache=true) This notebook generates a single AnnData object containing all cells from the whole mouse brain atlas with associated cell type/cluster metadata.
- [**Step 3: Evaluate expression of the epigenetic memory astrocyte gene signature across cell types in the Allen Brain Cell Atlas.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/3__score_abc_atlas_enrichment.ipynb?flush_cache=true) This notebook calculates and plots enrichment scores for single cells across major cell type classes present in the Allen Brain Cell Atlas for the epigenetic memory astrocyte gene signatures.
- [**Step 4: Evaluate expression of up- and down-signature genes in Allen Brain Cell atlas.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/4__plot_signatures_across_abc_atlas.ipynb?flush_cache=true) This notebook generates heatmaps showing expression of the genes in the epigenetic memory astrocyte up- and down-signatures across the major cell type classes in the Allen Brain Cell Atlas.

   Note: Group B notebooks require a significant amount of disk space and memory to run given the very large size of the Allen Brain Cell single-cell atlas. You can skip running this group of notebooks and all other notebook groups can still be run. If you choose to do this, you will need to skip Part 1 of the Step 9 notebook due to its use of the large AnnData object created by Step 2. See the Step 9 notebook for details.

#### Group C: Evaluate gene signature derivation and *Ep300* knockout RNA-seq data
- [**Step 5: Evaluate the derivation of the epigenetic memory astrocyte up- and down-signature gene sets.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/5__evaluate_signature_derivation.ipynb?flush_cache=true) This notebook examines how the epigenetic memory astrocyte up- and down-signature gene sets were derived from the two-hit versus one-hit cytokine stimulus RNA-seq experiment.
- [**Step 6: Evaluate Ep300 knockout differential expression test results.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/6__ep300_KOs.ipynb?flush_cache=true) This notebook examines the RNA-seq differential expression test results from the *Ep300* knockout experiments in comparison to the epigenetic memory astrocyte gene signatures.
- [**Step 7: Run preranked GSEA with Ep300 knockout differential expression test results**.](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/7__ep300_KOs_GSEA.ipynb?flush_cache=true) This notebook uses the [GSEApy python package](https://github.com/zqfang/GSEApy) to run pre-ranked gene set enrichment analysis to evaluate enrichment of the epigenetic memory astrocyte up- and down-signature gene sets in the *Ep300* knockout experiments.

#### Group D: Reanalysis of the mouse EAE single-cell RNA-seq data from [Wheeler et al 2020 (PMID: 32051591)](https://pubmed.ncbi.nlm.nih.gov/32051591/)
- [**Step 8: Reanalysis of mouse single-cell RNA-seq data from Wheeler et al.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/8__mouse_EAE_singlecell_analysis.ipynb?flush_cache=true) This notebook performs the majority of the reanalysis of the Wheeler et al single-cell data using a Seurat object provided to us by the authors of Lee et al 2024.
- [**Step 9: Create CellTypist model from Allen Brain Cell atlas data.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/9__create_abc_atlas_celltypist_model.ipynb?flush_cache=true) This notebook creates a reference model for the [CellTypist automated cell type annotation package (PMID: 35549406)](https://pubmed.ncbi.nlm.nih.gov/35549406/) from the Allen Brain Cell Atlas data. Note that Part 1 of this notebook uses the large AnnData object produced in the Step 2 notebook. If you've skipped running the Group B notebooks due to the large disk space and memory requirements, you may skip Part 1 and run Part 2 of this notebook using a downsampled version of the Allen dataset which we've provided from the Zenodo repository.
- [**Step 10: Predict cell type annotations with CellTypist model for Wheeler et al scRNA-seq data.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/10__abc_atlas_celltypist_predictions.ipynb?flush_cache=true) The notebook uses the CellTypist reference model created in the Step 9 notebook to generate cell type annotation predictions for each single cell in the Wheeler et al dataset.

#### Group E: Reanalysis of the human MS single-nucleus RNA-seq data from [Absinta et al 2021 (PMID: 34497421)](https://pubmed.ncbi.nlm.nih.gov/34497421/) and [Schirmer et al 2019 (PMID: 31316211)](https://pubmed.ncbi.nlm.nih.gov/31316211/)
- [**Step 11: Calculate nuclear fraction with DropletQC**.](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/11_nuclear_fraction_calculation_human_MS_snRNAseq.ipynb?flush_cache=true) This notebook extracts metadata from a preprocessed Seurat object provided to us by the authors of Lee et al, and includes optional code for calculation of the nuclear fraction quality control metric using the [DropletQC package (Muskovic & Powell 2021 (PMID: 34857027))](https://pubmed.ncbi.nlm.nih.gov/34857027/).
- [**Step 12: Reanalysis of human single-nucleus RNA-seq data from Absinta et al and Schirmer et al.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/12__human_MS_singlecell_analysis.ipynb?flush_cache=true) This notebook evaluates the clusters presented by Lee et al in their reanalysis of the RNA-seq data from the Absinta et al and Schirmer et al datasets.
- [**Step 13: Reanalysis of Cluster 2 from the human single-nucleus RNA-seq data.**](https://nbviewer.org/github/michael-r-odea/EpiMemAstros/blob/main/code/13_human_MS_snRNAseq_reanalysis.ipynb?flush_cache=true) This notebook evaluates the effects of ambient RNA removal and empty droplet detection, quality control filtering, and doublet detection on the cluster described as epigenetic memory astrocytes and performs subclustering to detect non-astrocyte contamination.


## License

[MIT](LICENSE) © [liddelowlab](https://github.com/liddelowlab).

## Phyloseq Workshop

This is the code used to create example visualazations from data supplied from 
BIT 477: Metagenomics class (instructor: Carlos Goller).

### Data Collection

TODO:

### Contents

**main.R** is the master R script.

#### data/ ####

The `data/` directory contains the following files.

**metadata.txt: ** that contains the treatment conditions from which the samples were collected.

**otu_summary_table.txt: ** a summary of the operational taxanomic units found.

**otu_table.txt: ** that contains the taxanomic table as well as the sequence matching data.

**taxonomy_table.txt: ** that cantains the OTUs (operational taxanomic units) for each sample. This data is also in **otu_table.txt**.

The **.txt** files are all tab deliminated tabular data.

**taxa.biom** and **taxa_species.biom**: that are both JSON formatted data using the Biological Observation Matrix 
schema (http://biom-format.org/documentation/format_versions/biom-1.0.html). These files duplicate the information in **otu_table.txt** and 
**taxonomy_table.txt**.

#### scripts/ ####

These are the sub-scripts used by **main.R** to generate the plots.


#### plots/ ####

The output plots are all saved in this directory.


### Requirements

* R (3.5.2)

* BiocManager

* ggplot

* stringr

* ggthemes

* plyr

* ape



### Usage

You can run `main.R` directly to run the entire suite of scripts. If you wish to run individual scripts, you should run `scripts/load_and_process_data.R` first to 
load the required data and run any data processing and cleaning. You may also need to install and load the required packages. `main.R` should automatically install and load
the required packages.

### Contributing

The contents of this repository are free to use. If you would like to contribute to it somehow, feel free and submit an issue OR fork the repo, make the suggestion changes
and submit a pull request.

### Contributors

Robert Olendorf 

Carlos Goller

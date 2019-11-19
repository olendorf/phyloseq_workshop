###################
## Automate package install and load packages

is_installed <- function(package_name) is.element(package_name, installed.packages()[,1])

# If a package is not installed, install it. Then load the package.
install_and_load <- function(package_name) {
  if(!is_installed(package_name)) {
    install.packages(package_name)
  }
  library(package_name, character.only = TRUE)
}

install_packages <- function(packages) {
  for(package in packages) {
    install_and_load(package)
  }
}

install_packages(c("BiocManager", "ggplot2", "stringr", "ggthemes", "plyr", "ape"))

# Can't install phyloseq the normal way
if(!is_installed("phyloseq")) {
  BiocManager::install("phyloseq")
}
library(phyloseq)


## This cleans up the scripts a lot. 
source("scripts/load_and_process_data.R")


##
# All of the following scripts depend
# on load_and_process_data.R
##

source("scripts/abundance_plots.R")

# Creating a distance plot
source("scripts/distance_plot.R")


# Create a clustred tree 
source("scripts/tree_plot.R")

# Create an abundance heatmap
source("scripts/heatmap.R")

# Generate alpha diversit plots.
source("scripts/alpha_diversity.R")

# Generate some network graphs
source("scripts/network_graph.R")



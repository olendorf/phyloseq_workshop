gendata <- read.table("data/otu_table.txt", header=TRUE, sep="\t")
otu_matrix <- as.matrix(gendata[, c(2:18)])  # Pull the out_table from gendata

# Assign names to the matrix
colnames(otu_matrix) <- names(gendata[c(2:18)]) 
rownames(otu_matrix) <- gendata$X

# Create the taxonomy table, with names
taxmat <- as.matrix(gendata[, c(19:25)])
rownames(taxmat) <- gendata$X

# Use the metadata file to read in additonal data
sampling_data <- read.table("data/metadata.txt", header = TRUE, sep="\t")
rownames(sampling_data) <- sampling_data$SampleID

# Description and TreatmentGroup need to be treated as strings and factors respectively
sampling_data$Description <- as.character(sampling_data$Description)  
sampling_data$TreatmentGroup <- as.factor(sampling_data$TreatmentGroup)

###################################################################
# Guessing that additional information is in the description field

# regex temperature from the input (description field)
get_temp <- function(input) {
  out <- as.integer( regmatches(input, regexpr("\\d\\d", input)) )
  if(length(out) == 0){
    out <- NA
  }
  return(out)
}


# regex weeks from the input (description field)
get_weeks <- function(input) {  
  out <- regmatches(input, regexpr("\\d weeks", input, ignore.case = TRUE))
  if(length(out) == 0){
    out <- NA
  }
  return(out)
}

# pull the temperature into its own column
sampling_data$temperature_celsius <- NA
for(i in c(1:17)) {
  sampling_data[i, ]$temperature_celsius <- get_temp(sampling_data[i,]$Description)
}


# pull the weeks into its own column.
sampling_data$weeks <- NA
for(i in c(1:17)) {
  capture <- get_weeks(sampling_data[i,]$Description)
  if(length(capture) != 0 && !is.na(capture)) {
    sampling_data[i,]$weeks <- as.integer(regmatches(capture, regexpr("\\d", capture)))
  }
}

# Convert swine, chicken, feed, eggs and poultry into their own boolean fields.
sampling_data$swine <- grepl("swine", sampling_data$Description, ignore.case = TRUE)
sampling_data$chicken <- grepl("chicken", sampling_data$Description, ignore.case = TRUE)
sampling_data$feed <- grepl("feed", sampling_data$Description, ignore.case = TRUE)
sampling_data$eggs <- grepl("eggs", sampling_data$Description, ignore.case = TRUE)
sampling_data$poultry <- grepl("poultry", sampling_data$Description, ignore.case = TRUE)

# Combine all the parts together into a phyloseq data object.
physeq <- phyloseq(otu_table(otu_matrix, taxa_are_rows = TRUE), tax_table(taxmat), sample_data(sampling_data))

# Need to tame the number of branches for a nice plot. AFter inpsecting the distribution
# and some trial and error settled on this.
pruned_physeq <- prune_taxa(taxa_sums(physeq) >= 10000, physeq)
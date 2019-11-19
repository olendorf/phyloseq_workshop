gendata <- read.table("data/OTU_table.txt", header=TRUE, sep="\t")
otu_matrix <- as.matrix(gendata[, c(2:18)])
colnames(otu_matrix) <- names(gendata[c(2:18)])
rownames(otu_matrix) <- gendata$X

taxmat <- as.matrix(gendata[, c(19:25)])
rownames(taxmat) <- gendata$X


sampling_data <- read.table("data/Metadata_corrected.txt", header = TRUE, sep="\t")
rownames(sampling_data) <- sampling_data$SampleID
sampling_data$Description <- as.character(sampling_data$Description)
sampling_data$TreatmentGroup <- as.factor(sampling_data$TreatmentGroup)

get_temp <- function(input) {
  out <- as.integer( regmatches(input, regexpr("\\d\\d", input)) )
  if(length(out) == 0){
    out <- NA
  }
  return(out)
}

get_weeks <- function(input) {  
  out <- regmatches(input, regexpr("\\d weeks", input, ignore.case = TRUE))
  if(length(out) == 0){
    out <- NA
  }
  return(out)
}

sampling_data$temperature_celsius <- NA
for(i in c(1:17)) {
  sampling_data[i, ]$temperature_celsius <- get_temp(sampling_data[i,]$Description)
}

sampling_data$weeks <- NA
for(i in c(1:17)) {
  capture <- get_weeks(sampling_data[i,]$Description)
  if(length(capture) != 0 && !is.na(capture)) {
    sampling_data[i,]$weeks <- as.integer(regmatches(capture, regexpr("\\d", capture)))
  }
}

sampling_data$swine <- grepl("swine", sampling_data$Description, ignore.case = TRUE)
sampling_data$chicken <- grepl("chicken", sampling_data$Description, ignore.case = TRUE)
sampling_data$feed <- grepl("feed", sampling_data$Description, ignore.case = TRUE)
sampling_data$eggs <- grepl("eggs", sampling_data$Description, ignore.case = TRUE)
sampling_data$poultry <- grepl("poultry", sampling_data$Description, ignore.case = TRUE)


physeq <- phyloseq(otu_table(otu_matrix, taxa_are_rows = TRUE), tax_table(taxmat), sample_data(sampling_data))

# Need to tame the number of branches for a nice plot. AFter inpsecting the distribution
# and some trial and error settled on this.
pruned_physeq <- prune_taxa(taxa_sums(physeq) >= 10000, physeq)
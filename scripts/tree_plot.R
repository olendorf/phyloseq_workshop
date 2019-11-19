# Need to tame the number of branches for a nice plot. AFter inpsecting the distribution
# and some trial and error settled on this.
pruned_physeq <- prune_taxa(taxa_sums(physeq) >= 10000, physeq)

tree <- rtree(ntaxa(pruned_physeq), rooted = FALSE, tip.label = taxa_names(pruned_physeq))
pruned_physeq <- merge_phyloseq(pruned_physeq, tree)
tree_plot <- plot_tree(pruned_physeq, color="TreatmentGroup", size="temperature_celsius", label.tips = "Class")
ggsave("plots/tree_plot.png", tree_plot)

plot_heatmap(pruned_physeq)

plot_heatmap(physeq, method="MDS", taxa.label = "Class", taxa.order = "Class")


plot_heatmap(pruned_physeq, method="MDS", taxa.label = "Class", taxa.order = "Class")


treatment_group_heatmap <- plot_heatmap(pruned_physeq, method="MDS", 
                            sample.label = "TreatmentGroup", 
                            taxa.label = "Genus", 
                            taxa.order = "Order", 
                            low="#ffffff", 
                            high="#ff0000", 
                            na.value = "#001133", 
                            sample.order = "TreatmentGroup")
ggsave("plots/treatment_group_heatmap.png", treatment_group_heatmap)




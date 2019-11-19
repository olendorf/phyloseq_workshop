plot_net(physeq, type = "taxa")

taxa_network <- plot_net(pruned_physeq, type = "taxa", 
                                        distance = "jaccard", 
                                        color = "Class", 
                                        maxdist = 0.4, 
                                        point_label = "Genus")
ggsave("plots/taxa_network.png", taxa_network)

sample_network_07 <- plot_net(pruned_physeq, type = "samples", 
                                             distance = "bray", 
                                             color = "TreatmentGroup", 
                                             maxdist = 0.7, 
                                             point_label = "SampleID")
ggsave("plots/sample_network_07.png", sample_network_07)

sample_network_09 <- plot_net(pruned_physeq, type = "samples", 
                                             distance = "bray", 
                                             color = "TreatmentGroup", 
                                             maxdist = 0.9, 
                                             point_label = "SampleID")
ggsave("plots/sample_network_07.png", sample_network_09)
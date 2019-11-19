abundance_by_sample_plot <- plot_bar(subset_taxa(pruned_physeq, Genus != ""), fill = "Genus")
abundance_by_sample_plot <- abundance_by_sample_plot + theme_tufte()
ggsave("plots/abundance_by_sample.png", abundance_by_sample_plot)


abundance_by_treatment_plot <- plot_bar(subset_taxa(pruned_physeq, Genus != ""), x="TreatmentGroup", fill = "Genus")
abundance_by_treatment_plot <- abundance_by_treatment_plot + theme_tufte()
ggsave("plots/abundance_by_treatment.png", abundance_by_treatment_plot)


abundance_facet_treatment_plot <- plot_bar(subset_taxa(pruned_physeq, Genus != ""), "Order", facet_grid=swine~TreatmentGroup, fill = "Genus")
abundance_facet_treatment_plot + theme_bw() + theme(axis.text.x = element_text(angle = 90))
ggsave("plots/abundance_facet_treatment.png", abundance_facet_treatment_plot)


# The most basic plot. However too many taxa to make a decent plot
abundance_by_sample_plot <- plot_bar(physeq, fill = "Genus")
abundance_by_sample_plot <- abundance_by_sample_plot + theme_tufte()
abundance_by_sample_plot
ggsave("plots/abundance_by_sample.png", abundance_by_sample_plot)

# using the pruned data gives a cleaner plot
abundance_by_sample_plot <- plot_bar(subset_taxa(pruned_physeq, Genus != ""), fill = "Genus")
abundance_by_sample_plot <- abundance_by_sample_plot + theme_tufte()
abundance_by_sample_plot
ggsave("plots/abundance_by_sample.png", abundance_by_sample_plot)

# Group the abundances by treatment
abundance_by_treatment_plot <- plot_bar(subset_taxa(pruned_physeq, Genus != ""), x="TreatmentGroup", fill = "Genus")
abundance_by_treatment_plot <- abundance_by_treatment_plot + theme_tufte()
abundance_by_treatment_plot
ggsave("plots/abundance_by_treatment.png", abundance_by_treatment_plot)

# Use a graphics array presentation to facet out dta.
abundance_facet_treatment_plot <- plot_bar(subset_taxa(pruned_physeq, Genus != ""), "Order", facet_grid=swine~TreatmentGroup, fill = "Genus")
abundance_facet_treatment_plot <- abundance_facet_treatment_plot + theme_bw() + theme(axis.text.x = element_text(angle = 90))
abundance_facet_treatment_plot
ggsave("plots/abundance_facet_treatment.png", abundance_facet_treatment_plot)

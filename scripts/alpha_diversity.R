plot_richness(physeq)

# This plot shows that sample S16 is a bit of an outlier.
plot_richness(physeq, measures = "Chao1")

plot_richness(physeq,  x = "TreatmentGroup", color = "poultry")
# Use the full dataset rather than pruned since those rarer taxa do contribute to diversity.
richness_plot <- plot_richness(physeq, measures = c("Shannon", "Chao1", "Simpson"), 
                                       x = "TreatmentGroup", 
                                       color = "poultry")
richness_plot <- richness_plot + theme_bw() 

# S16 is in treatment group 3. We see that it contributes a lot to Chao1 and seemingly less to 
# Shannon or Simpson.
richness_plot
ggsave("plots/richness_by_treatment.png", richness_plot)


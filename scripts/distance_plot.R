

dist_methods <- unlist(distanceMethodList)
dist_methods <- dist_methods[-(1:3)]  # These won't work with our data
dist_methods = dist_methods[-which(dist_methods=="ANY")]

dist_methods = dist_methods[-which(dist_methods=="manhattan")]
dist_methods = dist_methods[-which(dist_methods=="altGower")]
dist_methods = dist_methods[-which(dist_methods=="maximum")]



plist <- vector("list", length(dist_methods))
names(plist) = dist_methods

for( i in dist_methods) {
  idist <- distance(physeq, method = i)
  
  imds <- ordinate(physeq, "MDS", distance = idist)
  
  p <- NULL
  
  p <- plot_ordination(physeq, imds, color = "temperature_celsius", shape = "TreatmentGroup")
  p <- p + ggtitle(paste("MDS using distance methods ", i, sep=""))
  p <- p + theme_bw()
  plist[[i]] = p
}

df <- ldply(plist, function(x) x$data)
names(df)[1] <- "distance"
dist_plot <- ggplot(df, aes(Axis.1, Axis.2))

dist_plot <- dist_plot + geom_point(size = 1) +
         facet_wrap(~distance, scales = "free") + 
         ggtitle("MDS on various distance metrics")
ggsave("plots/dist_mds.png", dist_plot)



dist <- distance(physeq, "jaccard")
imds <- ordinate(physeq, "MDS", distance = dist)
jaccard_plot <- plot_ordination(physeq, imds, shape="TreatmentGroup", color="temperature_celsius")
jaccard_plot <- jaccard_plot + theme_bw() + geom_point(size = 3)
ggsave("plots/jaccard_mds.png", jaccard_plot)


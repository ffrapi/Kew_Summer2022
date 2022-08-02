#Function for running and plotting NMDS

#x: which columns have a sum of less than the value x
#z: distance matrix: "jaccard", "bray" etc
https://www.rdocumentation.org/packages/labdsv/versions/2.0-1/topics/nmds

#based on scree plot for NMDS, the user is asked to input the number of dimensions to run NMDS. 
#A good rule of thumb: 
#stress < 0.05 provides an excellent representation in reduced dimensions, 
#< 0.1 is great, 
#< 0.2 is good/ok, 
#stress < 0.3 provides a poor representation.** 
#To reiterate: high stress is bad, low stress is good! https://jonlefcheck.net/2012/10/24/nmds-tutorial-in-r/



nmds_plots_input <- function(x,z) {
  #SUBSET DATA
  bfil <- b[,-which(colSums(b) < x)] 
  bfil[bfil>0] <-1
  
  #define dimensions from this part hopefully - either user inputs based on scree plot or choose d > 0.05
  par(mfrow=c(1,1))
  set.seed(2)
  NMDS.scree(bfil) 
  
  var = readline(prompt = "Enter number of dimensions: "); 
  var = as.integer(var);

print(var)  
  
    #RUN NMDS
  set.seed(2)
  nmds <- metaMDS(bfil, k=var, distance=z ,trymax=1000, trace=F)
  
  #Create dataframe of results
  f <- c(nmds$converged)
  q <- c(nmds$stress)
  r <- merge.data.frame(f, q)
  colnames(r) <- c("Converged", "Stress")
  
  #Stressplot and ordiplot 
  par(mfrow=c(2,1))
  treat=c(rep("Conifers",7),rep("Solarum",5))
  colors=c(rep("darkolivegreen1",7),rep("darkolivegreen4",5))
  
  stressplot(metaMDS(bfil, k=var , distance = z,trymax=1000, trace=F))
  
  ordiplot(nmds,type="n")
  for(i in unique(treat)) {
    ordihull((metaMDS(bfil, k=var ,distance = z, trymax=1000, trace=F))$point[grep(i,treat),],draw="polygon",
             groups=treat[treat==i],col=colors[grep(i,treat)],label=F)
  }
  orditorp(metaMDS(bfil, k=var , distance = z,trymax=1000, trace=F),display="species",col="black",air=0.01, cex=0.3)
  orditorp(metaMDS(bfil, k=var ,distance = z, trymax=1000, trace=F),display="sites",col=c(rep("darkgreen",7), rep("chartreuse3",5)),cex=1.2)
  
  return(r)
}

nmds_plots_input(500,"jaccard") 
summary(warnings()) # to see the warnings from the NMDS.scree plot
unique(warnings()) # to see if there is any NMDS error - maybe this wont work
assign("last.warning", NULL, envir = baseenv())

setwd("~/Desktop/FP/plotting_trees")

#Install the R package ape - you only need to do this once, not every time you plot a tree
install.packages("ape")

#Load the package
library(ape)
library(ggtree)

hist(as.numeric(tree1$node.label),col= "grey30",xlab="Bootstrap value", main=" Neocucurbitaria phylogenetic tree bootstrap histogram")
hist(as.numeric(tree2$node.label),col= "grey30",xlab="Bootstrap value", main=" Neocucurbitaria phylogenetic tree bootstrap histogram")

### Rerooting a tree based on an internal node creates a basal polytomy - this may look funny, but it's correct (see https://www.biostars.org/p/332030/) ###
tree1 <- read.tree("04_Neod_LSU.raxml.support")
tree1$tip.label

outgroup1 <- c("Leptosphaeria_conoidea_", "Leptosphaeria_doliolum_")
tree1 <- root(tree1,
              outgroup1,
              resolve.root = TRUE,
              edgelabel = TRUE)

#Check it's rooted
is.rooted(tree1)
#Plot a simple tree (using ape)
plot(tree1)
#Add the support values on branches
#drawSupportOnEdges(tree1$node.label, cex=0.7)
#drawSupportOnEdges(tree2$node.label, cex=0.7)


##############
#Load ggtree
library(ggtree)

#Plot tree with branch lengths
gg.tree1 <- ggtree(tree1)
plot(gg.tree1)
#We can also plot the tree without branch lengths
#gg.tree1 <- ggtree(tree1, branch.length = "none")
#Add support labels on branches - can add layers to ggtree plot by + similarly to gpplot
gg.tree2 <- gg.tree1+
  geom_nodelab(aes(x = branch),
               size = 2,
               vjust = -0.5)+geom_tiplab(size =2, fontface="bold")
gg.tree3 <- gg.tree2 +
  #Add tip labels
  geom_tiplab(size =2, 
              fontface = "italic")

plot(gg.tree3)

#Now we can see there's an issue with scaling, and our tip labels have been cut off. Just like any ggplot graph, you can change the limits of the axes (in this case we want to change the horizontal limits, so the x axis)
gg.tree4 <- gg.tree2 +
  #Make room for labels by increasing the upper x limit
  xlim(c(0,0.1))
plot(gg.tree4)

gg.tree4 +
  geom_text2(aes(subset = !isTip, label = node), hjust = -0.3,colour="red")


#Highlight and label chosen clades using the node number

####Phylogenetic tree
gg.tree5 <-gg.tree4 +
  #Add label
  geom_cladelab(node = 70,
                label = "Endophyte genome",
                offset = 0.1,
                barsize = 1,
                fontsize = 2,
                fontface = "bold") +
  #Add highlight
  geom_highlight(node = 70,
                 extend = 0.05,
                 alpha = 0.2,
                 fill = "purple")+
  geom_tippoint(aes(), size=0.3, colour="black",alpha=1)

plot(gg.tree5)

pdf("Neodidymella_Stag_Tree_11Aug.pdf")
plot(gg.tree5)
dev.off()
####cladogram
#Plot tree with branch lengths
gg.treeA <- ggtree(tree1) +
  #Add tip labels
  geom_tiplab()

plot(gg.treeA)

#Plot tree without branch lengths
gg.treeA <- ggtree(tree1, branch.length = "none") +
  #Add tip labels with different styling
  geom_tiplab(size = 3,
              fontface = "italic")

plot(gg.treeA)

#Add support labels on branches
support.values <- tree1$node.label

gg.treeB <- gg.treeA +
  geom_nodelab(aes(x = branch),
               label = support.values,
               size = 3,
               vjust = -0.5)

plot(gg.treeB)

#Plot to see node numbers
gg.treeB +
  geom_text2(aes(subset = !isTip, label = node), hjust = -.3)

#Highlight and label chosen clades using the node number
gg.treeC <- gg.treeB+
  #Make room for label
  xlim(c(0,30)) +
  #Add label
  geom_cladelabel(node = 96,
                  label="Endophyte genome",
                  offset = 6.5,
                  barsize = 1,
                  fontsize = 2.5,
                  fontface = "bold") +
  #Add highlight
  geom_hilight(node = 96,
               extend = 6.5,
               alpha = 0.3,
               fill = "purple")+
  geom_tippoint(aes(), size=0.5, colour="black",alpha=1)


plot(gg.treeC)

pdf("Neoc_FinalTree.pdf")
plot(gg.tree5)
plot(gg.treeC)
dev.off()


#Plot tree with branch lengths
gg.tree10 <- ggtree(tree2)
plot(gg.tree10)
#We can also plot the tree without branch lengths
#gg.tree1 <- ggtree(tree1, branch.length = "none")
#Add support labels on branches - can add layers to ggtree plot by + similarly to gpplot
gg.tree12 <- gg.tree10+
  geom_nodelab(aes(x = branch),
               size = 2,
               vjust = -0.5)+geom_tiplab(size =2, fontface="bold")
gg.tree13 <- gg.tree12 +
  #Add tip labels
  geom_tiplab(size =2, 
              fontface = "italic")

plot(gg.tree13)

#Now we can see there's an issue with scaling, and our tip labels have been cut off. Just like any ggplot graph, you can change the limits of the axes (in this case we want to change the horizontal limits, so the x axis)
gg.tree14 <- gg.tree12 +
  #Make room for labels by increasing the upper x limit
  xlim(c(0, 0.8))
plot(gg.tree14)

gg.tree14 +
  geom_text2(aes(subset = !isTip, label = node), hjust = -0.3,colour="red")


#Highlight and label chosen clades using the node number

####Phylogenetic tree
gg.tree15 <-gg.tree14 +
  #Add label
  geom_cladelab(node = 95,
                label = "Group A",
                offset = 0.16,
                barsize = 1,
                fontsize = 10,
                fontface = "bold") +
  #Add highlight
  geom_highlight(node = 95,
                 extend = 0.15,
                 alpha = 0.2,
                 fill = "purple")+
  geom_tippoint(aes(), size=0.3, colour="black",alpha=1)

plot(gg.tree15)




####cladogram
#Plot tree with branch lengths
gg.treeA1 <- ggtree(tree2) +
  #Add tip labels
  geom_tiplab()

plot(gg.treeA1)

#Plot tree without branch lengths
gg.treeA1 <- ggtree(tree2, branch.length = "none") +
  #Add tip labels with different styling
  geom_tiplab(size = 3,
              fontface = "italic")

plot(gg.treeA1)

#Add support labels on branches
support.values <- tree2$node.label

gg.treeB1 <- gg.treeA1 +
  geom_nodelab(aes(x = branch),
               label = support.values,
               size = 3,
               vjust = -0.5)

plot(gg.treeB1)

#Plot to see node numbers
gg.treeB1 +
  geom_text2(aes(subset = !isTip, label = node), hjust = -.3)

#Highlight and label chosen clades using the node number
gg.treeC1 <- gg.treeB1+
  #Make room for label
  xlim(c(0,30)) +
  #Add label
  geom_cladelabel(node = 95,
                  label="Endophyte genome",
                  offset = 6.5,
                  barsize = 1,
                  fontsize = 2.5,
                  fontface = "bold") +
  #Add highlight
  geom_hilight(node = 95,
               extend = 6.5,
               alpha = 0.3,
               fill = "purple")+
  geom_tippoint(aes(), size=0.5, colour="black",alpha=1)


plot(gg.treeC1)

pdf("Neoc_FinalTree_beforeCheckNames.pdf")
plot(gg.tree15)
plot(gg.tree)
dev.off()


















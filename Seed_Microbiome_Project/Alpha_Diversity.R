##############Sep Diversity metrics

###########September 5 Visualizing distribution of species #######################
setwd("~/Kew_22_FP/FrancesPitsillides_SummerIntern/Seed_microbiome_project/r_analysis")


install.packages("cowplot")
install.packages("grid")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("babynames")
install.packages("viridis")
install.packages("hrbrthemes")
install.packages("plotly")
install.packages("gridExtra")
install.packages("paletteer")
install.packages("ecolTest")
install.packages("microbiome")
install.packages("ggpubr")
install.packages("knitr")
install.packages("dyplr")
library("microbiome")
library("ggpubr")
library("knitr")
library("dplyr")
library("gridextra")
library("ecolTest")
library(paletteer)
library("gridExtra")
library("cowplot")
library("grid")
library("ggplot2")
library("dplyr")
library("babynames")
library("viridis")
library("hrbrthemes")
library("plotly")
library("vegan")

############## STRUCTURE OF MEASURING DIVERSITY METRICS ####################

# 1) Measure diversity metrics for conifer and solanum
# 2) Create dataframe of diversity metrics 
# 3) Statistical tests (Hutcheson t.test, Tukey HSD)


####Load dataset
b1<- read.csv("Aug19_SMP_AbundanceData_without_WE1.csv")
rownames(b1) <- c("ITS-WS1","ITS-WS2","ITS-WS3","ITS-WS4","ITS-WS5","ITS-WS6","ITS-WS7","ITS-WS8","ITS-WS9","ITS-WS10", "ITS-WS11")
conifer <- b1[1:6,]
solanum <- b1[7:11,]


  # the higher the value of the diversity, the higher the diversity of species in a particular community. 
  # A value of H=0 indicates that the community only has one species 


################# 1) Measuring Diversity (Shannon and Simpson) #####################

###Shannon index for all data
shannon.diversity <- diversity(b1, index="shannon")

#shannon_conifer <- diversity(conifer, index="shannon")
shannon_conifer1 <- shannon.diversity[1:6]

#shannon_solanum <- diversity(solanum, index="shannon")
shannon_solanum1 <- shannon.diversity[7:11]

#comparing means of the two 
mean(shannon_conifer1)
mean(shannon_solanum1) ##ws9 has incredibly high diversity compared to rest of seeds



###Simpson index
  #Simpson's Diversity Index is a measure of diversity. In ecology, it is often used to quantify the biodiversity of a habitat. It takes into account the number of species present, as well as the abundance of each species.
  #highest possible value is 1, and lowest is 0
  #the higher the value, the greater the sample diversity

simpson.diversity <- diversity(b1, index="simpson")
simpson_conifer <- simpson.diversity[1:6]
simpson_solanum <- simpson.diversity[7:11]
mean(simpson_conifer)
mean(simpson_solanum)

boxplot(simpson_conifer, simpson_solanum) 


################  2) create dataframe with results ################################
diversity <- data.frame(simpson.diversity, shannon.diversity)
diversity$Habitat <- c(rep("Conifer", 6), rep("Solanum", 5))
shannon.diversity
diversity



#testing statistical difference between conifer and solanum diversity estimates

###1: HUtchesons t-test
Hutcheson_t_test(shannon_conifer1, shannon_solanum1, difference = 0)
Hutcheson_t_test(simpson_conifer, simpson_solanum, difference = 0)

#p-value is significant - shannon index between confier and solanum are significantly different


####2: ANOVA
##checking assumptions
hist(diversity$shannon.diversity)
qqnorm(diversity$shannon.diversity)
qqline(diversity$shannon.diversity)

set.seed(23)
shannon <- aov(shannon.diversity ~Habitat, data = diversity)
plot(shannon)
f <- summary(shannon)
f
TukeyHSD(shannon) # not significant

#checking assumptions
hist(diversity$simpson.diversity)
qqnorm(diversity$simpson.diversity)
qqline(diversity$simpson.diversity)
simpson <- aov(simpson.diversity ~Habitat, data = diversity)
plot(simpson)
summary(simpson)
TukeyHSD(simpson)


####3: Tukey HSD test
#conifer.shannon<- TukeyHSD(aov(lm(simpson.diversity ~ Habitat, data = diversity)))
#conifer.shannon
#TukeyHSD(shannon, conf.level=0.95) #not significantly different
#TukeyHSD(simpson, conf.level=0.95) #not significantly different 

#plot(TukeyHSD(shannon, conf.level=.95), las=2)


TukeyHSD(aov(lm(shannon.diversity ~ Habitat, data = diversity)))
TukeyHSD(aov(lm(simpson.diversity ~ Habitat, data = diversity)))



##################### Function to check how data dimensions affect diversity metrics ############

diversity.metrics <- function(x) {
  #SUBSET DATA
  bfil <- b1[,-which(colSums(b1) < x)] 
  
  
  ##measuring shannon
  shannon.diversity22 <- diversity(bfil, index="shannon")
  shannon_conifer22 <- shannon.diversity22[1:6]
  shannon_solanum22 <- shannon.diversity22[7:11]
  
  #measuring simpson
  simpson.diversity22 <- diversity(bfil, index="simpson")
  simpson_conifer22 <- simpson.diversity22[1:6]
  simpson_solanum22 <- simpson.diversity22[7:11]
  
  #creating dataframe of values
  diversity22 <- data.frame(simpson.diversity22, shannon.diversity22)
  diversity22$Habitat <- c(rep("Conifer", 6), rep("Solanum", 5))
 
  
  #statistical tests
  aa <-  Hutcheson_t_test(shannon_conifer22, shannon_solanum22, difference = 0)
  bbb <- TukeyHSD(aov(lm(shannon.diversity22 ~ Habitat, data = diversity22)))
  ccc <- TukeyHSD(aov(lm(simpson.diversity22 ~ Habitat, data = diversity22)))
  bbbb <- data.frame(bbb$Habitat)
  cccc <- data.frame(ccc$Habitat)
  metrics <- c("Hutcheson t-test", "Shannon index", "simpson index", aa$p.value,bbbb[1,4],cccc[1,4])
  
  
  return(metrics)
}

diversity.metrics(100)




df2 = c()
for(i in seq(1,100, by=5)){
  g <- diversity.metrics(i)
  df2 <- rbind(df2, g)
  par(mfrow=c(3,1))
  plot(df2[,4], type = "l", main  = "Hutcheson t-test", ylab= "p-value", xlab = "b1[,-which(colSums(b1) < x)]" )
  plot(df2[,5], type="l", main= "Shannon index", ylab = "p-value",  xlab = "b1[,-which(colSums(b1) < x)]" )
  plot(df2[,6], type="l", main= "Simpson index", ylab = "p-value",  xlab = "b1[,-which(colSums(b1) < x)]" )
  print(df2)
}






#########     plotting alpha diversity ###############



####violin plot http://rpkgs.datanovia.com/ggpubr/reference/ggviolin.html
p1 <- ggviolin(diversity, x="Habitat", y= "shannon.diversity", add="boxplot", fill= "Habitat") #can see that there is an outlier
p1

par(mfrow=c(2,1))
p2 <- ggviolin(diversity, x="Habitat", y= "shannon.diversity", fill= "Habitat", 
         orientation = "horiz", 
         palette = c("green3", "firebrick"),
         add= "boxplot", add.params=list(fill="white"))
p2
p3 <- ggviolin(diversity, x="Habitat", y= "simpson.diversity", fill= "Habitat", 
         orientation = "horiz", 
         palette = c("green3", "firebrick"),
         add= "boxplot", add.params=list(fill="white"))+theme(legend.position="none")

grid.arrange(p2,p3, nrow = 2)


#####boxplot
p <- ggplot(diversity, aes(x=Habitat, y=shannon.diversity,  fill=Habitat))+geom_boxplot()+
  coord_flip()+geom_jitter()+theme_classic()+scale_fill_brewer(palette="Dark2")+
  theme(legend.position="top")
pa <- ggplot(diversity, aes(x=Habitat, y=simpson.diversity,  fill=Habitat))+geom_boxplot()+
  coord_flip()+geom_jitter()+theme_classic()+scale_fill_brewer(palette="Dark2")+
  theme(legend.position="none")

grid.arrange(p,pa, nrow=2)


##export pdf for diversity indices
pdf("Oct7_Diversity_estimates.pdf", height=10, width = 15)
grid.arrange(p2,p3, nrow = 2)
grid.arrange(p,pa, nrow=2)
dev.off()




################### running shannon and simpson index withou seed 9  ##################


####Load dataset
b2<- read.csv("Oct23_AbundanceData_Without_Seed9.csv", row.names= 1)
head(b2)
conifer <- b2[1:6,]
solanum <- b2[7:10,]


# the higher the value of the diversity, the higher the diversity of species in a particular community. 
# A value of H=0 indicates that the community only has one species 


################# 1) Measuring Diversity (Shannon and Simpson) #####################

###Shannon index for all data
shannon.diversity2 <- diversity(b2, index="shannon")

#shannon_conifer <- diversity(conifer, index="shannon")
shannon_conifer2 <- shannon.diversity2[1:6]

#shannon_solanum <- diversity(solanum, index="shannon")
shannon_solanum2 <- shannon.diversity2[7:10]

#comparing means of the two 
mean(shannon_conifer2)
mean(shannon_solanum2) ##ws9 has incredibly high diversity compared to rest of seeds



###Simpson index
#Simpson's Diversity Index is a measure of diversity. In ecology, it is often used to quantify the biodiversity of a habitat. It takes into account the number of species present, as well as the abundance of each species.
#highest possible value is 1, and lowest is 0
#the higher the value, the greater the sample diversity

simpson.diversity2 <- diversity(b2, index="simpson")
simpson_conifer2 <- simpson.diversity2[1:6]
simpson_solanum2 <- simpson.diversity2[7:10]
mean(simpson_conifer2)
mean(simpson_solanum2)

boxplot(simpson_conifer, simpson_solanum) 


################  2) create dataframe with results ################################
diversity2 <- data.frame(simpson.diversity2, shannon.diversity2)
diversity2$Habitat <- c(rep("Conifer", 6), rep("Solanum", 4))
diversity2



#testing statistical difference between conifer and solanum diversity estimates

###1: HUtchesons t-test
Hutcheson_t_test(shannon_conifer2, shannon_solanum2, difference = 0)

#p-value is significant - shannon index between confier and solanum are significantly different


####2: ANOVA
##checking assumptions
hist(diversity2$shannon.diversity2)
qqnorm(diversity2$shannon.diversity2)
qqline(diversity2$shannon.diversity2)

set.seed(23)
shannon2 <- aov(shannon.diversity2 ~Habitat, data = diversity2)
plot(shannon2)
f <- summary(shannon2)
f
TukeyHSD(shannon) # not significant

#checking assumptions
hist(diversity$simpson.diversity)
qqnorm(diversity$simpson.diversity)
qqline(diversity$simpson.diversity)
simpson <- aov(simpson.diversity2 ~Habitat, data = diversity2)
plot(simpson)
summary(simpson)
TukeyHSD(simpson)


####3: Tukey HSD test
#conifer.shannon<- TukeyHSD(aov(lm(simpson.diversity ~ Habitat, data = diversity)))
#conifer.shannon
#TukeyHSD(shannon, conf.level=0.95) #not significantly different
#TukeyHSD(simpson, conf.level=0.95) #not significantly different 

#plot(TukeyHSD(shannon, conf.level=.95), las=2)


TukeyHSD(aov(lm(shannon.diversity2 ~ Habitat, data = diversity2))) #almost significant 0.054
TukeyHSD(aov(lm(simpson.diversity2 ~ Habitat, data = diversity2))) #not significant 0.0802



##########plotting

####violin plot http://rpkgs.datanovia.com/ggpubr/reference/ggviolin.html
diversity2
par(mfrow=c(2,1))
p2<- ggviolin(diversity2, x="Habitat", y= "shannon.diversity2", fill= "Habitat", 
               orientation = "horiz", 
               palette = c("green3", "firebrick"),
               add= "boxplot", add.params=list(fill="white"))
p2
p3 <- ggviolin(diversity2, x="Habitat", y= "simpson.diversity2", fill= "Habitat", 
               orientation = "horiz", 
               palette = c("green3", "firebrick"),
               add= "boxplot", add.params=list(fill="white"))+theme(legend.position="none")

grid.arrange(p2,p3, nrow = 2)



###EXTRA:
diversity.metrics2 <- function(x) {
  #SUBSET DATA
  bfil <- b2[,-which(colSums(b2) < x)] 
  
  
  ##measuring shannon
  shannon.diversity22 <- diversity(bfil, index="shannon")
  shannon_conifer22 <- shannon.diversity22[1:6]
  shannon_solanum22 <- shannon.diversity22[7:10]
  
  #measuring simpson
  simpson.diversity22 <- diversity(bfil, index="simpson")
  simpson_conifer22 <- simpson.diversity22[1:6]
  simpson_solanum22 <- simpson.diversity22[7:10]
  
  #creating dataframe of values
  diversity22 <- data.frame(simpson.diversity22, shannon.diversity22)
  diversity22$Habitat <- c(rep("Conifer", 6), rep("Solanum", 4))
  
  
  #statistical tests
  aa <-  Hutcheson_t_test(shannon_conifer22, shannon_solanum22, difference = 0)
  bbb <- TukeyHSD(aov(lm(shannon.diversity22 ~ Habitat, data = diversity22)))
  ccc <- TukeyHSD(aov(lm(simpson.diversity22 ~ Habitat, data = diversity22)))
  bbbb <- data.frame(bbb$Habitat)
  cccc <- data.frame(ccc$Habitat)
  metrics <- c("Hutcheson t-test", "Shannon index", "simpson index", aa$p.value,bbbb[1,4],cccc[1,4])
  
  
  return(metrics)
}

diversity.metrics2(100)

df2 = c()
for(i in seq(1,100, by=5)){
  g <- diversity.metrics2(i)
  df2 <- rbind(df2, g)
  par(mfrow=c(3,1))
  plot(df2[,4], type = "l", main  = "Hutcheson t-test", ylab= "p-value", xlab = "b1[,-which(colSums(b1) < x)]" )
  plot(df2[,5], type="l", main= "Shannon index", ylab = "p-value",  xlab = "b1[,-which(colSums(b1) < x)]" )
  plot(df2[,6], type="l", main= "Simpson index", ylab = "p-value",  xlab = "b1[,-which(colSums(b1) < x)]" )
  print(df2)
}

# p-value increases with decreasing columns

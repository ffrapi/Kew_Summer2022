################################################################
################## A: Plot coordinates of map ##################
################################################################


###1: DOWNLOAD PACKAGES ######
install.packages("tidyverse")
install.packages("sf")
install.packages("mapview")
install.packages("wesanderson")
library("tidyverse")
library("sf")
library("mapview")
library("wesanderson")

###2: LOAD DATA ######
all_locality <- read.csv("/Users/fpi10kg/Documents/1_SMP_ANALYSIS_2024/DATA/Locality_data_all.csv")
dim(all_locality)
Gymno_all <- all_locality[1:6,]
Angio_all <- all_locality[7:11,]
Soy_subset <- all_locality[12:156,]


######### USING GGPLOT ###############
#Create data for world coordinates using (map_data() ) function
world_coordinates <- map_data("world")
usa <- map_data("usa")
usa

### Soy dataset only
p3 <- ggplot()+ geom_map( 
  data = world_coordinates, map = world_coordinates, 
  aes(long, lat, map_id = region), color="Black", fill="white", size=0.01
)+geom_point( data = Soy_all, aes(Long_DMS, Lat_DMS, colour = Order), alpha = 1, size=5)+scale_color_brewer(palette="Dark2")+xlab("Longitude")+ylab("Latitude")+theme(text = element_text(size = 23)
)+ylim(-60,15)+xlim(-100, -25)+theme(axis.text = element_text(size = 15))+  theme(legend.title = element_text(size=15))+theme(legend.text = element_text(size=10))+theme(legend.position="top")+guides(shape="none")

pdf(file="/Users/fpi10kg/Documents/1_SMP_ANALYSIS_2024/Rstudio_ALL/World_map_Altitude_SOY_7JUNE24.pdf", width=10, height=10)
p3
dev.off()

###1: Locality separated by type of plant host 
p1 <- ggplot()+ geom_map( 
  data = world_coordinates, map = world_coordinates, 
  aes(long, lat, map_id = region), color="Black", fill="white", size=0.01
)+geom_point( data = all_locality, aes(Long_DMS, Lat_DMS, colour = Order,shape = factor(Order)), alpha = 1, size=4)+scale_color_brewer(palette="Dark2")+xlab("Longitude")+ylab("Latitude")+theme(text = element_text(size = 23)
)+theme(axis.text = element_text(size = 15))+  theme(legend.title = element_text(size=15))+theme(legend.text = element_text(size=10))+theme(legend.position="top")+guides(shape="none")

pdf(file="/Users/fpi10kg/Documents/1_SMP_ANALYSIS_2024/Rstudio_ALL/World_map_ALL_7JUNE24.pdf", width=15, height=10)
p1
dev.off()

###2: Locality + Altitude gradient
allplot<- ggplot()+ geom_map( 
  data = world_coordinates, map = world_coordinates, 
  aes(long, lat, map_id = region), color="Black", fill="white", size=0.1
)+geom_point( 
  data = all_locality, 
  aes(Long_DMS, Lat_DMS, color = Altitude, size =0.5,shape = factor(Order)), 
  alpha = 1,  size=4 # plots longitude and latitude on our map
)+xlab("Longitude")+ylab("Latitude"#labels the axis
)+theme(text = element_text(size = 23)#changes font of y and x-axis labels
)+theme(axis.text = element_text(size = 20)
)+theme(axis.text = element_text(size = 15))+  theme(legend.title = element_text(size=15))+theme(legend.text = element_text(size=10))
allplot+scale_color_gradient(low="blue", high="red")

pdf(file="/Users/fpi10kg/Documents/1_SMP_ANALYSIS_2024/Rstudio_ALL/World_map_Altitude_ALL_7JUNE24.pdf", width=15, height=10)
allplot+scale_color_gradient(low="blue", high="red")
dev.off()

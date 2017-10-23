library(riverplot)
library(dplyr)
library(RCurl)

#example given in package
data(minard)

nodes <- minard$nodes
edges <- minard$edges
colnames( nodes ) <- c( "ID", "x", "y" )
colnames( edges ) <- c( "N1", "N2", "Value", "direction" )

rp <- makeRiver(nodes, edges)
plot(rp)

# download mussel data from VButitta github
# db <- read.csv("C:/Users/Vincent/Dropbox/Global status of freshwater mussels/DATA/IUCN_status_test.csv", stringsAsFactors = F)

x <- getURL("https://raw.githubusercontent.com/vbutitta/GlobalMusselStatus/master/IUCN_status_test.csv")
db <- read.csv(text = x)

head(db)
str(db)

dbedgest <- db[,c(6,4,5)]
dbedgest2 <- dbedgest[complete.cases(dbedgest),]

agdb <- dbedgest2 %>% 
group_by(Status_williams93) %>% 
count(status_IUCN2017)

ID <- c(1:length(agdb$n))
n <- cbind(as.data.frame(agdb),ID)
colnames( agdb2 ) <- c( "N1", "N2", "Value", "ID" )

nodes = data.frame(ID = c('EXT','E','T','SC','CS','U','EX','CR','EN','VU','NT','LC','DD'))

x <- c(1,1,1,1,1,1,2,2,2,2,2,2,2)  #tell it which column the nodes belong to
# y <- c(1,3,4,5,6,7,1,2,3,4,5,6,7)  #y not necessary, but can be specified

nodes2 <- cbind(nodes, x)
# nodes2 <- cbind(nodes, x, y) # append y here if used

nodes2$col <- c("black", "red", "orange", "yellow", "green", "gray", "black", "red", "red", "orange", "yellow",'green', 'gray') # give nodes a color, nodes love colors


rptest <- makeRiver(nodes2, agdb2)

# png("C:/Users/Vincent/Dropbox/Global status of freshwater mussels/N.Am.status_test.png")
riverplot(rptest)
# dev.off()

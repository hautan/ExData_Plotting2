rm(list=ls())


source("Helper/fileReader.R")
getInputData()

sccSubset <- subset(SCC, select = c("SCC", "Short.Name"))
neiScc <- merge(NEI, sccSubset, by.x="SCC", by.y="SCC", all=TRUE)


subsetCC <- subset(neiScc, grepl('Coal',neiScc$Short.Name, fixed=TRUE), c("Emissions", "year","type", "Short.Name"))

library(ggplot2)
library(reshape2)

totalEmission <- aggregate(Emissions ~ year, subsetCC, sum)	

png("plot3.png",width=480,height=480,units="px",bg="transparent")
ggp <- ggplot(data=totalEmission, aes(x=year, y=Emissions)) + geom_line() + geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("otal PM'[2.5]* Emission") + ggtitle("Total United States PM2.5 Coal Emissions")
    
print(ggp)
dev.off()
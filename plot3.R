rm(list=ls())


source("Helper/fileReader.R")
getInputData()

sccSubset <- subset(SCC, select = c("SCC", "Short.Name"))
neiScc <- merge(NEI, sccSubset, by.x="SCC", by.y="SCC", all=TRUE)

#Baltimore City, Maryland (fips == "24510") 
subsetBaltimore <- neiScc[neiScc$fips == "24510", c("Emissions", "year","type")] 

library(ggplot2)
library(reshape2)

subsetBaltimore <- melt(subsetBaltimore, id=c("year", "type"), measure.vars=c("Emissions"))
subsetBaltimore <- dcast(subsetBaltimore, year + type ~ variable, sum)		


png("plot3.png",width=480,height=480,units="px",bg="transparent")
ggp <- ggplot(data=subsetBaltimore, aes(x=year, y=Emissions, group=type, color=type)) + geom_line() + geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Total PM'[2.5]* Emission") + ggtitle("Total Baltimore PM2.5 Emissions By Type and Year")
       
print(ggp)
dev.off()
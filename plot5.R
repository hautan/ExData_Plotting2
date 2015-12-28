rm(list=ls())


source("Helper/fileReader.R")
getInputData()

sccSubset <- subset(SCC, select = c("SCC", "Short.Name"))
neiScc <- merge(NEI, sccSubset, by.x="SCC", by.y="SCC", all=TRUE)

#Baltimore City, Maryland (fips == "24510") the type ON-ROAD = motor vehicle emissions. 
subsetBaltimore <- neiScc[neiScc$fips == "24510" & neiScc$type =="ON-ROAD", c("Emissions", "year","type")] 

library(ggplot2)
library(reshape2)

#aggregate by year
subsetBaltimore <- aggregate(Emissions ~ year, subsetBaltimore, sum)


png("plot5.png",width=480,height=480,units="px",bg="transparent")
ggp <- ggplot(data=plot_5, aes(x=year, y=Emissions)) + geom_line() + geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Total PM'[2.5]* Emission") + ggtitle("Motor Vehicle Source PM2.5 Emissions in Baltimore")
        
print(ggp)
dev.off()

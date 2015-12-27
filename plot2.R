rm(list=ls())
source("Helper/fileReader.R")
getInputData()

sccSubset <- subset(SCC, select = c("SCC", "Short.Name"))
neiScc <- merge(NEI, sccSubset, by.x="SCC", by.y="SCC", all=TRUE)

#Baltimore City, Maryland (fips == "24510") 
subsetBaltimore <- neiScc[neiScc$fips == "24510", ] 
head(neiScc)

totalEmission <- aggregate(Emissions ~ year, subsetBaltimore, sum)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(totalEmission$year,totalEmission$Emissions, type = "l", main="Total Baltimore PM2.5 Emissions", xlab="Year", ylab="Total PM'[2.5]* Emission",xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))
dev.off()

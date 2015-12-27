rm(list=ls())
source("Helper/fileReader.R")
getInputData()

sccSubset <- subset(SCC, select = c("SCC", "Short.Name"))
neiScc <- merge(NEI, sccSubset, by.x="SCC", by.y="SCC", all=TRUE)
head(neiScc)

totalEmission <- aggregate(Emissions ~ year, neiScc, sum)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot1.png", width = 480, height = 480, units = "px")
plot(totalEmission$year,totalEmission$Emissions, type = "l", main="Total US PM2.5 Emissions", xlab="Year", ylab="Total PM'[2.5]* Emission")
dev.off()

#Exploratory Data Analysis - Johns Hopkins Bloomberg School of Public Health - Coursera
#Project 2
#Plot 5
#----------------------------------------------------------------------------------------------------------------------
library(ggplot2)
#This section is dedicated to load the data in the right format:
if (!file.exists("data")){
    dir.create("data")
}

if(!file.exists("./data/summarySCC_PM25.rds"))
{
    if (!file.exists("./data/exdata-data-NEI_data.zip")){
        furl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(furl, "./data/exdata-data-NEI_data.zip", method = "curl")
        dateDownloaded <- date()
    }
    unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")
}

if(!exists("NEI"))
{
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
baltiNEI <- NEI[NEI$fips=="24510" & NEI$type == "ON-ROAD" ,]
totalByYear <- aggregate(Emissions ~ year, baltiNEI, sum)

png("plot5.png", width = 840, height = 480)
g <- ggplot(totalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + xlab("Year") + ylab(expression('Total PM'[2.5]*" emissions")) +
    ggtitle("Total Emissions from Motor Vehicles in Baltimore, MD from 1999 to 2008")
print(g)
dev.off()
#Exploratory Data Analysis - Johns Hopkins Bloomberg School of Public Health - Coursera
#Project 2
#Plot 3
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
if(!exists("SCC"))
{
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

comb <- merge(NEI, SCC, by="SCC")

coal <- grepl("coal", comb$Short.Name, ignore.case = TRUE)
coalComb <- comb[coal,]

totalByYear <- aggregate(Emissions ~ year, coalComb, sum)

png('plot4.png')
g <- ggplot(totalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + xlab("Year") + ylab(expression('Total PM'[2.5]*" emissions")) +
    ggtitle("Total Emissions from coal sources from 1999 to 2008")
print(g)
dev.off()
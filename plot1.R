#Exploratory Data Analysis - Johns Hopkins Bloomberg School of Public Health - Coursera
#Project 2
#Plot 1
#----------------------------------------------------------------------------------------------------------------------
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
totalByYear <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height = totalByYear$Emissions, names.arg = totalByYear$year, xlab = "Years", ylab = expression('Total PM'[2.5]*' emissions'))
dev.off()
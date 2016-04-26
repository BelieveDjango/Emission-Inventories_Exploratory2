##downloading the data into R

require(downloader)

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "C:/Apps/python/R/data.zip", mode = "wb")

unzip ("C:/Apps/python/R/data.zip", exdir="C:/Apps/python/R/dataReady")

##Loading the file inot R

NEI <- readRDS("C:/Apps/python/R/dataReady/summarySCC_PM25.rds")
SCC <- readRDS("C:/Apps/python/R/dataReady/Source_Classification_Code.rds")
findata <- with (NEI, aggregate(Emissions, by =list(year), sum))


## Examine the Decrease in PM2.5 Emissions:199-2008
##Plot 1

plot(findata, type = "o", main ="Total PM2.5 Emissions", xlab= "Year", ylab= "PM2.5", pch =19, col= "Purple", lty=6)
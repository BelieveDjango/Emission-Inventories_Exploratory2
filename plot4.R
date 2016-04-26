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


##Plot 2: for Baltimore County

sub1 <- subset(NEI, fips == "24510")
balt <- tapply(sub1$Emissions, sub1$year, sum)
plot(balt, type = "o", main = "Total PM2.5 Emissions in Baltimore County", xlab = "Year", ylab = "PM2.5 Emissions", pch = 18, col = "Purple", lty = 5)

##Plot 3:Examining Fluctuations in PM2.% Emiisions in Baltimore County

library(ggplot2)
sub2 <- subset(NEI, fips == "24510")
balt.sources <- aggregate(sub2[c("Emissions")], list(type = sub2$type, year = sub2$year), sum)
qplot(year, Emissions, data = balt.sources, color = type, geom= "line")+ ggtitle("Total PM2.5 Emissions in Baltimore County by Source Type") + xlab("Year") + ylab("PM2.5 Emissions")


## Plot 4: Looking at Changes in Coal-Related Emissions: 1999-2008

SCC.sub <- SCC[grepl("Coal" , SCC$Short.Name), ]
NEI.sub <- NEI[NEI$SCC %in% SCC.sub$SCC, ]
plot4 <- ggplot(NEI.sub, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) + xlab("year") +ylab("Coal-Related PM2.5 Emissions") + ggtitle("Total Coal-Related PM2.5 Emissions")
print(plot4)
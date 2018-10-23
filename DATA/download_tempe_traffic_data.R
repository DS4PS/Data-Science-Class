
library( dplyr )
library( scales )


d <- read.csv( "https://data.tempe.gov/dataset/7556b322-1b7d-4f65-87b8-598d11ef50fb/resource/6e542152-245b-4773-ba10-dc3223177e3b/download/crashdatareport.csv" )

d <- read.csv( "", stringsAsFactors=F )

d <- filter( d, Latitude > 33.3 )

plot( d$Longitude, d$Latitude, pch=20, cex=0.3 )

color <- ifelse( d$Totalinjuries > 0, "red", "gray" )
color <- alpha( color, alpha=0.05 )
my.cex <- ifelse( d$Totalinjuries > 0, 0.6, 0.3 )

plot( d$Longitude, d$Latitude, pch=20, col=color, cex=1 )

color <- ifelse( d$Totalinjuries > 0, "red", NA )
color <- alpha( color, alpha=0.05 )
plot( d$Longitude, d$Latitude, pch=20, col=color, cex=1 )


### Identify locations with multiple crashes

d$coords <- paste( d$Latitude, d$Longitude, sep="x" )
table( table( coords ) )

d <- add_count( d, coords )
d2 <- filter( d, n > 2 )
plot( d2$Longitude, d2$Latitude, pch=20, col=gray(0.5,0.01), cex=3 )




### DEMOGRAPHIC ANALYSIS


head( d )

d$Age_Drv2[ d$Age_Drv2 > 100 | d$Age_Drv2 < 14 ] <- NA
hist( d$Age_Drv2, breaks=90, col="gray", border="white" )

sum( d$Totalinjuries > 0 )

sum( d$Totalfatalities > 0 )


age <- cut( d$Age_Drv1, breaks=seq(10,100,10), paste0( seq(10,90,10), "-", seq(21,101,10) ) )

prop.table( table( age, d$Collisionmanner ), margin=1 ) %>% round(2)

prop.table( table( age, d$Lightcondition ), margin=1 ) %>% round(2)

prop.table( table( age, d$Violation1_Drv1 ), margin=1 ) %>% round(2)

prop.table( table( d$Gender_Drv1, d$Gender_Drv2 ) ) %>% round()

saveRDS( d, "TempeTrafficAccidents.rds" )
write.csv( d, "TempeTrafficAccidents.csv", row.names=F )


# create a grid, count accidents using loops 
# first loop just slice map by longitude






#### DASHBOARD

Filters

- day of week (check boxes)
- hour of day (slider)
- month of year (check boxes)

- severity (no injury, injury, fatality)
- involve alcohol (driver 1, drive 2)

Analysis:

- map (size=number hurt, col=injuries/fatalities)
- barplot type of accident
- histogram age of driver


Animation - accidents by time of day

Injuries by time of day
Injuries by day of week
Injuries by age groups
Injuries by 



####################   EXRACT DATES AND TIMES


path <- "C:/Users/jdlecy/Dropbox/02 - CLASSES/03 - PEDA/Data-Science-Class/DATA"

normalizePath( path )

setwd( normalizePath( path ) )

dir()


d <- readRDS( "TempeTrafficAccidents.rds" )

d$DateTime <- as.character( d$DateTime )
vec <- as.Date( d$DateTime, format="%m/%d/%y %H:%M" )

vec <- strptime( d$DateTime, format="%m/%d/%y %H:%M" )


head( vec )


vec <- as.Date( d$DateTime )



format( head( vec ), format="%H" )  # hour of day 0-23
 
format( head( vec ), format="%m" )  # month 1-12

format( head( vec ), format="%b" )  # abbreviated month Jan, Feb, etc

format( head( vec ), format="%A" )  # day of the week Monday, Tuesday, etc.

format( head( vec ), format="%a" )  # abbreviated day of the week Mon, Tue, etc.






strsplit( head(d$DateTime), split="///" )



times <- strSplit( head(d$DateTime), split="//" )



these <- strsplit( d$DateTime, split="\\/|:|[[:space:]]" )
table( sapply( these, length ) ) # all are same length

rename.x <- function(x)
{ 
  names(x) <- c("month","day","year","hour","minute")
  return(x) 
}

these3 <- lapply( these, rename.x )
df <- do.call( rbind, these3 )
df <- as.data.frame(df)

table( df$month )
table( df$hour )

barplot( table( factor(df$hour, levels=23:0) ), horiz=T, las=1 )

barplot( table( factor(df$month, levels=12:1) ), horiz=T, las=1 )



as.Date( dat$Violation.Date, format="%m/%d/%Y" )






d <- cbind( d, df )

d$hour <- factor( d$hour, levels=0:23 )

t1 <- table( d$Injuryseverity, d$hour )

barplot( t1, beside=F , col=c("red","orange","white","gray","gray") )

d$weekday <- format( vec, format="%a" )
d$weekday <- factor( d$weekday, levels=c("Mon","Tue","Wed","Thu","Fri","Sat","Sun") )

d2 <- filter( d, Injuryseverity == "Fatal" )
barplot( table(d2$hour ) )
barplot( table(d2$weekday ) )

table( d2$hour, d2$weekday )

dd <- count( d2, hour, weekday )

plot( as.numeric(dd$weekday), as.numeric(dd$hour), cex=dd$n, pch=19 )



d3 <- filter( d, Injuryseverity %in% c("Fatal","Incapacitating Injury") )
barplot( table(d3$hour ) )


d4 <- filter( d, Injuryseverity == "Incapacitating Injury" )
barplot( table(d4$hour ) )



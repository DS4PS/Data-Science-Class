
library( dplyr )
library( scales )


d <- read.csv( "https://data.tempe.gov/dataset/7556b322-1b7d-4f65-87b8-598d11ef50fb/resource/6e542152-245b-4773-ba10-dc3223177e3b/download/crashdatareport.csv" )

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

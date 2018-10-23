library( dplyr )

# FROM NCCS


#########  2000

d1 <- read.csv( "https://nccs-data.urban.org/data/core/2010/nccs.core2010pc.csv", stringsAsFactors=F )

names(d1) <- toupper( names(d1) )

d10 <- d1

d1 <- select( d1, EIN, NAME, ADDRESS, CITY, STATE, ZIP5, FIPS, MSA_NECH,
              NTMAJ12, NTEE1, LEVEL1, LEVEL2, LEVEL3, LEVEL4, MAJGRPB,
              TOTREV2, EXPS, ASS_EOY, RULEDATE, LONGITUDE, LATITUDE )

d1$MSA_NECH[ d1$MSA_NECH == 0 ] <- NA

d1$CITY_STATE <- paste( d1$CITY, d1$STATE, sep=", " )

msa_names <- 
d1 %>%
group_by( MSA_NECH ) %>%
count( CITY_STATE ) %>%
arrange( MSA_NECH, - n ) %>%
top_n(1)

msa_names <- 
msa_names %>%
filter( n > 1, (! is.na(MSA_NECH)) ) %>%
rename( MSA = CITY_STATE ) %>%
select( MSA_NECH, MSA ) 

d1 <- merge( d1, msa_names, all.x=TRUE, sort=FALSE )
d1 <- select( d1, - CITY_STATE )
d1$MSA[ is.na(d1$MSA) ] <- "RURAL"

d1$URBAN <- d1$MSA != "RURAL"

d1$RULEDATE <- substr( d1$RULEDATE, 1, 4 )


d1 <- rename( d1, REVENUE=TOTREV2, EXPENSES=EXPS, ASSETS=ASS_EOY )





write.csv( d1, "nonprofits_2010.csv", row.names=F )




#########  2000

d2 <- read.csv( "https://nccs-data.urban.org/data/core/2000/nccs.core2000pc.csv", stringsAsFactors=F )

names(d2) <- toupper( names(d2) )

d20 <- d2

d2 <- select( d2, EIN, NAME, ADDRESS, CITY, STATE, ZIP5, FIPS, MSA_NECH,
              NTMAJ12, NTEE1, LEVEL1, LEVEL2, LEVEL3, LEVEL4, MAJGRPB,
              TOTREV2, EXPS, ASS_EOY, RULEDATE )

d2$MSA_NECH[ d2$MSA_NECH == 0 ] <- NA

d2 <- merge( d2, msa_names, all.x=TRUE, sort=FALSE )

d2$MSA[ is.na(d2$MSA) ] <- "RURAL"

d2$URBAN <- d2$MSA != "RURAL"

d2$RULEDATE <- substr( d2$RULEDATE, 1, 4 )


d2 <- rename( d2, REVENUE=TOTREV2, EXPENSES=EXPS, ASSETS=ASS_EOY )





#### STACK

d1$YEAR <- 2010
d2$YEAR <- 2000
d2$FIPS <- substr( 1000000 + as.numeric(d2$FIPS), 3, 7 )
d2$LONGITUDE <- NA
d2$LATITUDE <- NA

# d3 <- rbind( d2, d1 )

d1$NTMAJ12 <- recode( d1$NTMAJ12, AR="ARTS", BH="UNIVERSITIES", ED="EDUCATION", EH="HOSPITALS", 
                      EN="ENVIRONMENT", HE="HEALTH", HU="HUMAN_SERVICES", IN="INTERNATIONAL", 
                      MU="MUTUAL_BENEFIT", PU="PUBLIC_BENEFIT", RE="RELIGION", UN="UNKNOWN" ) 

d2$NTMAJ12 <- recode( d2$NTMAJ12, AR="ARTS", BH="UNIVERSITIES", ED="EDUCATION", EH="HOSPITALS", 
                      EN="ENVIRONMENT", HE="HEALTH", HU="HUMAN_SERVICES", IN="INTERNATIONAL", 
                      MU="MUTUAL_BENEFIT", PU="PUBLIC_BENEFIT", RE="RELIGION", UN="UNKNOWN" ) 

# AR	Arts, culture, and humanities
# BH	Education, higher
# ED	Education
# EH	Hospitals
# EN	Environment
# HE	Health
# HU	Human services
# IN	International
# MU	Mutual benefit
# PU	Public and societal benefit
# RE	Religion
# UN	Unknown


write.csv( d3, "nonprofits_2000_2010.csv", row.names=F )
write.csv( d1, "nonprofits_2010.csv", row.names=F )
write.csv( d2, "nonprofits_2000.csv", row.names=F )







# MSA NAMES

dat <- read.table( "clipboard", sep="\t", stringsAsFactors=F, header=TRUE )
dat <- dat[ !is.na(dat$MSA_FIPS) , ]
dat <- dat[ ! duplicated( dat$MSA_FIPS ) , ]
dat <- select( dat, MSA_FIPS, NAME )

dput( dat )


setdiff( d1$MSA_NECH, dat$MSA_FIPS )



d11 <- filter( d1, MSA_NECH == "1123" )
table( d11$CITY ) %>% sort()




mutate( MSA = mode( CITY )



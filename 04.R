
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")

## data file from mapreduce to get 4 unique "station" columns
bike_stations <- read.csv("unique_stations_to_txt_file.txt", header=FALSE, stringsAsFactors = FALSE)
column_names <- c("station_id", "station_name", "station_lat", "station_long")
names(bike_stations) = column_names
View(bike_stations)

##524 unique combinations
nrow(bike_stations)

## Only 498 unique IDs (so 26 repeats to investigate)
length(unique(bike_stations$station_id))
## some happen because field needs to trim whitespace
for(i in 1:4)
{
  bike_stations[,i] <- trimws(bike_stations[,i])
}
repeats <- bike_stations[duplicated(bike_stations$station_id),1]

View(bike_stations[bike_stations$station_id %in% repeats,])

## clean up id 151
bike_stations$station_lat <- ifelse(bike_stations$station_id==151,40.7218158,bike_stations$station_lat)
bike_stations$station_long <- ifelse(bike_stations$station_id==151,-73.99720307,bike_stations$station_long)
## clean up id 153
bike_stations$station_lat <- ifelse(bike_stations$station_id==153,40.75206231,bike_stations$station_lat)
bike_stations$station_long <- ifelse(bike_stations$station_id==153,-73.9816324,bike_stations$station_long)
## clean up id 2003
bike_stations$station_lat <- ifelse(bike_stations$station_id==2003,40.73381219,bike_stations$station_lat)
bike_stations$station_long <- ifelse(bike_stations$station_id==2003,-73.98054421,bike_stations$station_long)
## clean up id 2022  could be on either side of bridge
bike_stations$station_lat <- ifelse(bike_stations$station_id==2022,40.75849116,bike_stations$station_lat)
bike_stations$station_long <- ifelse(bike_stations$station_id==2022,-73.95920622,bike_stations$station_long)
bike_stations$station_name <- ifelse(bike_stations$station_id==2022,"E 60 St & York Ave",bike_stations$station_name)

### and for the rest (228, 233, 242, 262, 271, 284, 347, 384, 388, 396, 437, 443, 521, 540, 3120, 3133, 3139, 3165, 3166)
bike_stations$station_lat <- ifelse(bike_stations$station_id==228,40.7546011,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==233,40.69475701,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==242,40.697787,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==262,40.6917823,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==271,40.68528172,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==284,40.73901691,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==3120,40.74161,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==3133,40.76735637,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==3139,40.77122923,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==3165,40.77575319,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==3166,40.7805779901033,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==347,40.728846,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==384,40.683048,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==388,40.74971775,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==396,40.68034242,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==437,40.68098339,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==443,40.70853074,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==521,40.75096735,bike_stations$station_lat)
bike_stations$station_lat <- ifelse(bike_stations$station_id==540,40.74147286,bike_stations$station_lat)
bike_stations$station_long <- ifelse(bike_stations$station_id==228,-73.97187886,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==233,-73.99052739,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==242,-73.973736,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==262,-73.9737299,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==271,-73.97805813,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==284,-74.00263761,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==3120,-73.96044,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==3133,-73.96493528,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==3139,-73.96432627,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==3165,-73.97603963,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==3166,-73.9856243133545,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==347,-74.008591,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==384,-73.964915,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==388,-74.00295035,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==396,-73.95576894,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==437,-73.95004798,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==443,-73.96408963,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==521,-73.99444208,bike_stations$station_long)
bike_stations$station_long <- ifelse(bike_stations$station_id==540,-73.98320928,bike_stations$station_long)
bike_stations$station_name <- ifelse(bike_stations$station_id==233,"Cadman Plaza W & Pierrepont St",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==242,"Carlton Ave & Flushing Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==262,"Washington Park",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==271,"Ashland Pl & Hanson Pl",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==284,"Greenwich Ave & 8 Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==3120,"Center Blvd & Borden Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==3133,"E 67 St & Park Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==3139,"E 72 St & Park Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==3165,"Central Park West & W 72 St",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==3166,"Riverside Dr & W 72 St",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==347,"Greenwich St & W Houston St",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==384,"Fulton St & Washington Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==388,"W 26 St & 10 Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==396,"Lefferts Pl & Franklin Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==437,"Macon St & Nostrand Ave",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==443,"Bedford Ave & S 9 St",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==521,"8 Ave & W 31 St",bike_stations$station_name)
bike_stations$station_name <- ifelse(bike_stations$station_id==540,"Lexington Ave & E 26 St",bike_stations$station_name)



## keep only unique rows
bike_stations$x = 1  ## used in ddply function as dummy to make work
library(plyr)
groupColumns <- c(1:4)
dataColumns <- c(5)
master <- as.data.frame(ddply(bike_stations, groupColumns, function(bike_stations) colSums(bike_stations[dataColumns])))[,c(1:4)]
View(master)
nrow(master) == length(unique(master$station_id))  ## true because we now have unique rows

#send out to a file to be used later
master$station_id = as.integer(master$station_id)
master$station_lat = as.numeric(master$station_lat)
master$station_long = as.numeric(master$station_long)
write.csv(master,"unique_stations.csv",row.names = FALSE)


### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
bike_stations <- read.csv("unique_stations_to_txt_file.txt", header=FALSE, stringsAsFactors = FALSE)
column_names <- c("station_id", "station_name", "station_lat", "station_long")
names(bike_stations) = column_names
View(bike_stations)

#SHOWS IT WAS ONLY LIKE .02MILES ignore for simplicity
#151 Cleveland Pl & Spring St 40.72182 73.99720
#151 Cleveland Pl & Spring St 40.72210 -73.99725
   d_ew = (-73.99720 - -73.99725) * cos(40.72182*2 *pi /360)
   d_ns = (40.72182 - 40.72210)
   distance <-(sqrt(d_ew * d_ew + d_ns * d_ns)*69.17181)

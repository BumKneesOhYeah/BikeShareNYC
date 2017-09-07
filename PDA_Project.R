setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Ubuntu_shared/BikeData")
dir()
bikes = read.csv("201501-citibike-tripdata.csv", stringsAsFactors = FALSE, header = TRUE)
View(bikes)
summary(bikes)

43023/60/24

#####################################################################################33

#trip duration
hist(bikes[bikes$tripduration/360,1])
hist(bikes[(bikes$tripduration/360)<6,1]/360,xlab="Hours",ylab = "Rentals",main="Rentals/Hour for Jan 2015",axes = FALSE,col = "orange",breaks = seq(0,6,.25),ylim = c(0,40000),xlim = c(0,6))
axis(side = 1,at=seq(0,6,.25))
axis(side = 2,at=seq(0,40000,5000),las=2,cex.axis=.7) +grid(col="green")

hist(bikes[(bikes$tripduration/360)>=6,1]/360,xlab="Hours",ylab = "Rentals",main="Rentals/Hour for Jan 2015",axes = FALSE,col = "orange",breaks = 10,ylim = c(0,3000),xlim = c(6,42))
axis(side = 1,at=seq(6,42,6))
axis(side = 2,at=seq(0,3000,500),las=2,cex.axis=.7) +grid(col="green")

dim(bikes)
#less that 6 hours and over
(length(bikes[(bikes$tripduration/360)<6,1]/360))/285552
(length(bikes[(bikes$tripduration/360)>=6,1]/360))/285552
#max hour
max(bikes$tripduration)/360
#min minute
min(bikes$tripduration)

#station ids
x =as.data.frame(stack(bikes, select=c(start.station.id,end.station.id)))
length(unique(x$values))
x =as.data.frame(stack(bikes, select=c(start.station.name,end.station.name)))
length(unique(x$values))

#bike ids
length(unique(bikes$bikeid))

#birth year
hist(bikes$birth.year)
hist(2015-bikes$birth.year)
hist(2015-bikes[(2015 - bikes$birth.year) > 80,14])
length((bikes[(bikes$birth.year <= 1935& !is.na(bikes$birth.year)),14]))/285552
length((bikes[(bikes$birth.year > 1935& !is.na(bikes$birth.year)),14]))/285552
length((bikes[is.na(bikes$birth.year),14]))/285552

#gender
table(bikes$gender,useNA = "ifany")
prop.table(table(bikes$gender,useNA = "ifany"))

prop.table(table(bikes$usertype,useNA = "ifany"))


#find ax lengths of every field
for (i in 1:15) 
{
  cat(i," - ",names(bikes)[i]," - ")
  cat(min(nchar(bikes[,i]))," to ",max(nchar(bikes[,i])),"\n")
}


#####ADDING 1-12 for stations##########
# setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Ubuntu_shared/BikeData")
# library(plyr)
# dir()
# bikes = read.csv("201501-citibike-tripdata.csv", stringsAsFactors = FALSE, header = TRUE)
# x = bikes[,c(4:11)]
# x$dummy =1
# View(x)
# groupColumns <- c(1:4)
# dataColumns <- c(9)
# master <- as.data.frame(ddply(x, groupColumns, function(x) colSums(x[dataColumns])))
# View(master)
# for( i in 1:4)
# {
#   x[,i]=x[,i+4]
# }
# master <- rbind(master, ddply(x, groupColumns, function(x) colSums(x[dataColumns])))
# 
# for (i in 2:9)
# {
#   string_file = paste("20150",i,"-citibike-tripdata.csv",sep = "")
#   bikes = read.csv(string_file, stringsAsFactors = FALSE, header = TRUE)
#   x = bikes[,c(4:11)]
#   x$dummy =1
#   master <- rbind(master, ddply(x, groupColumns, function(x) colSums(x[dataColumns])))
#   for(i in 1:4)
#   {
#     x[,i]=x[,i+4]
#   }
#   master <- rbind(master, ddply(x, groupColumns, function(x) colSums(x[dataColumns])))
# }
# 
# for (i in 10:12)
# {
#   string_file = paste("2015",i,"-citibike-tripdata.csv",sep = "")
#   bikes = read.csv(string_file, stringsAsFactors = FALSE, header = TRUE)
#   x = bikes[,c(4:11)]
#   x$dummy =1
#   master <- rbind(master, ddply(x, groupColumns, function(x) colSums(x[dataColumns])))
#   for(i in 1:4)
#   {
#     x[,i]=x[,i+4]
#   }
#   master <- rbind(master, ddply(x, groupColumns, function(x) colSums(x[dataColumns])))
# }
# 
# dataColumns <- c (5)
# supermaster <- ddply(master, groupColumns, function(x) colSums(x[dataColumns]))
# View(supermaster)
# ##notice there are some places that aren't unique
# nrow(supermaster)
# (length(unique(supermaster$start.station.name)))
# supermaster[duplicated(supermaster$start.station.id),1]
# 
# (length(unique(supermaster$start.station.id)))
# supermaster[duplicated(supermaster$start.station.name),2]
# 
# (length(unique(supermaster$start.station.latitude)))
# supermaster[duplicated(supermaster$start.station.latitude),3]
# 
# (length(unique(supermaster$start.station.longitude)))
# # supermaster[duplicated(supermaster$start.station.longitude),4]
# duplicated(supermaster$start.station.id)
# 
# write.csv(master,"months1_12.csv",row.names = FALSE)
########################end 7-12################
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")
master = read.csv("months1_12.csv",header = TRUE)


# nrow(bikes)->bikerows
# bikerows
# bikes$distance=1
# for(i in 1:bikerows){
#   d_ew = (bikes$end.station.longitude[i] - bikes$start.station.longitude[i]) * cos(bikes$start.station.latitude[i]*2 *pi /360)
#   d_ns = (bikes$end.station.latitude[i] - bikes$start.station.latitude[i])
#   bikes$distance[i] <-(sqrt(d_ew * d_ew + d_ns * d_ns)*69.17181)
#   }
# 
# 
# x = bikes[,c(2,4,8,13,14,15)]
# View(x)
# str(x$starttime)
# x$starttime = strptime(x$starttime,"%m/%d/%Y %H:%M")
# x$month = format(x$starttime,"%m")
# x$day= format(x$starttime,"%d")
# x$year=2015           
# x$hour = format(x$starttime,"%H")   
# x$date=format(x$starttime,"%m/%d%Y")
# x$event = 1
# x = x[,-1]
# groupColumns <- c(1:2)
# dataColumns <- c(11)
# master <- as.data.frame(ddply(x, groupColumns, function(x) colSums(x[dataColumns])))
# View(master)

### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 

## has soe temperature data 
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")
dir()
bike = read.table("part-r-00000",sep = ",",header = FALSE)
View(bike)
x = c("Month","Day","Hour","eventCount","distance")
names(bike) = x
str(bike)
bike$date=paste(bike$Month,"/",bike$Day,"/2015",sep = "")
##strptime(bike$date,"%m/%d/%Y") -> bike$rrrr
library(plyr)
groupColumns <- c(6)
dataColumns <- c(4:5)
thing = ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
thing$avee = thing$distance/thing$eventCount
View(thing)
plot(thing$eventCount,thing$distance)


plot(strptime(thing$date,"%m/%d/%Y"),thing$avee,ylim = c(0,1.3))

plot(months,temp)

groupColumns <- c(1)
dataColumns <- c(4)
thing = ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
##http://www.weather.gov/media/okx/Climate/CentralPark/monthlyannualtemp.pdf
thing$temp = c(29.9, 23.9, 38.1, 54.3, 68.5, 71.2, 78.8, 79.0, 74.5, 58.0, 52.8, 50.8)

plot(thing$Month,thing$eventCount,type = "l")
plot(thing$temp,thing$eventCount)

### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 

##getting 5% from each data set to see distribution of distances

# setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Ubuntu_shared/BikeData")
# library(plyr)
# 
# dir()
# bikes = read.csv("201501-citibike-tripdata.csv", stringsAsFactors = FALSE, header = TRUE)
# rows_in_bike = nrow(bikes)
# bikes = bikes[,c(2,13,15)]
# bikes = bikes[sample(rows_in_bike, round(rows_in_bike *.05)),]
# master = bikes
# for (i in 2:9)
# {
#   string_file = paste("20150",i,"-citibike-tripdata.csv",sep = "")
#   bikes = read.csv(string_file, stringsAsFactors = FALSE, header = TRUE)
#   rows_in_bike = nrow(bikes)
#   bikes = bikes[,c(2,13,15)]
#   bikes = bikes[sample(rows_in_bike, round(rows_in_bike *.05)),]
#   master <- rbind(master, bikes)
# }
# for (i in 10:12)
# {
#   string_file = paste("2015",i,"-citibike-tripdata.csv",sep = "")
#   bikes = read.csv(string_file, stringsAsFactors = FALSE, header = TRUE)
#   rows_in_bike = nrow(bikes)
#   bikes = bikes[,c(2,13,15)]
#   bikes = bikes[sample(rows_in_bike, round(rows_in_bike *.05)),]
#   master <- rbind(master, bikes)
# }
# View(master)
# write.csv(master,"time_usertype_gender.csv",row.names = FALSE)
# 
# 
# setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Ubuntu_shared/BikeData")
# 
# count = 0
# for(i in 1:9){
#   filepath = paste("20150",i,"-citibike-tripdata.csv",sep = "")
#   bike=read.table(sep = ",", filepath, header = TRUE, colClasses = c(NA, "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL"))
#   count = nrow(bike) + count
# }
# 
# for(i in 10:12){
#   filepath = paste("2015",i,"-citibike-tripdata.csv",sep = "")
#   bike=read.table(sep = ",", filepath, header = TRUE, colClasses = c(NA, "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL"))
#   count = nrow(bike) + count
# }
# count
# ##needs to be fixed becse a cpy
# ##################################3 the results from MAP REDUCE
# ##distances =read.delim("part-r-00000",sep = "\t")
# 
# plot(distances)
# sum_dist = sum(distances$X11032)
# distances$prob = distances$X11032/sum_dist
# View(distances)
# plot(distances$X0.0,distances$prob)
# plot(distances$X0.0,distances$prob,type="l")
# 
# distances$inThous = distances$X11032/1000
# plot(distances$X0.0,distances$inThous*20,type="l",xlab="Distance Used (miles)", ylab="Estimated Frequency (in thousands)",main="Estimate Rentals by Distance", xlim = c(0,9.25),ylim=c(0,100),axes = FALSE)
# axis(side = 1,at=seq(0,9,.5),cex.axis=.7)
# axis(side = 2,at=seq(0,100,25),las=2,cex.axis=.7) + grid()
# 
# 
# 
# #get sd and meanaxis(side = 2,at=seq(0,100,25),las=2,cex.axis=.7) + grid()
# total_count = sum(distances$X11032)*1000
# ##to get mean
# distances$mean_helper=distances$X0.0*distances$X11032*1000
# the_mean = sum(distances$mean_helper) / total_count
# ##to help SD
# distances$sd_helper =(the_mean - distances$X0.0)^2 * distances$X11032 * 1000
# the_sd = sum(distances$sd_helper) / (total_count -1)
# the_sd = sqrt(the_sd)
# paste("mean is",the_mean,"the SD",the_sd)
# 
# ############now for using that data!!!!!!!1

### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 


setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")

## data file from mapreduce to get 4 unique "station" columns
bike_stations <- read.csv("part-r-00000_stationsMR.txt", header=FALSE, stringsAsFactors = FALSE)
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

##getting 5% from each data set to see distribution of distances

# setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Ubuntu_shared/BikeData")
# library(plyr)
# 
# dir()
# bikes = read.csv("201501-citibike-tripdata.csv", stringsAsFactors = FALSE, header = TRUE)
# rows_in_bike = nrow(bikes)
# bikes = bikes[,c(6,7,10,11)]
# bikes = bikes[sample(rows_in_bike, round(rows_in_bike *.05)),]
# master = bikes
# for (i in 2:9)
# {
#   string_file = paste("20150",i,"-citibike-tripdata.csv",sep = "")
#   bikes = read.csv(string_file, stringsAsFactors = FALSE, header = TRUE)
#   rows_in_bike = nrow(bikes)
#   bikes = bikes[,c(6,7,10,11)]
#   bikes = bikes[sample(rows_in_bike, round(rows_in_bike *.05)),]
#   master <- rbind(master, bikes)
# }
# for (i in 10:12)
# {
#   string_file = paste("2015",i,"-citibike-tripdata.csv",sep = "")
#   bikes = read.csv(string_file, stringsAsFactors = FALSE, header = TRUE)
#   rows_in_bike = nrow(bikes)
#   bikes = bikes[,c(6,7,10,11)]
#   bikes = bikes[sample(rows_in_bike, round(rows_in_bike *.05)),]
#   master <- rbind(master, bikes)
# }
# View(master)
# write.csv(master,"lat_long_5_percent.csv",row.names = FALSE)
# 
# 
# 
# 
# ##################################3 the results from MAP REDUCE
# distances =read.delim("part-r-00000",sep = "\t")
# plot(distances)
# sum_dist = sum(distances$X11032)
# distances$prob = distances$X11032/sum_dist
# View(distances)
# plot(distances$X0.0,distances$prob)
# plot(distances$X0.0,distances$prob,type="l")
# 
# distances$inThous = distances$X11032/1000
# plot(distances$X0.0,distances$inThous*20,type="l",xlab="Distance Used (miles)", ylab="Estimated Frequency (in thousands)",main="Estimate Rentals by Distance", xlim = c(0,9.25),ylim=c(0,100),axes = FALSE)
# axis(side = 1,at=seq(0,9,.5),cex.axis=.7)
# axis(side = 2,at=seq(0,100,25),las=2,cex.axis=.7) + grid()
# 
# 
# 
# #get sd and meanaxis(side = 2,at=seq(0,100,25),las=2,cex.axis=.7) + grid()
# total_count = sum(distances$X11032)*1000
# ##to get mean
# distances$mean_helper=distances$X0.0*distances$X11032*1000
# the_mean = sum(distances$mean_helper) / total_count
# ##to help SD
# distances$sd_helper =(the_mean - distances$X0.0)^2 * distances$X11032 * 1000
# the_sd = sum(distances$sd_helper) / (total_count -1)
# the_sd = sqrt(the_sd)
# paste("mean is",the_mean,"the SD",the_sd)

############now for using that data!!!!!!!1


### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 


setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject/By time_durations")
dir()
bike = read.csv("durations.csv",header = FALSE)
View(bike)
bike$ave=bike$V5/bike$V6/60
str(bike)
bike$thing=paste(bike$V1,bike$V2,bike$V3,sep = "/")
bike$thing=paste(bike$thing," ",bike$V4,":00",sep = "")
plot(strptime(bike[bike$V1==1,8],"%m/%d/%Y %H:%M"),bike[bike$V1==1,7],)
########################################3
plot(strptime(bike$thing,"%m/%d/%Y %H:%M"),bike$ave,xlab="Date",ylab = "Ave. Rental Time (minutes)",main="Average Rental Time per Day",yaxt="n",ylim = c(0,400))
axis(side=2,at=seq(0,400,25))
############################################
####Importannt durationsplot1
plot(strptime(bike$thing,"%m/%d/%Y %H:%M"),bike$ave,ylim = c(0,30))
library(plyr)

groupColumns <- c(4)
dataColumns <- c(5,6)
x =ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
View(x)
plot(x$V4,x$V5/x$V6/60,ylim = c(0,20))

groupColumns <- c(1)
dataColumns <- c(5,6)
x =ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
View(x)
plot(x$V1,x$V5/x$V6/60,ylim = c(0,20))

groupColumns <- c(1,4)
dataColumns <- c(5,6)
x =ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
View(x)
paste(x$V1,"/1/2015 ",x$V4,":11")
plot(strptime(paste(x$V1,"/01/2015 ",x$V4,":11",sep = ""),"%m/%d/%Y %H:%M"),x$V5/x$V6/60)



#################histogram time
dir()

bike = read.csv("DurationsCounts_Minute_.csv",header = FALSE)
View(bike)
str(bike)
plot(bike$V1,bike$V2,xlim = c(0,1000))
hist(rep(bike[bike$V1<100,1],bike[bike$V1<100,2]))
sum(bike$V2)->rentals
min(bike$V1)
max(bike$V1)
paste("% rentals in 1:15 minutes ",sum(bike[bike$V1<=15,2])/rentals*100,"%",sep = "")
paste("% rentals in 15:30 minutes ",sum(bike[bike$V1>15 & bike$V1<=30,2])/rentals*100,"%",sep = "")
paste("% rentals in 45:60 minutes ",sum(bike[bike$V1>45 & bike$V1<=60,2])/rentals*100,"%",sep = "")
paste("% rentals in 60:120 minutes ",sum(bike[bike$V1>60 & bike$V1<=120,2])/rentals*100,"%",sep = "")
paste("% rentals in 120:240 minutes ",sum(bike[bike$V1>120 & bike$V1<=240,2])/rentals*100,"%",sep = "")
paste("% rentals in 240 and greater minutes ",sum(bike[bike$V1>240,2])/rentals*100,"%",sep = "")

paste("% rentals in 60 or over minutes ",sum(bike[bike$V1>60,2])/rentals*100,"%",sep = "")

hist(rep(bike[bike$V1<=60,1],bike[bike$V1<=60,2]))
plot(bike$V1,bike$V2,xlim = c(0,60),type="l")
bikeplot = (bike[order(bike$V1),])
bikeplot$V2/1000 ->bikeplot$V2
View(bikeplot)
plot(bikeplot$V1,bikeplot$V2,xlim = c(0,60),type="l",xlab="Rental Length (min.)",ylab = "Number of Rentals (in thousands)",main = "Rental Time Distribution")




###Birth years
dir()
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject/Age_Birth")
bike = read.csv("Age_Count.csv",header = FALSE,stringsAsFactors = FALSE)
View(bike)
bike = bike[order(bike$V1),]
rentals = sum(bike$V3)

names(bike) = c("month","age","count")
as.integer(ifelse(bike$age=="empty","-1",bike$age)) ->bike$age

## total % empty and % over 60
sum(bike[bike$age==-1,3])/rentals*100
sum(bike[bike$age>60,3])/rentals*100

bike$percent_total = bike$count/rentals*100

## rentals per mont
quality = c(1:12)
crap = c(1:12)
mon = c(1:12)
Rental = data.frame(quality,crap,mon)
for (i in 1:12)
{
  Rental$quality[i]=sum(bike[bike$age>0 & bike$age<=60 & bike$month==i,3])
  Rental$crap[i]=sum(bike[(bike$age==-1 | bike$age>60) & bike$month==i,3])
}
View(Rental)
sum(Rental$quality)+sum(Rental$crap)
Rental$quality_perc = Rental$quality/rentals*100
Rental$crap_perc = Rental$crap/rentals*100
sum(Rental$quality_perc)
sum(Rental$crap_perc)

Rental$missing_perc_month = Rental$crap/(Rental$quality+Rental$crap)*100
max(Rental$missing_perc_month)

#Get the amount to erase in new sampling
Rental$amount_needed_removal = round(max(Rental$missing_perc_month) / 100 * (Rental$quality+Rental$crap) - Rental$crap)
View(Rental)

##### THE EXACT % to be removed from each month
Rental$per_remove = max(Rental$missing_perc_month) - Rental$missing_perc_month



### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
 #Bike Use invesitagatio bike = read.csv("Bike_Use.csv",header = FALSE,stringsAsFactors = FALSE)

setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")
bike = read.csv("Bike_Use.csv",header = FALSE,stringsAsFactors = FALSE)


View(bike)
names(bike) = c("bike_id","distance_sum","event_count","trip_duration")
hist(bike$event_count)
bike$dist_per_trip = bike$distance_sum / bike$event_count
hist(bike$dist_per_trip)
hist(bike[bike$dist_per_trip<1.2 & bike$dist_per_trip>.9,5])

bike$minue_per_trip = bike$trip_duration/60/bike$event_count
hist(bike[bike$minue_per_trip<25 & bike$minue_per_trip>7,6])

bike$dist_per_min <- bike$distance_sum/bike$trip_duration/60
hist(bike$event_count)

ppp = bike[sample(nrow(bike),nrow(bike)/847),]
barplot(ppp$event_count,ppp$bike_id)


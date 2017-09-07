## stations and bike investigation
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject/")
dir()

usest = read.csv("Station_Use.csv",header = FALSE,stringsAsFactors = FALSE)
names(usest)= c("Start_Stop","DayOfWeek","Hour","Station_id","event_count")
View(usest)
usest$weekday_end = ifelse(usest$DayOfWeek=="Saturday" | usest$DayOfWeek=="Sunday","Weekend","Weekday")
sum(usest$event_count)
library(plyr)
groupColumns <- c(1,4,6)
dataColumns <- c(5)
bbb =ddply(usest, groupColumns, function(x) colSums(x[dataColumns]))
View(bbb)
par(mfrow=c(1,2))
hist(bbb[bbb$Start_Stop=="stop" & bbb$weekday_end=="Weekday",4])
hist(bbb[bbb$Start_Stop=="stop" & bbb$weekday_end=="Weekend",4])
hist(bbb[bbb$Start_Stop=="start" & bbb$weekday_end=="Weekday",4])
hist(bbb[bbb$Start_Stop=="start" & bbb$weekday_end=="Weekend",4])
uns=read.csv("unique_stations.csv",header = TRUE,stringsAsFactors = FALSE)
View(uns)
names(bbb)[2]="station_id"
merge(bbb,uns,by="station_id")->stations_all
View(stations_all)


creation = read.csv("When_Stations_Created.csv",header = FALSE,stringsAsFactors = F)
names(creation)=c("station_id","date","when")
str(creation)
bcreation = creation[creation$when=="begin",]
names(bcreation)[3]="begin"
names(bcreation)[2]="bdate"
ecreation = creation[creation$when=="end",]
names(ecreation)[3]="end"
names(ecreation)[2]="edate"
merge(bcreation,stations_all,by="station_id")-> ccc
View(ccc)
merge(ecreation,ccc,by="station_id")-> ccc
ccc$lateStarter = ifelse(ccc$bdate!="\t1/1/2015","AH SHITE", "good")
ccc$stillgoing = ifelse(ccc$edate!="\t12/31/2015","GOOOODbye", "still here")
ccc$goodones = ifelse(ccc$lateStarter!="AH SHITE" & ccc$stillgoing!="GOOOODbye","Good","Bad")
ifelse(ccc$goodones=="Bad" & substr(ccc$edate,2,3)=="12" & substr(ccc$bdate,2,3)=="1/","Good","Bad")->ccc$goodones

master_station = ccc[,c(1,4,2,14,6,7,8,9,10,11)]
View(master_station)

write.csv(master_station,"Master_Station.csv",row.names = FALSE)


count(unique(master_station$station_id))
table(master_station$goodones)
prop.table(table(master_station$goodones))
stations_subset = master_station[master_station$goodones=="Good",]
View(stations_subset)

stations_subset=stations_subset[,c(1,5,6,7,9,10)]
stations_subset=stations_subset[,c(1,2,4,5,6)]
library(plyr)
groupColumns <- c(1,2,4,5)
dataColumns <- c(3)
bbb =ddply(stations_subset, groupColumns, function(x) colSums(x[dataColumns]))
View(bbb)
hist(bbb[bbb$Start_Stop=="start",5])

discretize(bbb$event_count,categories = 4) ->bbb$eventGROUPS
plot(bbb[bbb$Start_Stop=="start",4],bbb[bbb$Start_Stop=="start",3])
levels(bbb$eventGROUPS)

plot(pch=16,cex=.5,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[   612, 26662)",4],bbb[bbb$Start_Stop=="start"
                                                                             & bbb$eventGROUPS=="[   612, 26662)",3],col="dark green",
     xlab="longitude",ylab = "latitude", main = "Distribution of Rentals by Location")
points(pch=16,cex=1,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[ 26662, 52713)",4],bbb[bbb$Start_Stop=="start"
                                                                             & bbb$eventGROUPS=="[ 26662, 52713)",3],col="blue")
points(pch=16,cex=1.5,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[ 52713, 78763)",4],bbb[bbb$Start_Stop=="start"
                                                                             & bbb$eventGROUPS=="[ 52713, 78763)",3],col="orange")
points(pch=16,cex=2,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[ 78763,104813]",4],bbb[bbb$Start_Stop=="start"
                                                                             & bbb$eventGROUPS=="[ 78763,104813]",3],col="red")
legend(-73.965,40.755, c("[612, 26662)","[26662, 52713)","[52713, 78763)","[ 78763,104813]"),cex=.7,pch=c(16,16,16,16),col=c("dark green", "blue","orange","red"))
#e41a1c

plot(pch=16,cex=.5,bbb[bbb$Start_Stop=="stop" & bbb$eventGROUPS=="[   612, 26662)",4],bbb[bbb$Start_Stop=="stop"
                                                                                           & bbb$eventGROUPS=="[   612, 26662)",3],col="dark green",
     xlab="longitude",ylab = "latitude", main = "Distribution of Returns by Location")
points(pch=16,cex=1,bbb[bbb$Start_Stop=="stop" & bbb$eventGROUPS=="[ 26662, 52713)",4],bbb[bbb$Start_Stop=="stop"
                                                                                            & bbb$eventGROUPS=="[ 26662, 52713)",3],col="blue")
points(pch=16,cex=1.5,bbb[bbb$Start_Stop=="stop" & bbb$eventGROUPS=="[ 52713, 78763)",4],bbb[bbb$Start_Stop=="stop"
                                                                                              & bbb$eventGROUPS=="[ 52713, 78763)",3],col="orange")
points(pch=16,cex=2,bbb[bbb$Start_Stop=="stop" & bbb$eventGROUPS=="[ 78763,104813]",4],bbb[bbb$Start_Stop=="stop"
                                                                                            & bbb$eventGROUPS=="[ 78763,104813]",3],col="red")
legend(-73.965,40.755, c("[612, 26662)","[26662, 52713)","[52713, 78763)","[ 78763,104813]"),cex=.7,pch=c(16,16,16,16),col=c("dark green", "blue","orange","red"))
#######################
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject/")
station_repeats = read.csv("Station_Repeat.csv",header = FALSE,stringsAsFactors = FALSE)
View(station_repeats)
names(station_repeats)=c("station_id","count")

sum(station_repeats$count)/19875924
dir()
uni = read.csv("unique_stations.csv",header = TRUE)
View(uni)
station_repeats = merge(station_repeats,uni,"station_id")
discretize(bbb$event_count,categories = 4) ->bbb$eventGROUPS






################################################################
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject/")
bike_use = read.csv("Bike_Use.csv",header = FALSE, stringsAsFactors = FALSE)
View(bike_use)
names(bike_use)=c("bikeid","summed_distance","event_count","summed_duration")
bike_use$summed_duration =bike_use$summed_duration/60
bike_use$time_per_event = bike_use$summed_duration/bike_use$event_count
bike_use$distance_per_evenet = bike_use$summed_distance / bike_use$event_count
hist(bike_use$event_count/1000)
mean(bike_use$event_count/1000)
sd(bike_use$event_count/1000)
median(bike_use$event_count/1000)
##abline(h = 444, v = 1, col = "gray60",lwd=2)
bike_use$speed = bike_use$summed_distance/bike_use$summed_duration*60
mean(bike_use$speed)
sd(bike_use$speed)
mean(bike_use$speed)
median(bike_use$speed)

hist(bike_use$time_per_event)



mean(bike_use[bike_use$distance_per_evenet<1.2 & bike_use$distance_per_evenet > .9,6]) ->meanbike
sd(bike_use[bike_use$distance_per_evenet<1.2 & bike_use$distance_per_evenet > .9,6]) ->sdbike

hist(bike_use[bike_use$distance_per_evenet<1.2 & bike_use$distance_per_evenet > .9,6],xlab = "Distance of Trip (miles)"
     , main = "Frequency of Average Distances For All Bikes")
abline(v=meanbike,col="red",lwd=2)
abline(v=meanbike+sdbike,col="blue",lwd=1)
abline(v=meanbike-sdbike,col="blue",lwd=1)
legend(0.9,1400,c("sd",))
mean(bike_use[bike_use$distance_per_evenet<1.2 & bike_use$distance_per_evenet > .9,6])
abline(v=median(bike_use[bike_use$distance_per_evenet<1.2 & bike_use$distance_per_evenet > .9,6]),col="green",lwd=2)

total_events  = sum(bike_use$event_count)

nrow(bike_use[bike_use$distance_per_evenet<1.2,])/total_events
nrow(bike_use[bike_use$distance_per_evenet>.9,])/total_events

hist(bike_use$summed_distance)
hist(bike_use$event_count, xlab = "Bike Rental Counts", ylab = "Frequency of Rentals for All Bikes",las=1,
     main="Distribution of All Bikes' Rental Counts",col = "grey")
abline(v=mean(bike_use$event_count),col="red",lwd=2)
abline(v=median(bike_use$event_count),col="blue",lwd=2)
legend(0,1400, c("mean =1,172","median = 1,242"),cex=1,lty=c(1,1),lwd=c(2,2),col=c("red", "blue"))

mean(bike_use$event_count)
median(bike_use$event_count)
plot(bike_use$event_count, bike_use$summed_distance,xlab = "Rental Count",ylab = "Lifetime Distance of Bike (miles)",
     main="Total Distance Bikes Travel Vs. Rental Counts ",las=1)
grid(col = "grey",lwd=2)
cor(bike_use$event_count, bike_use$summed_distance)

bikemodel = lm(bike_use$summed_distance ~ bike_use$event_count)
summary(bikemodel)

abline(lm(bike_use$summed_distance ~ bike_use$event_count),col="red",lwd=2)
legend(0,2000, c("Predicted Fit","Data"),cex=.5,lty=c(1,1),lwd=c(2,2),col=c("red", "black"))
###############################################









plot(pch=16,cex=.5,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[   612, 26662)",4],bbb[bbb$Start_Stop=="start"
                                                                                           & bbb$eventGROUPS=="[   612, 26662)",3],col="dark green",
     xlab="longitude",ylab = "latitude", main = "Distribution of Rentals in NYC")
points(pch=16,cex=1,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[ 26662, 52713)",4],bbb[bbb$Start_Stop=="start"
                                                                                            & bbb$eventGROUPS=="[ 26662, 52713)",3],col="blue")
points(pch=16,cex=1.5,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[ 52713, 78763)",4],bbb[bbb$Start_Stop=="start"
                                                                                              & bbb$eventGROUPS=="[ 52713, 78763)",3],col="orange")
points(pch=16,cex=2,bbb[bbb$Start_Stop=="start" & bbb$eventGROUPS=="[ 78763,104813]",4],bbb[bbb$Start_Stop=="start"
                                                                                            & bbb$eventGROUPS=="[ 78763,104813]",3],col="red")



## bike use over year how much each used
bikestartend = read.csv("bikestartend.csv",header = FALSE, stringsAsFactors = FALSE)
View(bikestartend)
sta = bikestartend[bikestartend$V3=="begin",]
ends = bikestartend[bikestartend$V3=="end",]
bikestartend = merge(sta,ends,"V1")
bikestartend$good = ifelse(substr(bikestartend$V2.x,2,3)=="1/" & substr(bikestartend$V2.y,2,3)=="12","good","bad")
table(bikestartend$good)








### temporal and distance
bike = read.csv("DurationsCounts_Minute_.csv",header = FALSE,stringsAsFactors = FALSE)
View(bike)
plot(bike[bike$V1<60,1],bike[bike$V1<60,2])
bike = read.csv("distancecount.csv",header = FALSE,stringsAsFactors = FALSE)
plot(bike[bike$V1<60,1],bike[bike$V1<60,2]/1000,xlab = "Distance (miles)", ylab = "Rentals (in thousands)",
     main = "Rental Counts vs. Distance")
sum(bike[bike$V1<60,2])/9937962


bike = read.csv("Age_Subset.csv",header = FALSE,stringsAsFactors = FALSE)
View(bike) 
##names
names(bike)=c("age","gender","month","sub","count")
bike=bike[,c(1,2,4,5)]
library(plyr)
groupColumns <- c(1,2)
dataColumns <- c(4)
agegende = ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
View(agegende)


plot(agegende[agegende$gender==1,1],agegende[agegende$gender==1,3]/78123,col="blue",type = "l",lwd=6,
     xlab = "age",ylab = "Rental % for M and F",main="Percentage of Rentals by Males and Females by Age")
lines(agegende[agegende$gender==2,1],agegende[agegende$gender==2,3]/78123,col="pink",lwd=6)
lines(agegende[agegende$gender==2,1],agegende[agegende$gender==2,3]/78123,col="black",lwd=1)
legend(45,3.3, c("Male","Female"),cex=1,lty=c(1,1),lwd=c(6,6),col=c("blue", "pink"))

sum(agegende[agegende$gender==1 | agegende$gender ==2,3])

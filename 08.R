








### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### ### NEW FILE ### 
##month, day, year, hour, summed_tripduration (SECOND?), event_count

setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject/By time_durations")
dir()
bike = read.csv("durations.csv",header = FALSE)
View(bike)
names(bike)=c("month","day","year","hour","summed_tripduration","event_count")
bike$ave=bike$summed_tripduration/bike$event_count/60
str(bike)
bike$thing=paste(bike$month,bike$day,bike$year,sep = "/")
bike$thing=paste(bike$thing," ",bike$hour,":00",sep = "")
plot(strptime(bike[bike$month==1,8],"%m/%d/%Y %H:%M"),bike[bike$month==1,7],xlab = "Hours",ylab = "Average Rental Time (minutes)",main="Average Rental Times for each hour in 2015")
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
plot(x$hour,x$summed_tripduration/x$event_count/60,ylim = c(0,20))

groupColumns <- c(1)
dataColumns <- c(5,6)
x =ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
View(x)
plot(x$month,x$summed_tripduration/x$event_count/60,ylim = c(0,20))

groupColumns <- c(1,4)
dataColumns <- c(5,6)
x =ddply(bike, groupColumns, function(x) colSums(x[dataColumns]))
View(x)
paste(x$month,"/1/2015 ",x$hour,":11")
plot(strptime(paste(x$month,"/01/2015 ",x$hour,":11",sep = ""),"%m/%d/%Y %H:%M"),x$summed_tripduration/x$event_count/60)


################ plots of rentals by day, hour, month, whole year

allplot = bike[,c(1,2,3,4,6)]
View(allplot)

##byhour
library(plyr)
groupColumns <- c(4)
dataColumns <- c(5)
byhour =ddply(allplot, groupColumns, function(x) colSums(x[dataColumns]))
plot(byhour$hour,byhour$event_count/1000,xlab = "Hour (0-23)",ylab = "Rentals (in thousands)",xaxt="n",yaxt="n",main = "Rentals by Hour")
axis(side = 1,at=seq(0,23,1))
axis(side=2,at=seq(0,1000,200),las=1)
lines(byhour$hour,byhour$event_count/1000,lwd=2.5)

##bymonth
groupColumns <- c(1)
dataColumns <- c(5)
bymonth =ddply(allplot, groupColumns, function(x) colSums(x[dataColumns]))
plot(ylim=c(0,1400),bymonth$month,bymonth$event_count/1000,xlab = "Month (1-12)",ylab = "Rentals (in thousands)",xaxt="n",yaxt="n",main = "Rentals by Month")
axis(side = 1,at=seq(1,12,1))
axis(side=2,at=seq(0,1400,200),las=1)
lines(bymonth$month,bymonth$event_count/1000,lwd=2.5)



##alltogether
allplot$time = paste(allplot$month,"/",allplot$day,"/",allplot$year," ",allplot$hour,":11",sep="")
plot(strptime(allplot$time,"%m/%d/%Y %H:%M"),allplot$event_count)

##alltogether by day
xxx = allplot[,c(1,2,3,5)]
View(xxx)
xxx$concat = paste(xxx$month,xxx$day,xxx$year,sep = "/")
groupColumns <- c(5)
dataColumns <- c(4)
byallday =ddply(xxx, groupColumns, function(x) colSums(x[dataColumns]))
View(byallday)
byallday$date =strptime(byallday$concat,"%m/%d/%Y")
byallday[order(byallday$date),] ->byallday
library(lubridate)
byallday$dayofyear = yday(byallday$date)

plot(byallday$dayofyear,byallday$event_count,xlab = "Day of Year",xaxt="n",ylab = "Count of Rentals",main="Rentals per Day for 2015",las=1,cex.axis=.7,ylim = c(0,60000),yaxt="n")
axis(side=1,at=c(1,31,59,90,120,151,181,212,243,273,304,334,365),cex.axis=.5)
axis(side=2,at=seq(0,60000,10000),las=1,cex.axis=.5)
lines(byallday$dayofyear,byallday$event_count)

## lets extend and do this by weekday and weekend!! send to excel for easy of use
write.csv(byallday,"byallday_fix_excel.csv")
getwd()
byweekdayend = read.csv("byweekdayweekend.csv",stringsAsFactors = FALSE)
View(byweekdayend)
plot(byweekdayend$dayofyear,byweekdayend$average)
lines(byweekdayend$dayofyear,byweekdayend$average)
byweekdayend$type = ifelse(byweekdayend$dayofweek.1sunday.==7 | byweekdayend$dayofweek.1sunday.==1,"Weekend","Weekday")
byweekdayend$weekday = ifelse(byweekdayend$type=="Weekday",byweekdayend$average,NA)
byweekdayend$weekend = ifelse(byweekdayend$type=="Weekend",byweekdayend$average,NA)
plot(byweekdayend$dayofyear,byweekdayend$weekday/1000,col="blue",xaxt="n",yaxt="n",ylim = c(0,60),xlim = c(1,365)
     ,xlab="Day of Year",ylab="Count of Rentals (in thousands)",main="Average rentals for Weekend and Weekdays for 2015",pch=16)
points(byweekdayend$dayofyear,byweekdayend$weekend/1000,col="red",pch=16)
lines(byweekdayend$dayofyear,byweekdayend$average/1000,col="black",lwd=1.4)
axis(side=1,at=c(1,31,59,90,120,151,181,212,243,273,304,334,365),cex.axis=.5)
axis(side=2,at=seq(0,60,10),las=1,cex.axis=.5)
legend(1,60, c("Weekday","Weekend"),cex=.5,lty=c(1,1),lwd=c(2,2),col=c("blue", "red"))
grid(c(1,31,59,90,120,151,181,212,243,273,304,334,365))
abline(v=c(1,31,59,90,120,151,181,212,243,273,304,334,365), col="gray", lty=3)

##bydayOfWeek
allplot$weekday = weekdays(as.Date(allplot$time,"%m/%d/%Y %H:%M"))
groupColumns <- c(7)
dataColumns <- c(5)
bydow = ddply(allplot, groupColumns, function(x) colSums(x[dataColumns]))
View(bydow)
bydow$weeknum = c(5,1,6,7,4,2,3)
bydow = bydow[order(bydow$weeknum),]
plot(bydow$weeknum,bydow$event_count,ylim=c(0,1600000))
lines(bydow$weeknum,bydow$event_count)
#########legend(1,60000, c("Weekday","Weekend"),cex=.5,lty=c(1,1),lwd=c(2.5,2.5),col=c("blue", "red"))


#byhour and weekday
groupColumns <- c(4,7)
dataColumns <- c(5)
bydow = ddply(allplot, groupColumns, function(x) colSums(x[dataColumns]))
View(bydow)
str(bydow$weekday)
bydow$weekdaynumber = 0
ifelse(bydow$weekday=="Monday",1,bydow$weekdaynumber) -> bydow$weekdaynumber
ifelse(bydow$weekday=="Tuesday",2,bydow$weekdaynumber) -> bydow$weekdaynumber
ifelse(bydow$weekday=="Wednesday",3,bydow$weekdaynumber) -> bydow$weekdaynumber
ifelse(bydow$weekday=="Thursday",4,bydow$weekdaynumber) -> bydow$weekdaynumber
ifelse(bydow$weekday=="Friday",5,bydow$weekdaynumber) -> bydow$weekdaynumber
ifelse(bydow$weekday=="Saturday",6,bydow$weekdaynumber) -> bydow$weekdaynumber
ifelse(bydow$weekday=="Sunday",7,bydow$weekdaynumber) -> bydow$weekdaynumber

##bydow = bydow[order(bydow$weeknum),]
bydow$hoursdf = bydow$hour+ ((bydow$weekdaynumber-1)*24)
View(bydow)
bydow = bydow[order(bydow$hoursdf),]
View(bydow)

plot(bydow$hoursdf,bydow$event_count/1000,pch=16,lwd=.5,xaxt="n",yaxt="n",ylim = c(0,200),xlim=c(0,167),
     xlab="Hours",ylab="Rental Count (in thousands)",main="Rentals for Each Hour of Week")
axis(side=1,at=seq(0,168,6))
axis(side=2,las=1,at=seq(0,200,25))
lines(bydow$hoursdf,bydow$event_count/1000,type = "l",lwd=1)
abline(v=c(0:7)*24, col="gray", lty=3)
#################histogram time

dir()

bike = read.csv("DurationsCounts_Minute_.csv",header = FALSE)
View(bike)
str(bike)
plot(bike$month,bike$day,xlim = c(0,1000))
hist(rep(bike[bike$month<100,1],bike[bike$month<100,2]))
sum(bike$day)->rentals
min(bike$month)
max(bike$month)
paste("% rentals in 1:15 minutes ",sum(bike[bike$month<=15,2])/rentals*100,"%",sep = "")
paste("% rentals in 15:30 minutes ",sum(bike[bike$month>15 & bike$month<=30,2])/rentals*100,"%",sep = "")
paste("% rentals in 45:60 minutes ",sum(bike[bike$month>45 & bike$month<=60,2])/rentals*100,"%",sep = "")
paste("% rentals in 60:120 minutes ",sum(bike[bike$month>60 & bike$month<=120,2])/rentals*100,"%",sep = "")
paste("% rentals in 120:240 minutes ",sum(bike[bike$month>120 & bike$month<=240,2])/rentals*100,"%",sep = "")
paste("% rentals in 240 and greater minutes ",sum(bike[bike$month>240,2])/rentals*100,"%",sep = "")

paste("% rentals in 60 or over minutes ",sum(bike[bike$month>60,2])/rentals*100,"%",sep = "")

hist(rep(bike[bike$month<=60,1],bike[bike$month<=60,2]))
plot(bike$month,bike$day,xlim = c(0,60),type="l")
bikeplot = (bike[order(bike$month),])
bikeplot$day/1000 ->bikeplot$day
View(bikeplot)
plot(bikeplot$month,bikeplot$day,xlim = c(0,60),type="l",xlab="Rental Length (min.)",ylab = "Number of Rentals (in thousands)",main = "Rental Time Distribution")




###Birth years
dir()
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject/Age_Birth")
bike = read.csv("Age_Count.csv",header = FALSE,stringsAsFactors = FALSE)
View(bike)
bike = bike[order(bike$month),]
rentals = sum(bike$year)

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

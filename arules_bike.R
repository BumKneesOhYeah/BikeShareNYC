#http://stackoverflow.com/questions/10092365/r-arules-subset-of-transactions-that-match-a-rule
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")
dir()
#install.packages("arules")
library(arules)
bike_temp = read.csv("MLset.csv",header = FALSE,stringsAsFactors = FALSE)
names(bike_temp)=c("age","distance","gender","month","tripduration","usertype")
str(bike_temp)

##categrize Age
bike_temp$age=ifelse(bike_temp$age<30,0,bike_temp$age)
bike_temp$age=ifelse(bike_temp$age>=30 & bike_temp$age<45,1,bike_temp$age)
bike_temp$age=ifelse(bike_temp$age>=45,2,bike_temp$age)
table(bike_temp$age)
bike_temp$age = ifelse(bike_temp$age==0,"Young",bike_temp$age)
bike_temp$age = ifelse(bike_temp$age=="1","Middle-Aged",bike_temp$age)
bike_temp$age = ifelse(bike_temp$age=="2","Old",bike_temp$age)
table(bike_temp$age)

## categorize gender
bike_temp$gender = ifelse(bike_temp$gender==0,"Unknown",bike_temp$gender)
bike_temp$gender = ifelse(bike_temp$gender=="1","Male",bike_temp$gender)
bike_temp$gender = ifelse(bike_temp$gender=="2","Female",bike_temp$gender)
table(bike_temp$gender)

##categorize trip duration
bike_temp$tripduration = bike_temp$tripduration/60 ## get in minutes
hist(bike_temp[bike_temp$tripduration<60,5])
## above 60, 30 -60, 0-15 and 15-30
bike_temp$tripduration=ifelse(bike_temp$tripduration< 15,0,bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration >= 15 & bike_temp$tripduration< 30,1,bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration >= 30 & bike_temp$tripduration< 45,2,bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration >= 45 & bike_temp$tripduration< 60,3,bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration >= 60,4,bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration == 0,"0_15",bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration == "1","15_30",bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration == "2","30_45",bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration == "3","45_60",bike_temp$tripduration)
bike_temp$tripduration=ifelse(bike_temp$tripduration == "4","above_60",bike_temp$tripduration)
table(bike_temp$tripduration)

## categiruze distance now!!
hist(bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance > -1 & bike_temp$distance <=1, 0, bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance > 1 & bike_temp$distance <=2, 1, bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance > 2 & bike_temp$distance <=3, 2, bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance > 3 & bike_temp$distance <=4, 3, bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance > 4 & bike_temp$distance <=5, 4, bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance > 5 , 5, bike_temp$distance)
table(bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance  == 0 , "0_1", bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance  == "1" , "1_2", bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance  == "2" , "2_3", bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance  == "3" , "3_4", bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance  == "4" , "4_5", bike_temp$distance)
bike_temp$distance = ifelse(bike_temp$distance  == "5" , "above_5", bike_temp$distance)
table(bike_temp$distance)



bike_temp$age= paste("age",bike_temp$age,sep = "-")
bike_temp$distance= paste("distance",bike_temp$distance,sep = "-")
bike_temp$gender= paste("gender",bike_temp$gender,sep = "-")
bike_temp$month= paste("month",bike_temp$month,sep = "-")
bike_temp$tripduration= paste("tripduration",bike_temp$tripduration,sep = "-")
bike_temp$usertype= paste("usertype",bike_temp$usertype,sep = "-")

nrow(bike_temp)
yuppers = bike_temp[sample(nrow(bike_temp),round(nrow(bike_temp)*.1)),]
View(yuppers)
write.csv(yuppers,"Ass_Bike.csv",row.names = FALSE)
bike <- read.transactions("Ass_Bike.csv", sep = ",", rm.duplicates = TRUE,skip = 1)

#some basic data set rendering and visualisation you could also load it in excel (but this is more fun)
summary( bike )
inspect(bike[1:5])
itemFrequencyPlot(bike, support = 0.1)
itemFrequencyPlot(bike, topN = 40)
image(bike[1:5])
image(sample(bike, 100))
#what other methods of visualisation could we do?

#let's build the actual model
apriori(bike)

#we got nothing.....!??! why? use ?apriori to find out

#this time let's use sensible parameter values
bikerules <- apriori(bike, parameter=list(support =0.01, confidence = 0.1, minlen = 2))
#bikerules <- apriori(bike, parameter=list(support = 0.01, confidence = 0.25, minlen = 2))


#so now we get something, but are these rules actually any good?
summary(bikerules)

#The size of the rule is calculated as the total of both the left-hand side (lhs) and right-hand side (rhs) of the rule. 
#This means that a rule like {bread} => {butter} is two items and {peanut butter, jelly} => {bread} is three.
#Lift: a measure of how much more likely one item is to be purchased relative to its typical purchase rate, given that you know another item has been purchased.
#We see that the bike data, which contained 9,835 transactions, was used to construct rules with a minimum support of 0.006 and minimum confidence of 0.25
#closer look:
inspect(bikerules[])

#What about
#Let's have a  the 'best' rules?
inspect(sort(bikerules, by = "lift")[1:40])

#What about specific types of rules?
#part  pin   Arrest and No Arrest
berryrules <- subset(bikerules, !items %in% c("NARCOTICS") & !items %pin% "Arrest")
inspect(subset(berryrules,by="lift"))

#part  ain   NARCOTICS AND Friday needed
berryrules <- subset(bikerules, items %ain% c("NARCOTICS", "Friday"))
inspect(subset(berryrules,by="lift"))

#part  ain   NARCOTICS AND Friday needed
berryrules <- subset(bikerules, lhs %ain% c("age-Young"))
inspect(subset(berryrules,by="lift"))

berryrules <- subset(bikerules, !items %pin% "NARCOTICS" & lhs %pin% c("temp") & lhs %pin% "time")
inspect(subset(berryrules,by="lift"))



### to predict stuff on left to right strictly bike
berryrules <- subset(bikerules, !items %pin% "NARCOTICS" & !lhs %pin% c("Arrest") & !lhs %pin% "bike" & !rhs %pin% "temp" & !rhs %pin% "Locate" & !rhs %pin% "unem" & !rhs %pin% "time" & !rhs %pin% "Mont" & !rhs %pin% "day" & !lhs %pin% "Locat")
inspect(subset(berryrules,by="lift"))




#look at subset BARCOTICS  



narcotics = read.csv("Master_Final.csv",header = TRUE)
View(narcotics)
narcotics=narcotics[,c(2,3,14,16,17)]
narcotics = narcotics[narcotics$Primary=="NARCOTICS",]

narcotics$Secondary = as.character(narcotics$Secondary)
narcotics$Primary = as.character(narcotics$Primary)
#years month
table(narcotics[narcotics$Arrest==1,2],narcotics[narcotics$Arrest==1,2])
table(narcotics[narcotics$Arrest==0,2],narcotics[narcotics$Arrest==0,2])
#months
table(narcotics[narcotics$Arrest==1,1], narcotics[narcotics$Arrest==1,2])
table(narcotics[narcotics$Arrest==0,1],narcotics[narcotics$Arrest==0,2])

narcotics[narcotics$Year==2014 & narcotics$Month==1 & narcotics$Arrest==0,]

table(narcotics[narcotics$Arrest==1,4])
table(narcotics[narcotics$Arrest==0,4])



### whole data set to look at the weirdness of bike
full_bike = read.csv("MASTER_FILE_9_clusters.csv",header = TRUE,stringsAsFactors = FALSE)
View(full_bike)
full_bike <-full_bike[,c(2,3, 15,17,18)]
full_bike = full_bike[full_bike$Primary=="NARCOTICS",]
table(full_bike$Arrest)
table(full_bike[full_bike$Arrest==1,1], full_bike[full_bike$Arrest==1,2])
table(full_bike[full_bike$Arrest==0,1],full_bike[full_bike$Arrest==0,2])

narcotic_count =data.frame(count=c(2223,2356,2637,2619,2627,2436,2752,2621,2368,2370,2118,1836,2324,1965,2453,2081,1967,1837,1923,2086,2037,2097,1776,1292,1139,1291,1465,1440,1380,1224,1221,800,710,626,579,546),year=c(2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016),month=c(1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12))
#View(narcotic_count)
within(narcotic_count, Date <- sprintf("%02d-%d-01", month, year)) -> narcotic_count
str(narcotic_count$Date)
narcotic_count$Date <- as.Date( narcotic_count$Date, "%m-%Y-%d")
require(ggplot2)
ggplot( data = narcotic_count, aes( Date, count )) + geom_line()
plot(narcotic_count$Date,narcotic_count$count,type="l")


#install.packages("xts")
library(xts)

# Create a fake time serie with growing and decaying phases
set.seed(42)
X.day <- narcotic_count$count
# Create the sequence of dates
Dates <- narcotic_count$Date

# Create the time serie
X.day <- xts(X.day, order.by = Dates)

plot(X.day)


## ANOVAS TO SEE IF % of arrests are the same
narcotic_percent = data.frame(percent_arres=c(0.979757085020243,0.98811544991511,0.9871065604854,0.993508972890416,0.9942900647126,0.999589490968801,0.99890988372093,0.999618466234262,0.999155405405405,0.99873417721519,0.999527856468366,1,0.999569707401033,0.999491094147583,1,0.998558385391639,1,0.999455634186173,0.999479979199168,0.999520613614573,0.999018163966618,0.999523128278493,1,1,1,0.997676219984508,1,1,0.998550724637681,0.999183006535948,1,1,1,1,1,0.998168498168498), year=c(2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2014,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2015,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016,2016),month=c(1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12))
View(narcotic_percent)                              
within(narcotic_percent, Date <- sprintf("%02d-%d-01", month, year)) -> narcotic_percent
narcotic_percent$Date <- as.Date( narcotic_percent$Date, "%m-%Y-%d")

ggplot( data = narcotic_percent, aes( Date, percent_arres )) + geom_line()
plot(narcotic_percent$Date,narcotic_percent$percent_arres,lwd=3,xlab="Date",ylab="percent of arrest",main="Percent of Arrests for Narcotics bikes",ylim=c(0,1))


#install.packages("xts")
library(xts)

# Create a fake time serie with growing and decaying phases
set.seed(42)
X.day <- narcotic_percent$percent_arres
# Create the sequence of dates
Dates <- narcotic_percent$Date

# Create the time serie
X.day <- xts(X.day, order.by = Dates)

plot(X.day, xlab="Date",ylab="percent of arrest",main="Percent os arrests fro Narcotics bikes",ylim=c(0,1))


## are the years different for arrest rates?
aov(narcotic_percent$percent_arres~narcotic_percent$month) ->yo
summary(yo)
#2014-2015
sub_narc = narcotic_percent[narcotic_percent$year==2014 |narcotic_percent$year==2015,]
aov(sub_narc$percent_arres~sub_narc$month) ->yo
summary(yo)
#2014-2016
sub_narc = narcotic_percent[narcotic_percent$year==2014 |narcotic_percent$year==2016,]
aov(sub_narc$percent_arres~sub_narc$month) ->yo
summary(yo)
#2015-2016
sub_narc = narcotic_percent[narcotic_percent$year==2015 |narcotic_percent$year==2016,]
aov(sub_narc$percent_arres~sub_narc$month) ->yo
summary(yo)

mean(narcotic_percent[narcotic_percent$year==2014,1])
mean(narcotic_percent[narcotic_percent$year==2015,1])
mean(narcotic_percent[narcotic_percent$year==2016,1])

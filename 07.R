setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")
dir()
missing_bike = read.csv("missing_values.csv",header = TRUE,stringsAsFactors = FALSE)
View(missing_bike)
missing_bike$percent_missing = missing_bike$Empty/missing_bike$total


## we seee that month 8 has 0.18744132 (18.7% missing values) this will be looked at later for age subset
plot(missing_bike$Month,missing_bike$percent_missing,type="l", xlab="Month",ylab="% Missing",ylim = c(0,.2),main = "Percentage of Missing Age Values By Month",xaxt="n",yaxt="n",lwd=2.5)
points(missing_bike$Month,missing_bike$percent_missing,lwd=2.5)
axis(side = 1,at=seq(1,12,1))
axis(side = 2,at=seq(0,.2,.05),las=1)

### prints missing and non missing and total age values in data set
plot(missing_bike$Month,missing_bike$total/1000,type="l", xlab="Month",ylab="Count (in thousands)",ylim = c(0,1400),main = "Missing/Non-Missing Age Value Counts by Month",xaxt="n",yaxt="n",lwd=2.5)
axis(side = 1,at=seq(1,12,1))
axis(side = 2,at=seq(0,1400,200),las=1)
legend(1,1400, c("Total","Non-Missing","Missing"),cex=.7,lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black", "blue","red"))
lines(missing_bike$Month,missing_bike$Empty/1000,col="red",lwd=2.5) # adds a line for defense expenditures
lines(missing_bike$Month,missing_bike$Nonempty/1000,col="blue",lwd=2.5) # adds a line for health expenditures
###


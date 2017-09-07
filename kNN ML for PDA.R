#Let's try and identify cancer, using kNN
setwd("C:/Users/Ryan Donovan/Desktop/Data Analytics/Programming/Code_Subsets_ScriptsProject")
bike <- read.csv("MLset.csv",header = FALSE,stringsAsFactors = FALSE)
View(bike)
names(bike)=c("age","distance","gender","month","tripduration","usertype")
bike$tripduration = bike$tripduration /60
bike_2_genders = bike[bike$gender==1 | bike$gender==2,c(1,2,5,3)]
table(bike_2_genders$gender)
prop.table(table(bike_2_genders$gender))
View(bike_2_genders)

summary(bike_2_genders[,c(1:3)])
hist(bike_2_genders$age, xlab = "Age",ylab="Rental Count", main="Histogram of Rentals by Age",breaks = 10,cex.axis=.5,las=1)

     hist(bike_2_genders$distance)
     nrow(bike_2_genders[bike_2_genders$distance <= 4,])/nrow(bike_2_genders)
  hist(bike_2_genders[bike_2_genders$distance <= 4,2])
  #trimmimng
  bike_2_genders=bike_2_genders[bike_2_genders$distance <= 4,]
  
            hist(bike_2_genders$tripduration)
     nrow(bike_2_genders)
     nrow(bike_2_genders[bike_2_genders$tripduration <= 60,])/nrow(bike_2_genders)
     hist(bike_2_genders[bike_2_genders$tripduration<=60,3])
     ## since there are manyy outiers found before eliminated all rows over 60 minutes
     bike_2_genders=bike_2_genders[bike_2_genders$tripduration<=60,]
     bike_2_genders = bike_2_genders[sample(nrow(bike_2_genders),round(nrow(bike_2_genders)*.1)),]
     
     #First, make a normalisation function
     normalize <- function(x) { return ((x - min(x)) / (max(x) - min(x))) }
     
     
     
     #now let's normalise our dataset so that calculating the distances in the feature space makes sense
     bike_2_genders <- cbind(as.data.frame(lapply(bike_2_genders[1:3], normalize)),bike_2_genders[,4])
     View(bike_2_genders)
     ## take 80/20 test training
     further_subset = bike_2_genders
     
     s = sample(nrow(bike_2_genders),round(nrow(bike_2_genders)*.8))
     s
     
     #we already have labels whether someone has cancer or not, that's not condusive to classifying, as we already know the answer... so let's remove the labels from some of our data (we can check later if we did a good job or not)
     bike_2_genders_train <- bike_2_genders[s, ]
     bike_2_genders_test <- bike_2_genders[-s, ]
     
     View(bike_2_genders_train)
      #install.packages("class")
     library(class)
     
     bike_2_genders_test_pred <- knn(train = bike_2_genders_train[,c(1,2,3)], test = bike_2_genders_test[,c(1,2,3)], cl = bike_2_genders_train[,c(4)], k=419)
     
     #let's check our results
     #install.packages("gmodels")
     library("gmodels")
     CrossTable(x = bike_2_genders_test[,4], y = bike_2_genders_test_pred, prop.chisq=FALSE)
     
     #did we do a good job? how does changing the value of k affect our solution?
     View(bike_2_genders_test)
     
     
     
     
     
     
     
     
     View(further_subset)
     table(further_subset$`bike_2_genders[, 4]`)
     females = further_subset[further_subset$`bike_2_genders[, 4]`==2,]
     View(females)
     males = further_subset[further_subset$`bike_2_genders[, 4]`==1,]
     View(males)
     males = males[sample(131604,43759),]
     
     further_subset = rbind(males,females)
     
     s = sample(nrow(further_subset),round(nrow(further_subset)*.8))
     s
     
     #we already have labels whether someone has cancer or not, that's not condusive to classifying, as we already know the answer... so let's remove the labels from some of our data (we can check later if we did a good job or not)
     further_subset_train <- further_subset[s, ]
     further_subset_test <- further_subset[-s, ]
     
     View(further_subset_train)
     #install.packages("class")
     library(class)
     
     further_subset_test_pred <- knn(train = further_subset_train[,c(1,2,3)], test = further_subset_test[,c(1,2,3)], cl = further_subset_train[,c(4)], k=296)
     
     #let's check our results
     #install.packages("gmodels")
     library("gmodels")
     CrossTable(x = further_subset_test[,4], y = further_subset_test_pred, prop.chisq=FALSE)
     
     
     ## lets try different ks from 10 - 300
     #did we do a good job? how does changing the value of k affect our solution?
     for (k in seq(291,301,1))
          {
       further_subset_test_pred <- knn(train = further_subset_train[,c(1,2,3)], test = further_subset_test[,c(1,2,3)], cl = further_subset_train[,c(4)], k=296)
       CrossTable(x = further_subset_test[,4], y = further_subset_test_pred, prop.chisq=FALSE)
       print(k)
       }

     
     
     
     
     
     
     
     
     
     
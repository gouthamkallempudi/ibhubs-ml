#import library
library(MASS)
#reading the csv file
data<-read.csv("ozone.csv")
#spliting the data
index<-sample(1:nrow(data),size=0.8*nrow(data))
#training data
train<-data[index,]
#testing data
test<-data[-index,]
#linear model fit

fit <- lm(ozone_reading~.,data=train)

step<-stepAIC(fit, direction = "backward", trace=FALSE)
#stepwise regression model
#step <- stepAIC(fit, direction=c("forward"))
#summary of model
summary(step)
#comparing the initial model and final model
step$anova
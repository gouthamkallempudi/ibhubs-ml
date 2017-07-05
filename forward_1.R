#import library
library(MASS)
#reading the csv file
data<-read.csv("ozone2.csv")
#spliting the data
index<-sample(1:nrow(data),size=0.8*nrow(data))
#training data
train<-data[index,]
#testing data
test<-data[-index,]
#linear model fit
Base <- lm(ozone_reading~Temperature_Sandburg,data=train)
Full <- lm(ozone_reading~.,data=train)

step<-stepAIC(Base, scope = list( upper=Full, lower=~1 ), direction = "forward", trace=FALSE)
#stepwise regression model
#step <- stepAIC(fit, direction=c("forward"))
#summary of model
summary(step)
#comparing the initial model and final model
step$anova
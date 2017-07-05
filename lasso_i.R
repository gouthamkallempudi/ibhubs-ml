library(glmnet)
library(datasets)
# sock.csv file predicts the closing prices of company 10 using the data of 9 companies of same domain

data<-read.csv("stock.csv")

index<-sample(1:nrow(data),size=0.8*nrow(data))
train<-data[index,]
test<-data[-index,]
y<-as.matrix(train[c(10)])
x<-as.matrix(train[c(-10)])



fit<-glmnet(x,y,alpha=1)
plot(fit,xvar="lambda")

cvfit<-cv.glmnet(x,y,alpha=1)

plot(cvfit)

cvfit$lambda.min #mean cross validation error
cvfit$lambda.1se #minimum standard error

coef(cvfit, s = "lambda.min")
predict(cvfit, newx = as.matrix(test[c(-10)]), s = "lambda.min")


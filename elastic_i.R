library(glmnet)
#This dataset aims in predicting the final exam marks from three mid exams
data<-read.csv("exam.csv")

index<-sample(1:nrow(data),size=0.7*nrow(data))
train<-data[index,]
test<-data[-index,]
y<-train["FINAL"]
x<-train[c(1,2,3)]
x<-as.matrix(x)
y<-as.matrix(y)
fit<-glmnet(x,y,alpha=0.5)
plot(fit,xvar="lambda")

fit<-cv.glmnet(x,y,alpha=0.5)  #alpha =1 lasso or alpha =0 ridge
plot(fit)

fit$lambda.min #mean cross validation error
fit$lambda.1se #minimum standard error

coef(fit, s = "lambda.min")
predict(fit, newx = as.matrix(test[c(1,2,3)]), s = "lambda.min")

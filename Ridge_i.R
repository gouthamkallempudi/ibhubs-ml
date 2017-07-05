library(MASS)
#sachinetendulkar.csv contains the track record of sachin tendulkar

data<-read.csv("sachintendulkar.csv")
data[,'Runs'] <- as.numeric(as.character(data[,'Runs']))
data<-na.omit(data)
index<-sample(1:nrow(data),size=0.8*nrow(data))
train<-data[index,]
test<-data[-index,]


ridge<-lm.ridge(Runs~.,data=train,lambda = 0.1)
coef(ridge)

#data<-c(test,data.frame(test$Mins),data.frame(test$Odi),data.frame(test$Test))

# prediction
test$predicted<-coef(ridge)[1] + coef(ridge)[2]*(test$Mins) + coef(ridge)[3]*(test$BF) + coef(ridge)[4]*(test$X4s)+ coef(ridge)[5]*(test$X6s)+ coef(ridge)[6]*(test$SR)+ coef(ridge)[7]*(test$Pos)+ coef(ridge)[8]*(test$Home)+ coef(ridge)[9]*(test$Overseas)+ coef(ridge)[10]*(test$Test)+ coef(ridge)[11]*(test$Odi)
index<-c("Runs","predicted")
head(test[,index])




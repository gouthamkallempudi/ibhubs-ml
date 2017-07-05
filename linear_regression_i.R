
#load the data
# sock.csv file predicts the closing prices of company 10 using the data of 9 companies of same domain

my_data <- read.csv("stock.csv")
#visulaization of data

#setting the seed
set.seed(100)
#splitting the data
index <- sample(1:nrow(my_data) , size = 0.7 * nrow(my_data))
train_data <- my_data[index ,]
test_data <- my_data[-index ,]

HoldOut<-train(Company10~.,train_data[,-3],method="lm",trControl=trainControl(method="LGOCV",p=.7,number=1))
HoldOut

#k fold
kFold<-train(Company10~.,data=train_data[,-3],trControl=trainControl(method="cv",number=10),method="lm")
kFold
#leave out
loocv<-train(Company10~.,data = train_data[,-3],method="lm",trControl=trainControl(method="LOOCV"))
loocv
#model <- lm(Company10 ~ ., data = my_data)
#summary of the model
summary(kFold)
preds<-predict(model , newdata=test_data)
length(preds)


sum( (preds - mean(test_data$Company10) )^2 )/sum( (test_data$Company10 - mean(test_data$Company10) )^2 )



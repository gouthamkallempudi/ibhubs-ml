library(gbm)
data <- read.csv('tic-tac-toe.csv')
set.seed(200)

index<-sample(1:nrow(data) , size = 0.7 * nrow(data))
train<-data[index , ]
test<-data[-index ,]

gbmModel = gbm(formula = Class~.,
               distribution = "adaboost",
               data = train,
               n.trees = 500,
               shrinkage = 0.1
               )

trees <-gbm.perf(gbmModel , method = "OOB")
summary(gbmModel , trees)

gbmHoldoutPredictions = predict(object = gbmModel,
                                newdata = train,
                                n.trees = trees,
                                type = "response")

gbmNonHoldoutPredictions = predict(object = gbmModel,
                                   newdata = test,
                                   n.trees = trees,
                                   type = "response")


1-sum(abs(train$Class - gbmHoldoutPredictions))/length(gbmHoldoutPredictions)

1-sum(abs(test$Class - gbmNonHoldoutPredictions))/length(gbmNonHoldoutPredictions)
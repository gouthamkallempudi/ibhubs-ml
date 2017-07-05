#load library
library(gbm)

#EuStockMarkets predics the colsing stock price of london stock from three european stock exchanges.

mydata<-EuStockMarkets
#train and test data
index<-sample(1:nrow(mydata) , size=0.7*nrow(mydata))
train<-data.frame(mydata[index , ])
test<-data.frame(mydata[-index , ])

#seed
set.seed(1)

#model
model <- gbm(formula = FTSE ~ ., 
             distribution = "gaussian" ,data = train,
             n.trees = 100, interaction.depth = 5,
             shrinkage = 0.2, bag.fraction = 0.5,
             train.fraction = 1.0, n.cores = NULL)
#check for the best iterations and compare with previous cases.
trees<-gbm.perf(model)
trees
preds <- predict(model, newdata = train, n.trees = trees )
#calculate the R-squared value
sum( (preds - mean(train$FTSE) )^2 )/sum( (train$FTSE - mean(train$FTSE) )^2 )



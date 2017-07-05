#load library
library(gbm)
#train and test data
train <- read.csv("higgs_train_10k.csv")
test <- read.csv("higgs_test_5k.csv")
#seed
set.seed(1)

#model
model <- gbm(formula = response ~ ., 
             distribution = "gradient" ,data = train,
             n.trees = 700, interaction.depth = 5,
             shrinkage = 0.1, bag.fraction = 0.5,
             train.fraction = 1.0, n.cores = NULL)
#check for the best iterations and compare with previous cases.
trees<-gbm.perf(model)
trees
preds <- predict(model, newdata = train, n.trees = trees , type ='response')
labels <- train[,"response"]
preds1 <- predict(model, newdata = test, n.trees = trees,type = 'response')
labels1 <- test[,"response"]

1-(sum(abs(preds - train$response ))/length(labels))



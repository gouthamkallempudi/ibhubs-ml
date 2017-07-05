#getting the data from url
credit <- read.csv("http://www.biz.uiowa.edu/faculty/jledolter/DataMining/germancredit.csv")
head(credit,2)

cred1=credit[, c("Default","duration","amount","installment","age")]
head(cred1)
cred1=data.frame(cred1)
library(MASS)
attach(cred1)

model=lda(Default~.,cred1)
model

# Confusion Matrix:
table(predict(model)$class, Default)


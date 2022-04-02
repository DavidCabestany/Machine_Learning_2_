spambase = read.csv(file="http://www.sc.ehu.es/ccwbayes/master/selected-dbs/nlp-naturallanguageprocessing/spambase.csv", header=TRUE, sep=,)
spambase$class = as.factor(spambase$class)
spambaseNONSPAM = spambase[spambase$class==0,]
dim(spambaseNONSPAM)
spambaseNONSPAM=spambaseNONSPAM[,-58]

library(e1071)

data("airquality")
df <- airquality
model <- svm(spambaseNONSPAM,y=NULL,type='one-classification')
print(model)
summary(model)
pred<-predict(model,spambaseNONSPAM)
which(pred==TRUE)
trues=which(pred==TRUE)




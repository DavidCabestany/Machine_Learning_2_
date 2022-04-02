spambase = read.csv(file='http://www.sc.ehu.es/ccwbayes/master/selected-dbs/nlp-naturallanguageprocessing/spambase.csv', header=TRUE, sep=",",)
#YOU CAN WORK IN LOCAL TOO
spambase$class = as.factor(spambase$class)
spambaseNONSPAM =spambase[spambase$class==0,]
dim(spambaseNONSPAM)
spambaseNONSPAM = spambaseNONSPAM[,-58]

library(DDoutlier)

data(spambaseNONSPAM)
colnames(spambaseNONSPAM)

outlierness = LOF(dataset=spambaseNONSPAM, k=10)

names(outlierness) <- 1:nrow(spambaseNONSPAM)
sort(outlierness, decreasing=TRUE)

hist(outlierness)
which(outlierness > 2.0)



#plot(density(outlierness))
# df <- spambaseNONSPAM
# 
# model <- svm(df, y=NULL,type='one-classification')
# print(model)
# 
# summary(model)
# 
# pred <- predict(model, df)
# 
# which(pred==TRUE)




# df[1,] --> first row
# df[1,2] --> first row, second col
# df[,2:3] --> second and third col
# df = [,-3] --> deletes the third column
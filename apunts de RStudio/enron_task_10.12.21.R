# "utiml" and "mldr" packages for multi-label classification in R

#install.packages("utiml")
library(utiml)
#install.packages("mldr")
library(mldr)
# following package offers benchmarks for multi-label classification
#install.packages("mldr.datasets")
library(mldr.datasets)
summary(enron)
# enron, a corpus with 19300 documents, 1006 words and 20 multi-labels

enron$labels
enroncorpus = enron$dataset
View(enroncorpus)


dim(enroncorpus)
colnames(enroncorpus)


enron <- remove_skewness_labels(enron,10)
# label bat plot
plot(enron, type="LB")
# visual relations among labels
plot(enron, type="LC")
# an external GUI interface to explore the "enron" dataset
mldrGUI()
# start modeling
set.seed(13)
# create a holdout partition: train and predict to evaluate
# I created a small test partition as the prediction step takes a long time
ds <- create_holdout_partition(enron, c(train=0.90, test=0.10))

# Binary relevance ML strategy with naive Bayes base classifier
model_BR_NB <- br(ds$train, "NB")
predictionsBR <- predict(model_BR_NB, ds$test)
head(predictionsBR)
resultsBRPerExamples <- multilabel_evaluate(ds$test, predictionsBR, 
                                            c("example-based"))
resultsBRPerExamples
resultsBRPerLabel <- multilabel_evaluate(ds$test, predictionsBR, 
                                         c("label-based"))
resultsBRPerLabel

# Classifier Chain ML strategy with naive Bayes base classifier
# Define the chain-order between labels: sample a random order
mychain <- sample(rownames(enron$labels))
model_CC_NB <- cc(ds$train, "NB", mychain)
predictionsCC <- predict(model_CC_NB, ds$test)
resultsCCPerExamples <- multilabel_evaluate(ds$test, predictionsCC, 
                                            c("example-based"))
resultsCCPerExamples
resultsCCPerLabel <- multilabel_evaluate(ds$test, predictionsCC, 
                                         c("label-based"))
resultsCCPerLabel



#

library(RSSL)

set.seed(3)

df <- generate2ClassGaussian(n=2000,d=2,expected=TRUE)

classifiers <- list("LS" = function(X,y,X_u,y_u) {
  LeastSquaresClassifier(X,y,lambda = 0)},
  "Self" = function(X,y,X_u,y_u) { 
    SelfLearning(X,y,X_u,LeastSquaresClassifier)})
                 
measures <- list("Accuracy" = measure_accuracy)
              
lc1 <- LearningCurveSSL(as.matrix(df[,1:2]),
                        df$Class, classifiers=classifiers, measures=measures,
                        type="fraction", test_fraction=0.5, repeats=3)
                 
plot(lc1)
                 
spambase = read.csv(file='http://www.sc.ehu.es/ccwbayes/master/selected-dbs/nlp-naturallanguageprocessing/spambase.csv', header=TRUE, sep=",",)
spambase$class = as.factor(spambase$class)
#spambaseNONSPAM =spambase[spambase$class==0,]



lc2 <- LearningCurveSSL(as.matrix(spambase[ , 1:2]), spambase$class, classifiers=classifiers, measures=measures,
                        type="fraction", test_fraction=0.5, repeats=3)

plot(lc2)


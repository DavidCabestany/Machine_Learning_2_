install.packages("RSSL")

library(RSSL)
set.seed(1)
df <- generate2ClassGaussian(2000,d=2,var=0.6,expected=TRUE)

classifiers <- list("LS"=function(X,y,X_u,y_u){
  LeastSquaresClassifier(X,y,lambda=0)},
  "Self"=function(X,y,X_u,y_u){
    selfLearning(X,y,X_u,LeastSquaresClassifier)})

measures <- list("Accuracy"=measure_accuracy)

lc1 <- LearningCurveSSL(as.matrix(df[,1:2]),
                        df$Class,classifiers=classifiers, measures=measures,
                        type="fraction",test_fraction=0.5, repeats=3)

plot(lc1)

iris=read("iris.csv",header=TRUE,sep=,)

lc2 = LearningCurveSSL(as.matrix(iris[1:4]),iris$variety,
                       classifiers=classifiers,measures=measures,
                       type=fraction, fracs=seq(0.1,0.8,0.1),
                       test_fraction=0.5,repeats=3)

library(randomForest)

# download Titanic Survivors data
data <- read.table("http://math.ucdenver.edu/RTutorial/titanic.txt", h=T, sep="\t")
# make survived into a yes/no
data$Survived <- as.factor(ifelse(data$Survived==1, "yes", "no"))                 
 

# runif(nrow(data)) <= 0.75

# split into a training and test set
# Handy little trick when you dont want to load up additional packages like caret

idx <- runif(nrow(data)) <= 0.75







data.train <- data[idx,]
data.test <- data[-idx,]


### Train a random forest

rf <- randomForest(Survived ~ PClass + Age + Sex, 
             data=data.train, importance=TRUE, na.action=na.omit)



### How important is each variable in the model?
imp <- importance(rf)
o <- order(imp[,3], decreasing=T)
imp[o,]


# confusion matrix [[True Neg, False Pos], [False Neg, True Pos]]
table(data.test$Survived, predict(rf, data.test),
  dnn=list("actual", "predicted"))
#      predicted
#actual  no yes
#   no  427  16
#   yes 117 195

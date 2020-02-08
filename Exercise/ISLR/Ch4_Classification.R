#Logistic Regression
rm(list=ls())
require(ISLR) # same as library - load teh namespace of the package
?require
summary(Smarket)
?Smarket
names(Smarket)
Smarket$Direction
names(Smarket)
pairs(Smarket, col=Smarket$Direction)  # col - refers color 
?pairs # matrix of scatterplots is produced 
pairs(Smarket, col="red") 

#Test 1
?glm.fit # glm is used to fit generalized linear model 
fix(Smarket)
glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Smarket, family="binomial")
#family - errro distribution and link function used in the model. 
#binomial - link == logit , gausssian - link == identity
summary(glm.fit)
#none of the coefficiets are significant - check why ?

?predict
glm.probs = predict(glm.fit, type="response") # why are we not passing the value ?
fix(glm.fit)
glm.probs[1:5]
glm.probs
glm.pred = ifelse(glm.probs > 0.5, "Up", "Down") # > 0.5 then "Up" else "Down"
#attach(Smarket)
table(glm.pred, Direction) #confusion matrix prediction vs actual
mean(glm.pred==Direction) # approx 50 %
#we might have overfitted the training dataset. so divide the dataset into train/test

#Test 2
Year
train = Year < 2005
glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, 
              data=Smarket, family="binomial", subset = train)
glm.probs = predict(glm.fit, newdata = Smarket[!train,], type = "response")
fix(Smarket)
glm.pred = ifelse(glm.probs > 0.5 , "Up", "Down")
Direction.2005 = Smarket$Direction[!train]
table(glm.pred, Direction.2005)
mean(glm.pred==Direction.2005) # answer gives < 50 %

#Test 3 : reduce the predictors 
train = Year < 2005
glm.fit = glm(Direction~Lag1+Lag2, 
              data=Smarket, family="binomial", subset = train)
glm.probs = predict(glm.fit, newdata = Smarket[!train,], type = "response")
fix(Smarket)
glm.pred = ifelse(glm.probs > 0.5 , "Up", "Down")
Direction.2005 = Smarket$Direction[!train]
table(glm.pred, Direction.2005)
mean(glm.pred==Direction.2005) # answer gives > 50 %. looks better then previous 


############################################################3

require(ISLR)
require(MASS)
#Linear Discriminant Analysis  - estimate the probability belong to everyclass 
lda.fit = lda(Direction~Lag1+Lag2, data = Smarket, subset = Year < 2005) # previous 2 days data
lda.fit
plot(lda.fit) # NMI

Smarket.2005 = subset(Smarket, Year==2005)
lda.pred = predict(lda.fit, Smarket.2005)
class(lda.pred)
data.frame(lda.pred)[1:5,]
table(lda.pred$class, Smarket.2005$Direction)
mean(lda.pred$class == Smarket.2005$Direction) # nee to check the code 


###K-Nearest Neighbour 

library(class)
attach(Smarket)
?knn # k nearest neighbour classification for test set from training set 
xlag = cbind(Lag1, Lag2) # make matrix 
dim(xlag)
fix(Lag2)

objects(1)
objects(2)

train = Year < 2005
knn.pred = knn(xlag[train, ], xlag[!train,], Direction[train], k=1) 
# train, test, true classification of training set, minimum vote 
table(knn.pred, Direction[!train])
mean(knn.pred ==Direction[!train])

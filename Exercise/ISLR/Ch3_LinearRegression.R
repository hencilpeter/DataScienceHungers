#Ch3.Linear Regression
#rm(list=ls())
library(MASS) #sample datasets
library(ISLR) #library used in the book
ls()
data() #shows all the available datasets 
data(package="MASS") # shows the datasets of specific library
names(Boston) # list columns
?Boston

#1.Simple Linear Regression

par(mfrow=c(1,1))
plot(medv~lstat, Boston) # medv-median value of owner-occupied homes in $1000s~lower status of population
fit1=lm(medv~lstat, data = Boston) # 
fit1 #co-efficients are negative. So negative relationship
summary(fit1)
abline(fit1, col="green") # draw a fit line in green colour 
names(fit1) # print coefficients, residuals, ..model

predict(fit1, data.frame(lstat=c(5)), interval="confidence") 
predict(fit1, data.frame(lstat=c(5))) 

predict(fit1, data.frame(lstat=c(5,10,15)), interval="confidence") # return fit, lower/upper confidence intervals 


#2. Multiple Linear Regression
?Boston
fix(Boston)
fit2=lm(medv~lstat+age, data = Boston) # y-> medv, x->lstat, age
fit2
summary(fit2)

#how to plot the above ?

fit3=lm(medv~., Boston)
summary(fit3)
par(mfrow=c(2,2))
plot(fit3) #question : How four graphs have been generated?

#update function
?update
fit4 = update(fit3, ~.-age-indus) #~use same response (not clear), . - model in fit3 replace with ".", remove age and indus. 
summary(fit4)

#Non-Linear Terms and Interactions
fit5 = lm(medv~lstat*age, Boston) # * refers interaction
summary(fit5)

fit6=lm(medv~lstat+I(lstat^2), Boston) ; summary(fit6) # Question ? why inverse
attach(Boston)
par(mfrow=c(1,1))
plot(medv~lstat)
?fitted # extract fitted values from the model
points(lstat, fitted(fit6), col="red", pch=20)

fit7 = lm(medv~poly(lstat, 4))
points(lstat, fitted(fit7), col="blue", pch=20)
plot(1:20, 1:20, pch=1:20, cex=2)

#Qualitativ Predictor
fix(Carseats) # fix is an editor 
names(Carseats)
summary(Carseats)
fit1 = lm(Sales~.+Income:Advertising + Age:Price, Carseats) #why are we using ":"
summary(fit1)

?contrasts
contrasts(Carseats$ShelveLoc) # view the contrast associated with the factor


#Writing functions 
#function 1
regplot = function(x,y){
  fit=lm(y~x)
  plot(x,y)
  abline(fit, col="red")
}
#e.g 
attach(Carseats)
regplot(Price, Sales)

#function 2
regplot2 = function(x, y, ...){
 fit = lm(y~x)
 plot(x,y,...)
 abline(fit, col="red")
}

regplot2(Price, Sales, xlab="Price", ylab="Sales", col="blue", pch=20)

###Vectors, matrices and subsetting

x = c(2,7,5) # c-> combining values into vector or list
ls()
x
y = seq(from=4, length=10, by=2)
y

class(x)

##Vector Operations
x = seq(from=2, to = 10, by=2)
x
y = seq(from=12, to = 20, by=2)
y
x+y #Addition
x-y #Subtraction
x*y #multiplication
y/x #Division
x^y #power


##Accessing elements of vector
x
x[2] # second element. index starts from 1 (not 0)
x[2:4] #printing elements from index 2 to 4
x
x[-2] #skip( not delete) the second element and print 
-c(1,2) #collections of indices -1, -2
x[-c(1,2)] # skip collections of indices 1 and 2, and return

#Matrics - High dimentional array
z=matrix(seq(1,12), nrow = 4, ncol = 3)
z
z=matrix(seq(1,12), nrow = 4, ncol = 3, byrow = TRUE)
z
z[3:4, 2:3] # access elements from row 3&4, and column 2,3
z[,2:3] #all row but 2&3 columns
z[,, drop=FALSE] # drop - FALSE refers don't drop matrix status - Need More Info (NMI)
z[,, drop=TRUE]
?drop

dim(z) # dimension
ls() # lis all the variables
zcopy = z
ls()
rm(zcopy) # remove variable Zf


#Generating Random Data and Graphics
x=runif(50) # 50 random uniform - NMI
x
y =rnorm(50)#50 random norml - NMI
y
plot(x,y) # plot x and y variables
plot(x,y, xlab="Random Uniform", ylab="Random Normal", pch="*", col="red") # additional parameters
plot(x,y, xlab="Random Uniform", ylab="Random Normal", pch=20, col="blue") # additional parameters

par(mfrow=c(2,1)) # par - set or query graphical parameters. mfrow- multiframe row
plot(x,y)
hist(y)

par(mfcol=c(2,1)) # NMI on mfcol
plot(x,y)
hist(y)

#Reading Data
ls()
Auto = read.csv("C:/Hencil/HencilData/Hencil/Study/Exercise/ISLR_Exercise/data/Auto.csv")
names(Auto) # shows number of columns
dim(Auto) # shows dimention
class(Auto) 
summary(Auto)
hist(Auto$mpg)
fix(Auto)
max(Auto$mpg)
min(Auto$mpg)


#Auto's class is data frame. So we can use listname and columnname to access the value 
#e.g 
plot(Auto$cylinders, Auto$mpg)
attach(Auto)
search()#shows all workspaces
ls()
plot(cylinders, mpg)
detach(Auto)

## Homework 1

## Question 1

#CODE 1.1
install.packages("rmarkdown")

#CODE 1.2
?sum
##ANSWER: 
#The function syntax is
#sum(..., na.rm = FALSE)
#And the arguments are:
#..., which is a numeric or complex or logical vectors.
#na.rm, which is a logical (TRUE or FALSE). It evaluates the question should missing values (including NaN) be removed?

#CODE 1.3
??clustering
v <- seq(from = 50, to = 100, by = 1)
sd(v)
#ANSWER 1.3: 
#14.86607


## Question 2

#CODE 2.1
a <- c("dog", "cat", "horse")
#Original
a[0]
#Correction
a[1]
#ANSWER 2.1:
#> a[1]
#[1] "dog"

#CODE 2.2
#Original
a <- 5
b <- 5
c <- ifelse(a == 5 | b == 5,TRUE,FALSE)
c
#Correction
a <- 5
b <- 5
c <- ifelse(a == 5 & b == 5, TRUE, FALSE)
c
#If a or b different than 5, then FALSE
a <- 3
b <- 5
c <- ifelse(a == 5 & b == 5, TRUE, FALSE)
c
#ANSWER 2.2:
#& instead of |

#CODE 2.3
#Original
example_matrix <- matrix(rexp(100, rate= .5), ncol = 20)
normalize <- function(input_matrix) {
  t(t(input_matrix)/colSums(input_matrix)
  )
}
normalized_matrix <- normalize(example_matrix)
#Correction
normalize <- function(input_matrix) {
    #First subtract the minimum from each column
    input_matrix = t(t(input_matrix) - apply(input_matrix, 2, min))
    #Then divide by the maximum of the newly created columns
    t(t(input_matrix)/apply(input_matrix, 2, max))
}
#Values between 0 and 1
normalized_matrix <- normalize(example_matrix)
normalized_matrix
#ANSWER 2.3:
"""
normalize <- function(input_matrix) {
    #First subtract the minimum from each column
input_matrix = t(t(input_matrix) - apply(input_matrix, 2, min))
#Then divide by the maximum of the newly created columns
t(t(input_matrix)/apply(input_matrix, 2, max))
}
"""

#CODE 2.4
#Original
example_matrix <- matrix(rexp(100, rate= .5), ncol = 20)
normalize <- function(input_matrix) {
  t(t(input_matrix)/colSums(input_matrix)
  )
}
normalized_matrix <- normalize(example_matrix)
#Correction
normalize <- function(input_matrix) {
  #First subtract the minimum from each row
  input_matrix = input_matrix - apply(input_matrix, 1, min)
  #Then divide by the maximum of the newly created rows
  input_matrix/apply(input_matrix, 1, max)
}
#Values between 0 and 1
normalized_matrix <- normalize(example_matrix)
normalized_matrix
#ANSWER 2.4:
"""
normalize <- function(input_matrix) {
  #First subtract the minimum from each row
input_matrix = input_matrix - apply(input_matrix, 1, min)
#Then divide by the maximum of the newly created rows
input_matrix/apply(input_matrix, 1, max)
}
"""

#CODE 2.5
#Original
example_matrix <- matrix(rexp(100, rate= .5), ncol = 20)
normalize <- function(input_matrix) {
  t(t(input_matrix)/colSums(input_matrix)
  )
}
normalized_matrix <- normalize(example_matrix)
#Correction
normalizeif <- function(input_matrix) {
  #First subtract the minimum from each column
  input_matrix = t(t(input_matrix) - apply(input_matrix, 2, min))
  #Then divide by the maximum of the newly created columns and rename this matrix
  normalized_matrix = t(t(input_matrix)/apply(input_matrix, 2, max))
  if (identical(normalized_matrix, input_matrix)) {
    a <- "Nothing"
  } else {
    a <- normalized_matrix
    a
  }
}
#Normalized matrix, return nothing
normalize <- function(input_matrix) {
  #First subtract the minimum from each column
  input_matrix = t(t(input_matrix) - apply(input_matrix, 2, min))
  #Then divide by the maximum of the newly created columns
  t(t(input_matrix)/apply(input_matrix, 2, max))
}
norm <- normalize(example_matrix)
norm
normalizeif(norm)
#Not normalized matrix, return the normalized matrix
normalizeif(example_matrix)
#ANSWER 2.5:
#No explicit return statement is needed in an R function as return is used for example in python because when the function is ran it returns the last line evaluated. 
#However, we have to call the last value we want the function to return.
"""
normalizeif <- function(input_matrix) {
  #First subtract the minimum from each column
  input_matrix = t(t(input_matrix) - apply(input_matrix, 2, min))
  #Then divide by the maximum of the newly created columns and rename this matrix
  normalized_matrix = t(t(input_matrix)/apply(input_matrix, 2, max))
  if (identical(normalized_matrix, input_matrix)) {
    a <- "Nothing"
  } else {
    a <- normalized_matrix
    a
  }
}
"""


##Question 3

#CODE 3
?assign
#In this version the name "ncol" is assigned to 5 with <- and ncol is only assigned within the matrix function with =
ncol <- 5
matrix(3, ncol = 3)
ncol
#In this version the name "ncol" is assigned to 3 within and out of the matrix function with <-
ncol = 5
matrix(3, ncol <- 3)
ncol
#ANSWER 3:
#Assign requires much more typing than the more natural operators for assignment:
#"=" or "<-". Or even "->" if the value is written before the variable name
#In terms of simplicity, "=" requires only one character, while "<-" requires 2.
#However, "<-" is more typical in R for assignment because it not only assigns the variable
#locally within a function but globally within the environment.
#In summary, if we want to assign locally within a variable "=" is better,
#if we want to assign more globally within the environment "<-" is better.


## Question 4

#CODE 4a
cars
cars$time = cars$dist / cars$speed
cars
for (i in 1 : dim(cars)[1]) {
  print(noquote(paste(c("The time for car ", i, " is ", cars$time[i]), collapse = " ")))
}
#I guess that you were asking for a function within the for loop
for (i in 1 : dim(cars)[1]) {
  print(noquote(paste(c("The time for car ", i, " is ", cars$dist[i] / cars$speed[i]), collapse = " ")))
}
#ANSWER 4a
#Output of the function
"""
for (i in 1 : dim(cars)[1]) {
  print(noquote(paste(c("The time for car ", i, " is ", cars$time[i]), collapse = " ")))
}
#I guess that you were asking for a function within the for loop
for (i in 1 : dim(cars)[1]) {
print(noquote(paste(c("The time for car ", i, " is ", cars$dist[i] / cars$speed[i]), collapse = " ")))
}
"""
#CODE 4b
division <- function (x) {
  return(x[2] / x[1])
}
apply(cars, 1, division)
#ANSWER 4b:
#Output of the function:
#apply(cars, 1, division)


#Question 5

#CODE 5a
#Original
a <- c(3,6,2,3,6,4,1,7,6,3,9)
b <- 0.5
function_1 <- function(a,b){
  b <- lapply(a,function(x) x/b)
  b
}
a = b <- function_1(a,b)
#ANSWER 5a:
#The values of a and b (they are the same) would be 6, 12, 4, 6, 12, 8, 2, 14, 12, 6, 18

#CODE 5b
#Original
a <- c(3,6,2,3,6,4,1,7,6,3,9)
b <- 0.5
function_2 <- function(a,b){
  b <- lapply(a,function(x) x/b)
  b
}
function_2(a,b)
#ANSWER 5b:
#The values of a would be 3,6,2,3,6,4,1,7,6,3,9
#The value of b would be 0.5

##ANSWER 5c:
#A variable assigned a value outside of a function does not change out of the scope of the function if assigned a value within a function


## Question 6

#CODE 6a
iriscolumnsofinterest <- iris[ , c("Petal.Length", "Petal.Width")]
division <- function (x) {
  return(x[1] / x[2])
}
#With apply
for (i in 1 : dim(iriscolumnsofinterest)[1]) {
  if (apply(iriscolumnsofinterest, 1, division)[i] > 5) {
    print(iris$Sepal.Length[i])
  } else {
    print(NA)
  }
}
#With if else
for (i in 1 : dim(iriscolumnsofinterest)[1]) {
  if ((iris$Petal.Length[i] / iris$Petal.Width[i]) > 5) {
    print(iris$Sepal.Length[i])
  } else {
    print(NA)
  }
}
#ANSWER 6a
"""
Output of the functions:
#With apply
for (i in 1 : dim(iriscolumnsofinterest)[1]) {
if (apply(iriscolumnsofinterest, 1, division)[i] > 5) {
print(iris$Sepal.Length[i])
} else {
print(NA)
}
}
#With if else
for (i in 1 : dim(iriscolumnsofinterest)[1]) {
if ((iris$Petal.Length[i] / iris$Petal.Width[i]) > 5) {
print(iris$Sepal.Length[i])
} else {
print(NA)
}
}
"""

#CODE 6b
returnfunction <- function(irisrow) {
  species = irisrow[5]
  switch(species,
         setosa = c(irisrow[1], irisrow[2]),
         c(irisrow[3], irisrow[4]))
}
apply(iris, 1, returnfunction)
#ANSWER 6b:
#Output of:
"""
returnfunction <- function(irisrow) {
  species = irisrow[5]
switch(species,
setosa = c(irisrow[1], irisrow[2]),
c(irisrow[3], irisrow[4]))
}
apply(iris, 1, returnfunction)
"""


## Question 7:
#It took me 6 hours to complete this problem set. Much more than expected as I am very familiar with R, but I am not very familiar with apply methods.





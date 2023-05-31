# Exercise 1:
# ● Create a new script.
# ● Copy the code below into your script.
# a = 'int'
# b = 7
# c = False
# d = '18.5'
# ● Determine the data types of all four variables (a, b, c, d) using a built in function.
# ● Make a new variable x and give it the value b + d. Print the value of x. This will raise
# an error. Fix it so that print(x) prints a float.
# ● Write a comment above every line of code that tells the reader what is going on in
# your script.


# This is how we define a variable and assign a value in Python
a = 'int'
b = 7
c = False
d = '18.5'

# In Python, everything is an object. So, when you use the type() function
# to print the type of the value stored in a variable to the console, it
# returns the class type of the object.

# the type() function was built into the language to check for data types of variables.
print("The data type of a is: ", type(a))
print("The data type of b is: ", type(b))
print("The data type of c is: ", type(c))
print("The data type of d is: ", type(d))

# I define a variable and named it x, then I assign the x variable as
# I literally told it that when we have a variable named b, get the value of b
# add it with variable named d. 
# By using the type function, I confirm that d variable is a string.
# According to the error we cannot add a class type int and class type str together
# Using float function, I converted d into float. I used float because the value of d
# is not a whole number
x = b + float(d)

print(x)
# Exercise 2:
# ● Create a new script.
# ● Use the input() function to get input from the user. Store that input 
# in a variable.
# ● Find out what data type the output of input() is. See if it is 
# different for different kinds
# of input (numbers, words, etc.).

name = input("Type your name: ")
age = input("Type your age: ")

# print name variable's value and data type
print("Name:", name, "Data type:", type(name))

# print age variable's value and data type
print("Age:", age, "Data type:", type(age))

# print age variable's value and data type but convert it to int
print("Age:", age, "Data type:", type(int(age)))
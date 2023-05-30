# Exercise 2:
# ● Create a new script.
# ● Use the input() function to get input from the user. Store that input 
# in a variable.
# ● Find out what data type the output of input() is. See if it is 
# different for different kinds
# of input (numbers, words, etc.).

name = input("Type your name: ")
age = input("Type your age: ")

print(name, "data type:", type(name))
# print(age, "data type:", type(age))
print(age, "data type:", type(int(age)))
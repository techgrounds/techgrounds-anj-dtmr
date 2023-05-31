# Exercise 2:
# ● Create a new script.
# ● Copy the code below into your script.

# ● Add a variable x with value 5 at the top of your script.
x = 5

# You did not manually assign a value to i. Figure
# out how its value is determined.
''' when you say 'for i in range(10)' you are creating a variable called 'i' and
setting it equal to the first value in the second part of the line called
range(). every time the loop loops, i becomes the next value in the second
part of the line (in this case range()) '''

# for i in range(0, 50):
for i in range(1, 51):
    # ● Print the value of i in the for loop.
    print("This is i: ", i)
    # ● Using the for loop, print the value of x multiplied by the value of i,
    # for up to 50 iterations.
    print(f"{x} * {i} = ", x * i, '\n')

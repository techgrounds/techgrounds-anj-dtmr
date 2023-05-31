# Exercise 2:
# ● Create a new script.
# ● Ask the user of your script for a number. Give them a response based on whether the
# number is higher than, lower than, or equal to 100.
# ● Make the game repeat until the user inputs 100.

answer = 100
question = "Guess a number between 0-1000:"

while True:
    usr_num = int(input(question))

    if usr_num > answer:
        print("This is higher, choose lower number")
    elif usr_num < answer:
        print("This is lower, choose higher number")
        continue
    else:
        print(f"{usr_num} is just the right number")
        break


#
# The output should be:
#

import random

# generate random int
goal = random.randint(1, 100)
# print(goal)
win = False
tries = 0

while not win and tries < 7:
    try:
        # count attempt as a try
        tries += 1
        # ask for input
        inpt = int(input("Please input a number between 1 and 100: "))

        # check for match
        if inpt == goal:
            win = True
            print("Congrats, you guessed the number!")
            print("It took you", tries, "tries")
        # give hints
        elif inpt < goal:
            print("The number should be higher")
        else:
            print("The number should be lower")
    except ValueError:
        print("Please type an integer")


if not win:
    print("Game over! You took more than seven tries")


# Tries not getting the string exception even after 7 tries
# except Value Error - docs of all possible exceptions
#
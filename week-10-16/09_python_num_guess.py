# Number Guessing:
# ● Generate a random number between 1 and 100 (or any other range).
# ● The player guesses a number. For every wrong answer the player receives a clue.
# ● When the player guesses the right number, display a score.

import random

random_num = random.randint(1, 100)
# print(random_num)
question = "Guess a number between 0-100:"
count = 0

while True:
    count += 1
    user_num = int(input(question))

    if user_num != random_num:
        clue = 'Choose a smaller number' if user_num > random_num else 'Choose a higher number'
        print(f"Wrong! Try again. {clue}")
    else:
        print(f"Correct! You had {count} attempts")
        break

# Exercise 1:
# ● Create a new script.
# ● Import the random package.
# ● Print 5 random integers with a value between 0 and 100.

# Import all the random package
from random import *

# 1st Try
# a = randrange(100)
# b = randrange(100)
# c = randrange(100)
# d = randrange(100)
# e = randrange(100)
#
# print(a)
# print(b)
# print(c)
# print(d)
# print(e)

# 2nd Try

# Underscore meaning in for _ in range(5): When you are not interested in some values
# returned by a function we use underscore in place of variable name.
# Basically it means you are not
# interested in how many times the loop is run till now just that it should
# run some specific number of times overall.
for _ in range(5):
    value = randint(0, 100)
    print(value)

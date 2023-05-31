# Exercise 1:
# ● Create a new script.
# ● Use the input() function to ask the user of your script for their name. If the name they
# input is your name, print a personalized welcome message. If not, print a different
# personalized message.


usr_name = input("Type your name: ")

if usr_name == "Anj":
    print("Hey Anj I know you!")
else:
    print(f"You are {usr_name}, Not Anj. You are not welcome here.")

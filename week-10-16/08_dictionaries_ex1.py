# Exercise 1:
# ● Create a new script.
# ● Create a dictionary with the following keys and values:
# Key Value
# First name Casper
# Last name Velzen
# Job title Learning coach
# Company Techgrounds
# ● Loop over the dictionary and print every key-value pair in the terminal.


key_value = {'First name': 'Casper', 'Last name': 'Velzen', 'Job title': 'Learning coach', 'Company': 'Techgrounds'}

# Loop through both keys and values, by using the items() method

for key, value in key_value.items():
    print(key, value)

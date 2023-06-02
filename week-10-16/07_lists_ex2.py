# Exercise 2:
# ● Create a new script.
# ● Create a list of five integers.
# ● Use a for loop to do the following for every item in the list:
# Print the value of that item added to the value of the next item in the list. If it is the
# last item, add it to the value of the first item instead (since there is no next item).
# ● The first result above is created by adding 9 and 80. The second result is created by
# adding 80 and 16, etc. The last result is created by adding 35 and 9.


# Here I am creating a list called five_int
five_int = [9, 80, 16, 67, 35]
# five_int = [1, 2, 3, 4, 5]

# Using print statement, I'm printing the list in the console
print(f"This is my list: {five_int}")

# to simplify my for loop I use range function to loop through each item in my list
# i = the index of each item in the list
# len(five_int) = count of items inside the list
for i in range(len(five_int)):
    # print('index', i) ## printing/checking the index of every item

    if i != 0:
        # print('1st num: ', five_int[i - 1]) ## printing/checking what is five_int[i - 1]
        # print('2nd num: ', five_int[i])     ## printing/checking what is five_int[i]
        print(five_int[i - 1] + five_int[i])


    if i == len(five_int) - 1:
        # print('last item is', five_int[i]) ## printing/checking the last item
        print(five_int[0] + five_int[i])

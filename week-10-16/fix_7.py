# '''
# The output should be:
# ['Dog', 'Cat', 'Fly']
# '''
# ln = ['Dog', 'Cat', 'Elephant', 'Fly', 'Horse']
# short_names = []
#
# for animal in ln:
# 	if len(animal) == 3:
# 		short_names.append(animal)
# 	short_names = []
#
# print(short_names)


ln = ['Dog', 'Cat', 'Elephant', 'Fly', 'Horse']
short_names = []

for animal in ln:
    if len(animal) == 3:
        short_names.append(animal)
        # short_names = []

print(short_names)

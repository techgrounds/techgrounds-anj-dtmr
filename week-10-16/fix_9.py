# '''
# The output should be:
# 0
# 1
# 2
# 3
# 4
# 8
# 9
# '''
# for i in range(10):
# 	if i < 5:
# 		print(i)
# 	elif i < 8:
# 		break
# 	else:
# 		print(i)


for i in range(10):
    if i < 5:
        print(i)
    elif i > 9:
        break
    else:
        print(i)

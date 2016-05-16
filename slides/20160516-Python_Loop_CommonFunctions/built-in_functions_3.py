a = [4,2,1,-3,5]
b = [1,2,3,4,5]
print(len(a))
sorted(a)
print(a)
for x in reversed(a):
	print(x,end=' ')
print('\n====================')
for x in range(1,5):
	print(x,end=' ')
print('\n====================')
print(list(zip(a,b)))
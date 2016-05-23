def print_grade(score):
	if(score >= 80):
		print('A')
	elif(score >= 70):
		print('B')
	elif(score >= 60):
		print('C')
	elif(score >= 50):
		print('D')
	else:
		print('E')

score = int(input('Please input the score...>'))
while(score != -1):
	print_grade(score)
	score = int(input('Please input the score...>'))

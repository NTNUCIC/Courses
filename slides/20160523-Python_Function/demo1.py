def say_hi():
	print('Hi~')

def say_hi_to(name):
	print('Hi, ' + name + '!')

def say_sth_to(name, greet):
	print(greet + ', ' + name + '!')

print('case 1:')
say_hi()

print('case 2:')
my_name = 'Python'
say_hi_to(my_name)

print('case 3:')
my_name = 'World'
say_sth_to(my_name, 'Hello')
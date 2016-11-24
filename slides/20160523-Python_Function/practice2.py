def C_to_F(temp):
	temp = temp*9/5+32
	return temp

def F_to_C(temp):
	temp = (temp-32)*5.0/9.0
	return temp

sel = input('\nCelsius and Fahrenheit Convert\n\n'+
	'(A) Fatrenheit to Celsius\n'+
	'(B) Celsius to Fatrenheit\n'+
	'(C) Exit\n\n'+
	'Please input...> ')
while sel != 'C':
	temp = int(input('Please input temperature...> '))
	if sel == 'A':
		temp = F_to_C(temp)
	else:
		temp = C_to_F(temp)
	print('temperature is converted into',temp)
	sel = input('\nCelsius and Fahrenheit Convert\n\n'+
	'(A) Fatrenheit to Celsius\n'+
	'(B) Celsius to Fatrenheit\n'+
	'(C) Exit\n\n'+
	'Please input...> ')

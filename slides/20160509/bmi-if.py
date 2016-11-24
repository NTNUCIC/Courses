weight = input('Please input your weight(kg)...>')
height = input('Please input your height(cm)...>')

weight = float(weight)
height = float(height) / 100

bmi = weight / (height ** 2)

print('{:>7s}\t{:> 3.2f}\tkg'.format('Weight', weight))
print('{:>7s}\t{:> 3.2f}\tcm'.format('Height', height*100))
print('{:>7s}\t{:> 3.2f}'.format('BMI', bmi))
if 18.5 <= bmi < 24:
	print("It's good!")
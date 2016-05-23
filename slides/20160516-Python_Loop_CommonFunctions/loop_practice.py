data_type_1 = [[80,74,29],[38,84,59],[49,43,78]]
Subject_total = [0,0,0]
Person_total = [0,0,0]

for x in range(0,3):
	for y in range(0,3):
		Subject_total[y] += data_type_1[x][y]
		Person_total[x] += data_type_1[x][y]

for x in range(0,3):
	Subject_total[x] /= 3
	Person_total[x] /= 3

print(Subject_total)
print(Person_total)
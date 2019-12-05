import json

with open('test.txt', 'w') as File:
	Data = {'NAME': 'OWO', 'LIST': [1, 3, 4], 'FLOAT': 3.14}
	json.dump(Data, File)

with open('test.txt', 'r') as File:
	Data = json.load(File)
	print(type(Data), Data)
	print(type(Data['LIST']), Data['LIST'])

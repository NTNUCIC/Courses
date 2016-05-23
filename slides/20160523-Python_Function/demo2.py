def mutable_or_immutable(para):
	para += '1'

a = 'a'
b = ['b']
mutable_or_immutable(a)
print(a)
mutable_or_immutable(b)
print(b)
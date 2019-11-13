import matplotlib.pyplot as plt
from math import cos, sin, pi


def toRa(h, m, s):
	return -15*(h+m/60.+s/3600.)


def toDec(h, m, s):
	return h+m/60.+s/3600.

Ra, Dec = [], []
# Polaris
Ra.append(toRa(2, 31, 47))
Dec.append(toDec(89, 15, 50))
# # Yildun
Ra.append(toRa(17, 32, 13))
Dec.append(toDec(86, 35, 12))
# ε-UMi
Ra.append(toRa(16, 45, 58))
Dec.append(toDec(82, 2, 14))
# ζ-UMi
Ra.append(toRa(15, 44, 3))
Dec.append(toDec(77, 47, 40))
# Kochab
Ra.append(toRa(14, 50, 42))
Dec.append(toDec(74, 9, 19))
# Pherkad
Ra.append(toRa(15, 20, 43))
Dec.append(toDec(71, 50, 2))
# η-UMi
Ra.append(toRa(16, 17, 30))
Dec.append(toDec(75, 45, 19))
# ζ-UMi
Ra.append(toRa(15, 44, 3))
Dec.append(toDec(77, 47, 40))

X = [-cos(Dec[i]/180*pi)*cos(Ra[i]/180*pi) for i in range(len(Dec))]
Y = [-cos(Dec[i]/180*pi)*sin(Ra[i]/180*pi) for i in range(len(Dec))]

plt.title('Ursa Minor')
plt.plot(X, Y)
plt.show()
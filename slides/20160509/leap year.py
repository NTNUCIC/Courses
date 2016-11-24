year = int(input("Please input year...>"))
month = int(input("Please input month...>"))

months = {1: 31, 2: 28, 3: 31, 4: 30, 5: 31, 6: 30, 7: 31, 8: 31, 9: 30, 10: 31, 11: 30, 12: 31}

if month in months:
	if year % 4 == 0 and year % 100 != 0 or year % 400 == 0:
		print("閏年：", year, "年", month, "月有", end=' ')
		if month == 2:
			print(months[month]+1, end=' ')
		else:
			print(months[month], end=' ')
		print('天')
	else:
		print("平年：", year, "年", month, "月有", months[month], "天")
else:
	print("Month error")

from re import *

s = "hey,y."
s = sub('[^\w\s]', '', s)
print(s)

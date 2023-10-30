from pyswip import *
from re import *

def a (l : str):
    print(l)

prolog = Prolog()
prolog.assertz("father(michael, john)")
prolog.retract("father(michael, john)")
try:
    prolog.retract("father(michael, john)")
except:
    pass
#user_input = "h,.;'!@#$%^&*()_+-=asdfghjklqwertyuiopzxcvbnm"
#user_input = sub('[^\w\s]', '', user_input)
#print(user_input)

print(list(prolog.query("father(michael, peter)")) == [])
print(list(prolog.query("father(michael, john)")) == [])



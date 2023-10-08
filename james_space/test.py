from logic import *

def X():
    return "$x"

def atomizer (x):
    return Atom(x.upper())

def Female(x):
    return Atom("Female", x)

def Mother (x):
    return Atom("Mother", x)

def Parent(x):
    return Atom("Parent", x)

def Child(x):
    return Atom("Child", x)

def isMotherOf(x, y):
    return And(And(And(And(Female(x), Mother(x)), Child(y)), Parent(x)), Atom("MotherOf", x, y))

kb = createResolutionKB()
X = "$x"

def Student(x):
    return Atom("Student", x)

def Young(x):
    return Atom("Young", x)

def Smart(x):
    return Atom("Smart", x)

print(kb.tell(Forall(X, Implies(Student(X), And(Young(X), Smart(X))))))
print(kb.tell(Student("k")))
print(kb.ask(Smart("k")))

print(type(Smart))

# print(kb.tell(Forall(X, Implies(Mother(X), Parent(X)))))
# print(kb.tell(atomizer("J")))
# print(kb.tell(atomizer("K")))
# print(kb.tell(isMotherOf("j", "k")))
# print(kb.ask(Parent("j")))
# #print(kb.ask(Implies(Mother(atomizer("J")), Parent(atomizer("J")))))
# #print(kb.ask(Implies(Mother(""), Parent(Atom("J")))))
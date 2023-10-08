from logic import *


def Male(x: str) -> Atom:
    return Atom("Male", x.lower())


def Female(x: str) -> Atom:
    return Atom("Female", x.lower())


def Child(x: str) -> Atom:
    return Atom("Child", x.lower())


def ChildOf(x: str, y: str) -> Atom:
    return Atom("ChildOf", x.lower(), y.lower())


def Parent(x: str) -> Atom:
    return Atom("Parent", x.lower())


def ParentOf(x: str, y: str) -> Atom:
    return Atom("ParentOf", x.lower(), y.lower())


def Mother(x: str) -> Atom:
    return Atom("Mother", x.lower())


def MotherOf(x: str, y: str) -> Atom:
    return Atom("MotherOf", x.lower(), y.lower())


def Father(x: str) -> Atom:
    return Atom("Father", x.lower())


def FatherOf(x: str, y: str) -> Atom:
    return Atom("FatherOf", x.lower(), y.lower())


def Grandmother(x: str) -> Atom:
    return Atom("Grandmother", x.lower())


def GrandmotherOf(x: str, y: str) -> Atom:
    return Atom("GrandmotherOf", x.lower(), y.lower())


def Grandfather(x: str) -> Atom:
    return Atom("Grandfather", x.lower())


def GrandfatherOf(x: str, y: str) -> Atom:
    return Atom("GrandfatherOf", x.lower(), y.lower())


def Aunt(x: str) -> Atom:
    return Atom("Aunt", x.lower())


def AuntOf(x: str, y: str) -> Atom:
    return Atom("AuntOf", x.lower(), y.lower())


def Uncle(x: str) -> Atom:
    return Atom("Uncle", x.lower())


def UncleOf(x: str, y: str) -> Atom:
    return Atom("UncleOf", x.lower(), y.lower())


def Son(x: str) -> Atom:
    return Atom("Son", x.lower())


def SonOf(x: str, y: str) -> Atom:
    return Atom("SonOf", x.lower(), y.lower())


def Daughter(x: str) -> Atom:
    return Atom("Daughter", x.lower())


def DaughterOf(x: str, y: str) -> Atom:
    return Atom("DaughterOf", x.lower(), y.lower())


def Brother(x: str) -> Atom:
    return Atom("Brother", x.lower())


def BrotherOf(x: str, y: str) -> Atom:
    return Atom("BrotherOf", x.lower(), y.lower())


def Sister(x: str) -> Atom:
    return Atom("Sister", x.lower())


def SisterOf(x: str, y: str) -> Atom:
    return Atom("BrotherOf", x.lower(), y.lower())


def Sibling(x: str) -> Atom:
    return Atom("Sibling", x.lower())


def SiblingOf(x: str, y: str) -> Atom:
    return Atom("SiblingOf", x.lower(), y.lower())


def AndStar(Predicates: list, index: int, X: str = "$x") -> Atom:
    if index == len(Predicates) - 1:
        return Predicates[index](X)
    else:
        return And(Predicates[index](X), AndStar(Predicates, index + 1, X))


def NotAndStar(Predicates: list, index: int, X: str = "$x") -> Atom:
    if index == len(Predicates) - 1:
        return Not(Predicates[index](X))
    else:
        return And(Not(Predicates[index](X)), AndStar(Predicates, index + 1, X))


def All_Not_Implies(Given, Predicates: list) -> Atom:
    X = "$x"
    return Forall(X, Implies(Given(X), AndStar(Predicates, 0)))


def All_Implies(Given, Predicates: list) -> Atom:
    X = "$x"
    return Forall(X, Implies(Given(X), AndStar(Predicates, 0)))


def All_Combine(Given, Yes_Predicates: list, No_Predicates: list) -> Atom:
    X = "$x"
    return And(
        All_Implies(Given, Yes_Predicates), All_Not_Implies(Given, No_Predicates)
    )


def All_Combine_Two(
    Given,
    Yes_Predicates_1: list,
    No_Predicates_1: list,
    Yes_Predicates_2: list,
    No_Predicates_2: list,
) -> Atom:
    pass

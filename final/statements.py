from pyswip import Prolog
pro = Prolog()
pro.consult('kb.pl')

yes = "Yes. That is correct."
no = "No."
maybe = "Maybe, I do not know."

# x - the relation the user is looking for
# vals - the involved individuals
# Creates code for statements structured as: is x a sister of y == sister(x,y).
# Solves statements of retval 1
# returns a statement
def generateIsPrompt(x, vals):
    prompt =  str(x) + "("+ str(vals[0]).lower() + ", " + str(vals[1]).lower()+")."
    prompt2 = "not_"+prompt
    if(list(pro.query(prompt))):
        return yes
    elif(list(pro.query(prompt2))):
        return no
    elif x == "father" or x == "mother":
        if list(pro.query("has_{}({})".format(x, vals[1]))):
            return no
    return maybe
# x - the relation the user is looking for
# vals - the involved individuals
# Creates code for statements structured as: Who are the sisters of x == sister(x,A).
# Solves statements of retval 2 and 3
# returns a statement
def generateWhoPrompt(x,val):
    if x[-1] == "s":
        prompt = str(x)[:-1]+"(A," +str(val[0]).lower()+")."
    elif x == "children":
        prompt = "child"+"(A," +str(val[0]).lower()+")."
    else:
        prompt = str(x)+"(A," +str(val[0]).lower()+")."
        person = str(val[0]).lower()
        memo = []
        memo.append(person)
        d = list(pro.query(prompt))
        res = []
        for thing in d:
            if thing.get("A") not in memo:
                res.append(thing.get("A"))
                memo.append(thing.get("A"))
    if res: 
        return res
    else:
        return False


# val - the involved individuals
# Creates code for statements structured as: Are X and Y parents of Z == parents(x,z). and parents(y,z).
# Solves statements of retval 4
# returns an array of statements
def generateParentsPrompt(val):
    res = []
    res.append("parent(" + str(val[1]).lower() +","+str(val[0]).lower()+").")
    res.append("parent(" + str(val[2]).lower() +","+str(val[0]).lower()+").")
    prompt1 = "not_"+res[0]
    prompt2 = "not_"+res[1]
    if(list(pro.query(res[0])) and list(pro.query(res[1]))):
        return yes
    elif(list(pro.query(prompt1)) or list(pro.query(prompt2))):
        return no
    return maybe

# val - the involved individuals
# c - relationship type
# Creates code for statements structured as: Are X and Y siblings? == sibling(x,y).
# Solves statements of retval 5
# returns a statement
def generateSiblingsorRelativePrompt(val,c):
    if c == "relatives" or c == "siblings":
        prompt = str(c)[:-1] +"(" + str(val[0]).lower() +","+str(val[1]).lower()+")."
    else:
        prompt = str(c) +"(" + str(val[0]).lower() +","+str(val[1]).lower()+")."
    prompt2 = "not_"+prompt
    if(list(pro.query(prompt))):
        return yes
    elif(list(pro.query(prompt2)) and str(c)[:-1] == "sibling"):
        return no
    return maybe


# val - the involved individuals
# Creates code for statements structured as: Are X1, X2, ... and Xn children of Y? == [child(x1,Y),child(x2,Y),..., child(xn,Y)].
# Solves statements of retval 6
# returns an array of statements
def generateChildrenPrompt(val):
    lol = 0
    parent = val[0]
    val.pop(0)
    for i in val:
        prompt = "child("+ i.lower() +","+ parent.lower() +")."
        prompt2 = "not_child("+ i.lower() +","+ parent.lower() +")."
        if list((pro.query(prompt2))):
            return no
        if not list((pro.query(prompt2))) and not list((pro.query(prompt))):
            lol = 1
    if(lol == 1):
        return maybe
    return yes

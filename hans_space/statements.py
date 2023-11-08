
# x - the relation the user is looking for
# vals - the involved individuals
# Creates code for statements structured as: is x a sister of y == sister(x,y).
# Solves statements of retval 1
# returns a statement
def generateIsPrompt(x, vals):
    prompt =  str(x) + "("+ str(vals[0]).lower() + "," + str(vals[1]).lower()+")."
    return prompt

# x - the relation the user is looking for
# vals - the involved individuals
# Creates code for statements structured as: Who are the sisters of x == sister(x,A).
# Solves statements of retval 2 and 3
# returns a statement
def generateWhoPrompt(x,val):
    prompt = str(x)+"(" +str(val[0]).lower() +",A)."
    return prompt

# val - the involved individuals
# Creates code for statements structured as: Are X and Y parents of Z == parents(x,z). and parents(y,z).
# Solves statements of retval 4
# returns an array of statements
def generateParentsPrompt(val):
    res = []
    res.append("parent(" + str(val[1]).lower() +","+str(val[0]).lower()+").")
    res.append("parent(" + str(val[2]).lower() +","+str(val[0]).lower()+").")
    return res

# val - the involved individuals
# Creates code for statements structured as: Are X and Y siblings? == sibling(X,Y).
# Solves statements of retval 5
# returns a statement
def generateSiblingsPrompt(val):
    res = []
    res.append("siblings(" + str(val[0]).lower() +","+str(val[1]).lower()+").")
    return res


# val - the involved individuals
# Creates code for statements structured as: Are X1, X2, ... and Xn children of Y? == [child(x1,Y),child(x2,Y),..., child(xn,Y)].
# Solves statements of retval 6
# returns an array of statements
def generateChildrenPrompt(val):
    res = []
    parent = val[0]
    val.pop(0)
    for i in val:
        res.append("child("+ i +","+ parent +").")
    return res
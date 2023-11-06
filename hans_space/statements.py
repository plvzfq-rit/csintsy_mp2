
# x - the relation the user is looking for
# vals - the involved individuals
# is x a sister of y == sister(x,y).
def generateIs(x, vals):
    prompt =  str(x) + "("+ str(vals[0]).lower() + "," + str(vals[1]).lower()+")."
    return prompt
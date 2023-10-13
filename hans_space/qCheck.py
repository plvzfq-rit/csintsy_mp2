#Lines 1-11 represent built in words that a user must choose from
validIsPrompts = ["sister", "brother", "mother","father", 
                "grandmother", "daughter", "son", "child",
                "uncle", "grandfather", "aunt"]

validWhoArePrompts = ["siblings","sisters", "brothers", "parents", 
                      "daughters", "sons", "children"]

validWhoIsPrompts = ["mother" , "father"]

valid2ArePrompts = ["siblings", "relatives","theparentsof","childrenof"]

#Function that accepts initial user prompt
#Returns False if Invalid, an Integer if Valid
def takeQprompt(p):
    
    if (p[-1] == '?'):
        p = p[:-1]
        pArr = p.split()
        try: 
            if (pArr[0] == "Is"):
                retval = __takeIsprompt(p)
            elif (pArr[0] == "Who"):
                retval = __takeWhoprompt(p)
            elif (pArr[0] == "Are"):
                retval = __takeArepromptfor2(p)
            else:
                retval = False
        except:
            return False
        return retval
    else:
        return False

#Checks all prompts that start with "is", return False if invalid, 1 if Valid
def __takeIsprompt(p):
    try:
        x = p.split()
        if x[3] in validIsPrompts and len(x) == 6 and x[2] == "a" and x[4] == "of":
            return 1
    except:
        return False
    return False

#Checks all prompts that start with "Who", return False if invalid 2 if Valid
def __takeWhoprompt(p):
    x = p.split()
    try:
        if (x[1] == "are" and x[2] == "the" and x[4] == "of" and x[3] in validWhoArePrompts):
            return 2
        elif(x[1] == "is"and x[2] == "the"  and x[4] == "of" and x[3] in validWhoIsPrompts):
            return 3
        else:
            return False
    except:
        return False
#Checks all prompts that start with "Are", return False if invalid 4,5 or 6 if Valid
def __takeArepromptfor2(p):
    x = p.split()
    if(len(x) == 8 and x[4]+x[5]+x[6] in valid2ArePrompts and x[2] == "and"): 
            return 4
    elif(x[4] in valid2ArePrompts and x[2] == "and"):
        return 5
    elif(x[-3]+x[-2] in valid2ArePrompts and x[-5] == "and"):
        return __verifyKids(x)
    else:
        return False

#A helper function that checks if the way children were inputted are valid
def __verifyKids(x):
    values = [0,-5,-3,-2,-1]
    for i in values:
        x.pop(i)
    
    valid = 6
    
    for i in range(len(x) - 2):
        if(x[i][1] != ','):
            return False

    if (valid != 6):
        return False
    else:
        return True
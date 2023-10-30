#Lines 1-11 represent built in words that a user must choose from
validIsPrompts = ["asister", "abrother", "themother","thefather", 
                "agrandmother", "adaughter", "ason", "achild",
                "anuncle", "agrandfather", "anaunt"]

validWhoArePrompts = ["siblings","sisters", "brothers", "parents", 
                      "daughters", "sons", "children"]

validWhoIsPrompts = ["mother" , "father"]

valid2ArePrompts = ["siblings", "relatives","theparentsof","childrenof"]

#Function that accepts initial user prompt
#Returns False if Invalid, an Integer, and an array with the first element being the main person, and the right the side.
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
                retval = False,None
        except:
            return False,None
        if retval is not False:
            if retval == 1:
                x = __getIsvals(pArr)
                return True,x,pArr[3]
            elif retval == 2 or retval == 3:
                x = __getWhoVals(pArr)
                return True,x,pArr[3]
            elif retval == 4:
                x = __getAreParents(pArr)
                return True,x,pArr[5]
            elif retval == 5:
                x = __getSibsandRel(pArr)
                return True,x,p[-1]
        
        return retval
    else:
        return False,None

#Checks all prompts that start with "is", return False if invalid, 1 if Valid
def __takeIsprompt(p):
    try:
        x = p.split()
        if x[2]+x[3] in validIsPrompts and len(x) == 6 and x[4] == "of":
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
    try: 
        x = p.split()
        if(len(x) == 8 and x[4]+x[5]+x[6] in valid2ArePrompts and x[2] == "and"): 
                return 4
        elif(x[4] in valid2ArePrompts and x[2] == "and"):
            return 5
        elif(x[-3]+x[-2] in valid2ArePrompts and x[-5] == "and"):
            return __verifyKids(x)
        else:
            return False
    except:
        return False

#A helper function that checks if the way children were inputted are valid
def __verifyKids(x):
    try:
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
    except:
        return False

#Function to find the X and Y on statements that start with "If"
def __getIsvals(p):
    res = []
    res.append(p[1])
    res.append(p[-1])
    return res

#Function to find the X on statements that start with "Who"
def __getWhoVals(p):
    res = []
    res.append(p[-1])
    return res


#Function to find the x,y,z on for the question Are _ and _ the parents of _?
def __getAreParents(p):
    res = []
    res.append(p[1])
    res.append(p[3])
    res.append(p[7])
    return res
#Function to get the X and Y values on questions structured as Are _ and _ siblings/relatives
def __getSibsandRel(p):
    res = []
    res.append(p[1])
    res.append(p[3])
    return res


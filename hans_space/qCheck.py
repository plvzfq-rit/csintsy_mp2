validIsPrompts = ["sister", "brother", "mother","father", 
                "grandmother", "daughter", "son", "child",
                "uncle", "grandfather", "aunt"]

validWhoArePrompts = ["siblings","sisters", "brothers", "parents", 
                      "daughters", "sons", "children"]

validWhoIsPrompts = ["mother" , "father"]

valid2ArePrompts = ["siblings", "relatives","theparentsof","childrenof"]


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

def __takeIsprompt(p):
    try:
        x = p.split()
        if x[3] in validIsPrompts and len(x) == 6 and x[2] == "a" and x[4] == "of":
            return 1
    except:
        return False
    return False

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

def __takeArepromptfor2(p):
    x = p.split()
    if(len(x) == 8 and x[4]+x[5]+x[6] in valid2ArePrompts and x[2] == "and"): 
            return 4
    elif(x[4] in valid2ArePrompts and x[2] == "and"):
        return 5
    elif(x[-3]+x[-2] in valid2ArePrompts and x[-5] == "and"):
        return 6
    else:
        return False
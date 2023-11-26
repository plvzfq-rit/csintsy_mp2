from re import *
from input_functions import *
from pyswip import Prolog
from qCheck import *
from statements import *

'''
*-------------------------------------------------------------------------------------*
Raises errors.
*-------------------------------------------------------------------------------------*
'''
def raiseError():
    print("Sorry, I do not understand.")

'''
*-------------------------------------------------------------------------------------*
Declares a specified relation from one argument to another in a given Prolog object.

@param prolog   a Prolog object to declare to
@param relation string containing specified relation
@param arg1     string containing first argument
@param arg2     string containing second argument

@return a string depicting success or failure.
*-------------------------------------------------------------------------------------*
'''
def prologAssert121(prolog : Prolog, relation : str, arg1 : str, arg2 : str) -> str:
    
    subs1 = list(prolog.query("{}({},{})".format(relation, arg1, arg2)))
    # print(subs1)

    if not subs1:
        subs2 = list(prolog.query("not_{}({},{})".format(relation, arg1, arg2)))
        # print(subs2)
        
        if not subs2:
            
            if relation == "mother" or relation == "father":
                parcheck = list(prolog.query("has_{}({})".format(relation, arg2)))
                if parcheck:
                    return "That's impossible!"
            
            prolog.assertz("{}_declaration({},{})".format(relation, arg1, arg2))
            return "OK! I learned something!"

        else:
            return "That's impossible!"
    else:
        return "I already know that!"

'''
*-------------------------------------------------------------------------------------*
Declares a specified relation from many arguments to another in a given Prolog object.

@param prolog   a Prolog object to declare to
@param relation string containing specified relation
@param args1    list of strings containing first arguments
@param arg2     string containing second argument

@return a string depicting success or failure.
*-------------------------------------------------------------------------------------*
'''
def prologAssert12X(prolog : Prolog, relation : str, args1 : list[str], arg2 : str) -> str:

    # sentinel value
    all_is_well = True

    # sentinel value 2
    knew_it = False

    # looper
    i = 0

    # loops for all arguments, except if there is an erroneous value 
    while all_is_well and i < len(args1):

        subs1 = list(prolog.query("not_{}({},{})".format(relation, args1[i], arg2)))
        
        if not subs1:
            i += 1

        else:
            all_is_well = False
    
    if relation == "parent" and all_is_well:
        parents_check = list(prolog.query("has_two_parents({})".format(arg2)))
        parent_check = list(prolog.query("has_parent({})".format(arg2)))
        parent_1_check = list(prolog.query("parent({}, {})".format(args1[0], arg2)))
        parent_2_check = list(prolog.query("parent({}, {})".format(args1[1], arg2)))
        if parents_check:
            if parent_1_check and parent_2_check:
                return "I already know this!"
            else:
                return "Some of the things you just said are just impossible!"
        elif parent_check:
            if parent_1_check and not parent_2_check:
                garbage = args1.pop(0)
                knew_it = True
            elif not parent_1_check and parent_2_check:
                garbage = args1.pop(1)
                knew_it = True
            elif parent_1_check and parent_2_check:
                return "I already know this!"
            else:
                return "That's impossible!"
    
    if relation == "child" and all_is_well:
        for child_1 in range(len(args1)):
            for child_2 in range(child_1 + 1, len(args1)):
                not_sibling_check = list(prolog.query("not_sibling({}, {})".format(args1[child_1], args1[child_2])))
                if not_sibling_check:
                    return "Some of the things you just said are just impossible!"
    
    if all_is_well:
        i = 0
        while i < len(args1):
            subs1 = list(prolog.query("{}({},{})".format(relation, args1[i], arg2)))
            if not subs1:
                prolog.assertz("{}_declaration({},{})".format(relation, args1[i], arg2))
            else:
                knew_it = knew_it or True
            i += 1
        if knew_it:
            return "I learned something new, though some were things I already knew."
        else:
            return "I learned something new!"
    else:
        return "Some of the things you just said are just impossible!"

if __name__ == "__main__":
    # creating knowledge base
    prolog = Prolog()

    # import knowledge base
    prolog.consult("kb.pl")

    # list containing special prompts to stop the program
    halters = ["end", "exit", "stop", "halt"]

    # program will run indefinitely until halted
    while True:
        # prompt for the user
        print("> ", end="")

        # accepts input from user and strips whitespace
        user_input = input().strip()

        # creates clean copy of data of punctuation (except for '_')
        user_input_copy = sub('[^\w\s]', '', user_input)
        user_input_copy = user_input_copy.lower()

        # stops the program if halted by user
        if user_input_copy in halters:
            break

        # raises an error if input is null
        elif user_input == "":
            raiseError()

        # parses input
        else:

            # identifies statements
            if user_input[-1] == ".":

                # gets statement type
                statement_type = validateStatement(user_input)

                # proceeds if statements are valid
                if statement_type != "null":

                    # splits data into words
                    words = user_input_copy.split()

                    # switch case for every possible assertion
                    match (statement_type):

                        case "father":
                            # check if KB already know it
                            print(prologAssert121(prolog, "father", words[0], words[-1]))

                        case "mother":
                            print(prologAssert121(prolog, "mother", words[0], words[-1]))

                        case "sister":
                            print(prologAssert121(prolog, "sister", words[0], words[-1]))

                        case "brother":
                            print(prologAssert121(prolog, "brother", words[0], words[-1]))

                        case "siblings":
                            print(prologAssert121(prolog, "sibling", words[0], words[2]))

                        case "grandmother":
                            print(prologAssert121(prolog, "grandmother", words[0], words[-1]))

                        case "child":
                            print(prologAssert121(prolog, "child", words[0], words[-1]))

                        case "daughter":
                            print(prologAssert121(prolog, "daughter", words[0], words[-1]))

                        case "uncle":
                            print(prologAssert121(prolog, "uncle", words[0], words[-1]))

                        case "grandfather":
                            print(prologAssert121(prolog, "grandfather", words[0], words[-1]))

                        case "son":
                            print(prologAssert121(prolog, "son", words[0], words[-1]))

                        case "aunt":
                            print(prologAssert121(prolog, "aunt", words[0], words[-1]))
                            
                        case "parents":
                            parents = [words[0], words[2]]
                            print(prologAssert12X(prolog, "parent", parents, words[-1]))
                            
                        case "children":
                            children = [words[i] for i in range(0, len(words) - 7)]
                            children.append(words[-7])
                            children.append(words[-5])
                            print(prologAssert12X(prolog, "child", children, words[-1]))

                        case _:
                            raiseError()
                else:
                    raiseError()

            # identifies queries / questions
            elif user_input[-1] == "?":
                # TODO: Implement checking for questions
                try:
                    a,c,b = takeQprompt(user_input)

                    
                    match (b):
                            case "father":
                                b = "father"

                            case "mother":
                                b = "mother"

                            case "sister":
                                b = "sister"

                            case "sisters":
                                b = "sister"

                            case "brothers":
                                b = "brother"

                            case "siblings":
                                b = "sibling"

                            case "grandmother":
                                b = "grandmother"

                            case "children":
                                b = "child"

                            case "child":
                                b = "child"

                            case "daughters":
                                b = "daughter"

                            case "uncle":
                                b = "uncle"

                            case "grandfather":
                                b = "grandfather"

                            case "sons":
                                b = "son"

                            case "aunt":
                                b = "aunt"
                                
                            case "parents":
                                b = "parent"

                    if (a == 1):
                        res = generateIsPrompt(b,c) #generate stuff for is
                    elif(a == 2 or a == 3):
                        res = generateWhoPrompt(b,c)
                    elif(a == 4):
                        res = generateParentsPrompt(c)
                    elif(a == 5):
                        res = generateSiblingsorRelativePrompt(c,b)
                    elif(a == 6):
                        res = generateChildrenPrompt(c)
                    try:
                        if (a != 2 and a != 3):
                            print(res)
                            #Implement maybe
                            #Implement No
                        else:
                            if res == False:
                                print("No one fits this description.")
                            elif len(res) == 1:
                                if(b[-1] == 's'):  
                                    print(res[0].title()+ " is the "+ b[:-1] +" of "+c[0].title())
                                else: 
                                    print(res[0].title()+ " is the "+ b +" of "+c[0].title())
                            else:
                                for index, result in enumerate(res):
                                    if index == len(res) - 1:
                                        print("and "+result.title(), end = " ")    
                                    else:
                                        print(result.title(), end = ", ")
                                print("are the " +b+ " of " + c[0])
                    except Exception as e:
                        print("I do not know.")
                except:
                    raiseError()
            # raises an error if the prompt has not been recognized
            else:
                raiseError()
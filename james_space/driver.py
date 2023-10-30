from re import *
from qCheck import *
from input_functions import *
from pyswip import *
from logic_functions import *


# raises errors
def raiseError():
    print("Sorry, I do not understand.")

'''
Declares a specified relation from one argument to another in a given Prolog object.

@param prolog   a Prolog object to declare to
@param relation string containing specified relation
@param arg1     string containing first argument
@param arg2     string containing second argument

@return a string depicting success or failure.
'''
def prologAssert121(prolog : Prolog, relation : str, arg1 : str, arg2 : str) -> str:

    # creates a declaration of the specified relation
    declaration = "{}_declaration({},{})".format(relation, arg1, arg2)

    # creates a query that would later check declarations validity
    rule_query = "{}_rule({},{})".format(relation, arg1, arg2)

    # asserts declaration
    prolog.assertz(declaration)

    # checks if declaration is valid
    substitutions = list(prolog.query(rule_query))

    # retracts if invalid and shows message showing so
    if substitutions == []:
        prolog.retract(declaration)
        return "That's impossible!"
    
    # shows confirmation message
    else:
        return "I learned something new!"

'''
Declares a specified relation from many arguments to another in a given Prolog object.

@param prolog   a Prolog object to declare to
@param relation string containing specified relation
@param args1    list of strings containing first arguments
@param arg2     string containing second argument

@return a string depicting success or failure.
'''
def prologAssert12X(prolog : Prolog, relation : str, args1 : list[str], arg2 : str) -> str:

    # sentinel value
    all_is_well = True

    # boundary of list
    num_args1 = len(args1)

    # looper
    i = 0

    # loops for all arguments, except is there is an erroneous value 
    while all_is_well and i < num_args1:

        # creates a declaration of the specified relation
        declaration = "{}_declaration({},{})".format(relation, args1[i], arg2)

        # creates a query that would later check declarations validity
        rule_query = "{}_rule({},{})".format(relation, args1[i], arg2)

        # asserts declaration
        prolog.assertz(declaration)

        # checks if declaration is valid
        substitutions = list(prolog.query(rule_query))

        # stops loop if invalid
        if substitutions == []:
            all_is_well = False

        # continues loop otherwise
        else:
            i += 1


    # activates if one of previous declarations was erroneous
    if not all_is_well:

        # another looper
        j = 0

        # gets rid of all declarations made so far
        while j <= i:

            try:
                prolog.retract("{}_declaration({},{})".format(relation, args1[j], arg2))
            except:
                pass

            # continues loop
            j += 1
        
        # says that something went wrong
        return "Some of it is impossible!"
    
    # shows confirmation message
    else:
        return "I learned something!"

if __name__ == "__main__":
    # creating knowledge base
    prolog = Prolog()

    # import knowledge base
    prolog.consult("kb.pl")

    # list containing special prompts to stop the program
    halters = ["end", "exit", "stop"]

    # program will run indefinitely until halted
    while True:
        # prompt for the user
        print("> ", end="")

        # accepts input from user and strips whitespace
        user_input = input().strip().lower()

        # creates clean copy of data of punctuation (except for '_')
        user_input_copy = sub('[^\w\s]', '', user_input)

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
                    
                    # cleans data of punctuation (except for '_')
                    # user_input = sub('[^\w\s]', '', user_input)

                    # splits data into words
                    words = user_input_copy.split()

                    # switch case for every possible assertion
                    match (statement_type):

                        case "father":
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
                if takeQprompt(user_input):
                    print("Oho, a question")

                else:
                    raiseError()

            # raises an error if the prompt has not been recognized
            else:
                raiseError()

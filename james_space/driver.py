from logic import *
from re import *
from input_functions import *
from logic_functions import *


# raises errors
def raiseError():
    print("Sorry, I do not understand.")


if __name__ == "__main__":
    # creating knowledge base
    kb = createResolutionKB()

    X = "$x"
    Y = "$y"

    # list containing special prompts to stop the program
    halters = ["end", "exit", "stop"]

    # program will run indefinitely until halted
    while True:
        # prompt for the user
        print("> ", end="")

        # accepts input from user and strips whitespace
        user_input = input().strip()

        # stops the program if halted by user
        if user_input in halters:
            break

        elif user_input == "":
            raiseError()

        elif user_input == "pyk":
            print(kb.getAllConstants())

        # parses input
        else:
            # identifies statements
            if user_input[-1] == ".":
                statement_type = validateStatement(user_input)

                if statement_type != "null":
                    
                    user_input = sub('[^\w\s]', '', user_input)
                    words = user_input.split()
                    # words[-1] = words[-1][0 : len(words[-1]) - 1] 

                    match (statement_type):

                        case "father":
                            print(kb.tell(FatherOf(words[0], words[-1])))

                        case "mother":
                            print(kb.tell(MotherOf(words[0], words[-1])))

                        case "sister":
                            print(kb.tell(SisterOf(words[0], words[-1])))

                        case "brother":
                            print(kb.tell(BrotherOf(words[0], words[-1])))

                        case "siblings":
                            print(kb.tell(SiblingOf(words[0], words[2])))

                        case "grandmother":
                            print(kb.tell(GrandmotherOf(words[0], words[-1])))

                        case "child":
                            print(kb.tell(ChildOf(words[0], words[-1])))

                        case "daughter":
                            print(kb.tell(DaughterOf(words[0], words[-1])))

                        case "uncle":
                            print(kb.tell(UncleOf(words[0], words[-1])))

                        case "grandfather":
                            print(kb.tell(GrandfatherOf(words[0], words[-1])))

                        case "son":
                            print(kb.tell(SonOf(words[0], words[-1])))

                        case "aunt":
                            print(kb.tell(AuntOf(words[0], words[-1])))

                        case "parents":
                            print(kb.tell(ParentOf(words[0], words[-1])))
                            print(kb.tell(ParentOf(words[2], words[-1])))

                        case "children":
                            for i in range(0, len(words) - 7):
                                print(kb.tell(ChildOf(words[i], words[-1])))
                            print(kb.tell(ChildOf(words[-7], words[-1])))
                            print(kb.tell(ChildOf(words[-5], words[-1])))

                        case _:
                            raiseError()
                else:
                    raiseError()

            # identifies queries / questions
            elif user_input[-1] == "?":
                # TODO: Implement checking for questions
                if True:
                    pass

                else:
                    raiseError()

            # raises an error if the prompt has not been recognized
            else:
                raiseError()

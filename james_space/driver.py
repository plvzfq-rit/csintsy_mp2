from logic import *
from input_functions import *
from logic_functions import *


# raises errors
def raiseError():
    print("Sorry, I do not understand.")


if __name__ == "__main__":
    # creating knowledge base
    kb = createResolutionKB()

    kb.tell(All_Combine(Mother, [Parent, Female], [Father]))
    kb.tell(All_Combine(Father, [Parent, Male], [Mother]))

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

        # parses input
        else:
            # identifies statements
            if user_input[-1] == ".":
                statement_type = validateStatement(user_input)

                if statement_type != "null":
                    # TODO: Implement parsing.
                    print("Understandable, have a nice day")

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

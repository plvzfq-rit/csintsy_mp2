from re import *

def validateStatement(user_input: str) -> str:
    # regular expression for general pattern of is-a statement
    generalStatementPattern = compile(".*\sis\s(an|a|the)\s.*\sof\s.*\.")

    # list of words in statement
    words = user_input.split()

    # removal of period in statement (TO BE MOVED)
    words[-1] = words[-1][0 : len(words[-1]) - 1]

    # list of words where relation is one-to-one
    definitives = ["father", "mother"]

    # list of words where relation may be multiple
    undefinitives = [
        "sister",
        "grandmother",
        "child",
        "daughter",
        "brother",
        "grandfather",
        "son",
        "aunt",
        "uncle",
        "siblings",
        "parents"
    ]

    # select list of vowels in the English language
    vowels = ["a", "e", "i", "o", "u"]

    if len(words) < 4:
        return "null"

    # checking for statements following the is-a structure
    elif generalStatementPattern.match(user_input):
        
        # switch case
        match (words[2]):
            # checking for "the"
            case "the":
                # must be a definitive, else false
                if words[3] in definitives and words[0].istitle() and words[-1][:len(words[-1])].istitle():
                    return words[3]

                else:
                    return "null"

            # checking for "an"
            case "an":
                # must be undefinitive and starting with a vowel
                if words[3] in undefinitives and words[3][0] in vowels and words[0].istitle() and words[-1][:len(words[-1])].istitle():
                    return words[3]

                else:
                    return "null"

            # checking for "a"
            case "a":
                # must be undefinitive and starting with a consonant
                if words[3] in undefinitives and words[3][0] not in vowels and words[0].istitle() and words[-1][:len(words[-1])].istitle():
                    return words[3]

                else:
                    return "null"

            # default case
            case _:
                return "null"

    elif words[1] == "and" and words[3] == "are" and words[4] == "siblings" and words[0].istitle() and words[2].istitle():
        return words[4]

    elif (
        words[1] == "and"
        and words[3] == "are"
        and words[4] == "the"
        and words[5] == "parents"
        and words[6] == "of"
        and words[0].istitle()
        and words[2].istitle()
    ):
        return words[5]

    elif (
        words[-2] == "of"
        and words[-3] == "children"
        and words[-4] == "are"
        and words[-6] == "and"
    ):
        comma_checker = True
        for i in range(len(words) - 7):
            comma_checker = comma_checker and words[i][-1] == ","
        if comma_checker == True:
            children = [sub('[^\w\s]', '', words[i]) for i in range(0, len(words) - 7)]
            children.append(sub('[^\w\s]', '', words[-7]))
            children.append(sub('[^\w\s]', '', words[-5]))
            areLegal = True
            for child in children:
                areLegal = areLegal and child.istitle()
            if areLegal:
                return "children"
            else:
                return "null"
        else:
            return "null"
        
    else:
        return "null"

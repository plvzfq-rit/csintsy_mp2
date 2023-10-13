import qCheck;

prompts = ["sister", "brother", "mother","father", 
                "grandmother", "daughter", "son", "child",
                "uncle", "grandfather", "aunt"]

validWhoArePrompts = ["siblings","sisters", "brothers", "parents", 
                      "daughters", "sons", "children"]

validWhoIsPrompts = ["mother" , "father"]


valid2ArePrompts = ["siblings?", "relatives?","theparentsof","childrenof"]

def printLine():
    for i in range (2):
        print()

print("Test Is Prompt")
IspartOne = "Is x a "
IspartTwo = " of y?"
for i in range (len(prompts)):
    prompt = IspartOne + prompts[i] + IspartTwo
    isValid = qCheck.takeQprompt(prompt)
    print (isValid)
printLine()


i = 0
print("Test Who Are Prompt")
IspartOne = "Who are the "
for i in range (len(validWhoArePrompts)):
    prompt = IspartOne + validWhoArePrompts[i] + " of y?"
    isValid = qCheck.takeQprompt(prompt)
    print (isValid)
i = 0
printLine()



print("Test Who Is Prompt")
IspartOne = "Who is the "
for i in range (len(validWhoIsPrompts)):
    prompt = IspartOne + validWhoIsPrompts[i]+ " of y?"
    isValid = qCheck.takeQprompt(prompt)
    print (isValid)
printLine()


print("Test Are prompt")
IspartOne = "Are x and y "
for i in range (2):
    prompt = IspartOne + valid2ArePrompts[i]
    isValid = qCheck.takeQprompt(prompt)
    print (isValid)
printLine()

IspartOne = "Are x and y the parents of z?"
prompt = IspartOne
isValid = qCheck.takeQprompt(prompt)
print (isValid)
IspartOne = "Are x, y and z children of z?"
prompt = IspartOne
isValid = qCheck.takeQprompt(prompt)
print (isValid)






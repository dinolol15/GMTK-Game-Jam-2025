import random

verbinfint = ["agree", "dare", "decide", "expect", "fail", "happen", "hope", "manage", "mean", "offer", "prepare", "pretend", "promise", "refuse", "seem", "want"]
verb_ing = ["avoid", "can't face", "can't help", "can't stand", "don't mind", "enjoy", "fancy", "feel like", "finish", "give up", "imagine", "keep", "postphone", "practise", "put off", "recommend", "risk", "spend time", "suggest"]


def choix(lis):
    global a
    a = random.choice(lis)
    print(a)
    b = input("")
    
    


while True:
    a = random.randint(1,2)
    if a == 1:
        choix(verbinfint)
        print("verb infinit")
        b = input("")
        if b == "YeS":
            verbinfint.remove(a)
        print("\n _______________")
    elif a == 2:
        choix(verb_ing)
        print("verb_ing")
        b = input("")
        if b == "YeS":
            verb_ing.remove(a)
        print("\n _______________")
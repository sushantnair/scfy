from django.shortcuts import render

learning_rules_dict = {
    "perceptron": "Perceptron Learning Rule",
    "delta": "Delta Learning Rule",
    "hebbian": "Hebbian Learning Rule",
    "widrowhoff": "Widrow-Hoff Learning Rule",
} 

# Create your views here.
def learnrule(request, lr_name):
    try:
        lr_desc = learning_rules_dict[lr_name]
        if lr_name == "perceptron":
            return render(request, "learning_rules/perceptron.html", {
                "desc": lr_desc, "rule": lr_name,
            })
        elif lr_name == "delta":
            return render(request, "learning_rules/delta.html", {
                "desc": lr_desc, "rule": lr_name,
            })
        elif lr_name == "hebbian":
            return render(request, "learning_rules/hebbian.html", {
                "desc": lr_desc, "rule": lr_name,
            })
        elif lr_name == "widrowhoff":
            return render(request, "learning_rules/widrowhoff.html", {
                "desc": lr_desc, "rule": lr_name,
            })
        else:
            return render(request, "404.html")
    except:
        return render(request, "404.html")
    
def allpages(request):
    learning_rules = list(learning_rules_dict.keys())
    return render(request, "learning_rules/index.html", {
        "learning_rules": learning_rules
    }) 
 
from django.shortcuts import render
from main.models import Code, Page
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
            # Obtaining pgid value
            lr_page_dataset = Page.objects.filter(pgnm=lr_name)
            for lr_page_data in lr_page_dataset:
                lr_page_id = lr_page_data.pgid
            code_objects = Code.objects.filter(pgid=lr_page_id, show=True)
            # Extract the code content from code_objects
            code_content = [code.code for code in code_objects]
            return render(request, "learning_rules/perceptron.html", {
                "desc": lr_desc, "rule": lr_name, "code": code_content[0],
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
 
from django.shortcuts import render, HttpResponse, redirect
#from django.contrib.auth.models import User
from main.models import UserTable, Code, Contributors, Page
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password

# Create your views here.
@login_required(login_url='login')
def HomePage(request):
    lr_pages_data = Page.objects.all()
    # ----- lr_pages_data -----
    # lr_pages_id   lr_pages_nm
    # PGID          PGNM
    # 1             Perceptron
    # 2             Delta
    # ...
    lr_pages_id = list()
    lr_pages_nm = list()
    for lr_page_data in lr_pages_data:
        lr_page_id = lr_page_data.pgid
        lr_pages_id.append(lr_page_id)
        lr_page_nm = lr_page_data.pgnm
        lr_pages_nm.append(lr_page_nm)
    return render(request, 'main/home.html', {"lr_pages_nm": lr_pages_nm})

def SignupPage(request):
    if request.method == 'POST':
        uname = request.POST.get('username')
        email = request.POST.get('email')
        pass1 = request.POST.get('password1')
        pass2 = request.POST.get('password2')
        usrct = UserTable.objects.count()
        if pass1 != pass2:
            return HttpResponse("Your password and confirm password are not Same!!")
        else:
            hashed_password = make_password(pass1)
            my_user = UserTable(usrid = usrct+1, uname = uname, email = email, password = hashed_password)
            my_user.save()
            return redirect('login')
    else:
        return render(request, 'main/signup.html')
    
def LoginPage(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        pass1 = request.POST.get('pass')
        user = authenticate(request, uname=username, password=pass1)
        if user is not None:
            login(request, user)
            request.session['uname'] = username
            user_details = UserTable.objects.filter(uname=username)
            for user_detail in user_details:
                request.session['email'] = user_detail.email
                request.session['usrid'] = user_detail.usrid
            return redirect('home')
        else:
            return HttpResponse("Username or Password is incorrect!!!")
    else:
        return render(request, 'main/login.html')

def LogoutPage(request):
    logout(request)
    return redirect('login')

def Contribute(request, rule_name):
    if request.method == 'POST':
        # Obtaining pgid value (1/5)
        lr_page_dataset = Page.objects.filter(pgnm=rule_name)
        for lr_page_data in lr_page_dataset:
            lr_page_id = lr_page_data.pgid
        # Obtaining code (2/5)
        code = request.POST.get('code')
        # Creating Code ID (3/5)
        codecount = Code.objects.count()
        cdid = codecount + 1
        # Setting Show (4/5)
        show = False
        # Obtaining Language (5/5)
        lang = request.POST.get('lang')
        # Updating Code table
        code_data = Code(pgid=lr_page_id, code=code, cdid=cdid, lang=lang, show=show)
        code_data.save()
        # Updating Contributors table
        contributor_data = Contributors(userid=request.session.get('usrid'), codeid=cdid)
        contributor_data.save()
        return redirect('home')
    return render(request, "main/contribute.html", {"rule_name": rule_name, 
                                                    "uname": request.session.get('uname'), 
                                                    "email": request.session.get('email'), 
                                                    "usrid": request.session.get('usrid')})

def Dashboard(request):
    # Get data from Contributors table
    codes_contributed = Contributors.objects.filter(userid=request.session.get('usrid'))
    #   USERID  CODEID  --- Collectively, table is codes_contributed
    #   1       1       --- Individually, a row is code_contributed
    #   1       2
    # Get all codes contributed by a particular user in a single variable
    code_data = Code.objects.filter(cdid__in=[code_contributed.codeid for code_contributed in codes_contributed])
    # Create a list to store merged data
    merged_data = list()
    # Extracting data for each code contributed
    for code_contributed in codes_contributed:
        code_record = code_data.filter(cdid=code_contributed.codeid).first()
        if code_record:
            # Merge data from both tables
            merged_data.append({
                "codeid": code_contributed.codeid,
                "pgid": code_record.pgid,
                "code": code_record.code,
                "lang": code_record.lang,
                "show": code_record.show,
            })
        else:
            merged_data.append({
                "codeid": code_contributed.codeid,
            })

    return render(request, "main/dashboard.html", {"uname": request.session.get('uname'), 
                                                   "email": request.session.get('email'), 
                                                   "usrid": request.session.get('usrid'),
                                                   "c_lst": merged_data})
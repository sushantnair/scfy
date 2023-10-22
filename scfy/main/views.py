from django.shortcuts import render, HttpResponse, redirect
#from django.contrib.auth.models import User
from main.models import UserTable
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password

# Create your views here.
@login_required(login_url='login')
def HomePage(request):
    return render(request, 'main/home.html')
 
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
            return render(request, 'main/home.html', {"uname": request.session.get('uname'), "email": request.session.get('email'), "usrid": request.session.get('usrid')})
        else:
            return HttpResponse("Username or Password is incorrect!!!")
    else:
        return render(request, 'main/login.html')

def LogoutPage(request):
    logout(request)
    return redirect('login')

def Contribute(request):
    return render(request, "main/contribute.html", {"uname": request.session.get('uname'), "email": request.session.get('email'), "usrid": request.session.get('usrid')})

def Dashboard(request):
    return render(request, "main/dashboard.html", {"uname": request.session.get('uname'), "email": request.session.get('email'), "usrid": request.session.get('usrid')})
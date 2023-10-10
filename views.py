from django.shortcuts import render, redirect
from .models import UserInfo

# Create your views here.


def users(request):
    if request.method == 'POST':
        data = request.POST
        user_name = data.get('user_name')
        user_description = data.get('user_description')
        user_image = request.FILES.get('user_image')

        UserInfo.objects.create(
            user_name=user_name,
            user_description=user_description,
            user_image=user_image,
        )

        return redirect('/')

    return render(request, 'userInfo.html')

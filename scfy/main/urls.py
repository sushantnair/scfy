from . import views
from django.urls import path

urlpatterns = [
    path('signup/', views.SignupPage, name='signup'),
    path('', views.LoginPage, name='login'),
    path('home/', views.HomePage, name='home'),
    path('logout/', views.LogoutPage, name='logout'),
    path('contribute/<str:rule_name>', views.Contribute, name='contribute'),
    path('dashboard/', views.Dashboard, name='dashboard'),
]  
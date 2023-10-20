from . import views
from django.urls import path
urlpatterns = [
    path("", views.allpages),
    path("<lr_name>", views.learnrule, name="lr_name"),
]  
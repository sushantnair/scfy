from django.contrib import admin
from .models import *

# Register your models here.
class UserDisplay(admin.ModelAdmin):
    list_display = ('usrid', 'uname', 'email', 'password')
admin.site.register(UserTable, UserDisplay)

class PageDisplay(admin.ModelAdmin):
    list_display = ('pgid', 'pgnm')
admin.site.register(Page, PageDisplay)

class CodeDisplay(admin.ModelAdmin):
    list_display = ('pgid', 'code', 'cdid', 'lang', 'show')
admin.site.register(Code, CodeDisplay)

class ContributorsDisplay(admin.ModelAdmin):
    list_display = ('userid', 'codeid')
admin.site.register(Contributors, ContributorsDisplay)
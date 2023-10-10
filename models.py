from django.db import models

# Create your models here.


class UserInfo(models.Model):
    user_name = models.CharField(max_length=100)
    user_description = models.TextField()
    user_image = models.ImageField(upload_to='users')

from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models

class UserTableManager(BaseUserManager):
    def create_user(self, uname, email, password=None):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(uname=uname, email=email)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, uname, email, password):
        user = self.create_user(uname, email, password)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user

class UserTable(AbstractBaseUser, PermissionsMixin):
    usrid = models.AutoField(primary_key=True)
    uname = models.CharField(max_length=255, unique=True)
    email = models.EmailField(max_length=255, unique=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UserTableManager()

    USERNAME_FIELD = 'uname'
    REQUIRED_FIELDS = ['email']

    def __str__(self):
        return self.uname

class Page(models.Model):
    pgid = models.IntegerField()
    pgnm = models.CharField(max_length=100)

class Code(models.Model):
    pgid = models.IntegerField()                # Page id
    code = models.TextField()                   # Actual code to be displayed
    cdid = models.IntegerField()                # Code id
    show = models.BooleanField(default=False)   # Show flag
    # Show flag is used as for a particular page, there can be multiple codes which are 
    # contributed by multiple users. But we want to show only one code in the page.
    # So by default the code contributed by a user won't be shown immediately on the page.
    # It will be shown when the admin accepts the contributed code by setting show to True.

class Contributors(models.Model):
    userid = models.IntegerField()
    codeid = models.IntegerField()

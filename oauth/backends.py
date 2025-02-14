from django.contrib.auth.backends import BaseBackend
from django.contrib.auth.hashers import check_password
from .models import UsersDB

class CustomBackend(BaseBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        try:
            user = UsersDB.objects.get(email=username)
            if user and check_password(password, user.password):
                return user
        except UsersDB.DoesNotExist:
            return None

    def get_user(self, user_id):
        try:
            return UsersDB.objects.get(pk=user_id)
        except UsersDB.DoesNotExist:
            return None

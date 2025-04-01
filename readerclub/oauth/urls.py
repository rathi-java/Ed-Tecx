from django.urls import path
from .views import *

urlpatterns = [
    path('signup/', signup, name='signup'),
    path('login/', user_login, name='login'),
    path('logout/', logout_page, name='logout'),
    path('profile/', profile, name='profile'),
    path('profile/update/', update_profile, name='update_profile'),
    path("generate-otp/", generate_otp, name="generate_otp"),  # Generates OTP
    path("send_email/", send_email, name="send_email"),
    path("verify_otp/", verify_otp, name="verify_otp"),
    path("reset_password/", reset_password, name="reset_password"),
    path('report/', report_issue, name='report_issue'),
    path('refer/', refer_friend, name='refer_friend'),
]

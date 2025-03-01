"""
Django settings for Ed_Tecx project.

Generated by 'django-admin startproject' using Django 5.1.4.

For more information on this file, see
https://docs.djangoproject.com/en/5.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/5.1/ref/settings/
"""
import os
from pathlib import Path
import pymysql
pymysql.install_as_MySQLdb()


import json

# Read the secrets.json file



# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-mp$6t+(&#r+f5z97ggc%l0_%2efeg%bj713nhu-y=f16y_pmgs'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['127.0.0.1', 'localhost']
AUTH_USER_MODEL = 'oauth.UsersDB'
# Application definition


SITE_ID = 1

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'compiler',
    'roadmap',
    'exam_registration',
    'examportol',
    'placement_stories',
    # 'demo_exam',
    'practice_question',
    'jobportol',
    'oauth',
    'admin_portal',
    'certificate_management',
    'price',
    # for Google auth
    'django.contrib.sites',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'allauth.socialaccount.providers.google',
    'allauth.socialaccount.providers.github',
    'dbtools',
    'policies',    
]

# for Google auth
SOCIALACCOUNT_PROVIDERS = {
    "google": {
        "SCOPE": ["profile", "email"],
        "AUTH_PARAMS": {"access_type": "online"},
        'OAUTH_PKCE_ENABLED': True,
    },
    "github": {
        "SCOPE": ["read:user", "user:email"],  
        "AUTH_PARAMS": {"access_type": "online"},
        'OAUTH_PKCE_ENABLED': True,
       
    }   
}


MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'allauth.account.middleware.AccountMiddleware',  # for Google auth
    'oauth.middleware.EnsureUserIdMiddleware',         # run this last
]


ROOT_URLCONF = 'Ed_Tecx.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': ['templates', os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'oauth.context_processors.college_list',
                'oauth.context_processors.current_user'

            ],
        },
    },
]

WSGI_APPLICATION = 'Ed_Tecx.wsgi.application'

# Database
# https://docs.djangoproject.com/en/5.1/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'ed_tecx',  # Ensure this matches exactly
        'USER': 'root',
        'PASSWORD': 'Delta@123',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

# Password validation
# https://docs.djangoproject.com/en/5.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
# https://docs.djangoproject.com/en/5.1/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.1/howto/static-files/

STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]

# Default primary key field type
# https://docs.djangoproject.com/en/5.1/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

#for google auth
AUTHENTICATION_BACKENDS = (
    "django.contrib.auth.backends.ModelBackend",
    "allauth.account.auth_backends.AuthenticationBackend",
)

SOCIALACCOUNT_ADAPTER = 'oauth.adapters.CustomSocialAccountAdapter'

LOGIN_REDIRECT_URL = "/"
LOGOUT_REDIRECT_URL = "profile"
SOCIALACCOUNT_LOGIN_ON_GET =True
SESSION_COOKIE_AGE = 1209600  # Two weeks in seconds
SESSION_EXPIRE_AT_BROWSER_CLOSE = False
SESSION_SAVE_EVERY_REQUEST = True

# Session settings
SESSION_ENGINE = 'django.contrib.sessions.backends.db'  # Use database-backed sessions
SESSION_COOKIE_NAME = 'sessionid'  # Name of the session cookie
SESSION_COOKIE_SECURE = False  # Set to True if using HTTPS
SESSION_COOKIE_HTTPONLY = True  # Prevent JavaScript from accessing the session cookie
SESSION_COOKIE_SAMESITE = 'Lax'  # Adjust as needed ('Lax', 'Strict', 'None')
SESSION_EXPIRE_AT_BROWSER_CLOSE = False  # Keep session after browser is closed
SESSION_COOKIE_AGE = 1209600  # Session expiry in seconds (2 weeks)

# settings.py
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '{levelname} {asctime} {module} {message}',
            'style': '{',
        },
    },
    'handlers': {
        'file': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': 'debug.log',
            'formatter': 'verbose',
        },
    },
    'loggers': {
        '': {  # Root logger
            'handlers': ['file'],
            'level': 'DEBUG',
        },
    },
}
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'  # For development
SOCIALACCOUNT_EMAIL_VERIFICATION = 'none'  # Disable social email verification
SOCIALACCOUNT_EMAIL_REQUIRED = False
ACCOUNT_EMAIL_REQUIRED = False
with open(os.path.join(BASE_DIR, "secrets.json")) as secrets_file:
    secrets = json.load(secrets_file)

# Store API keys securely
RAZORPAY_KEY_ID = secrets.get("RAZORPAY_KEY_ID")
RAZORPAY_KEY_SECRET = secrets.get("RAZORPAY_SECRET_KEY")
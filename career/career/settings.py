"""
Django settings for career project.

Generated by 'django-admin startproject' using Django 5.1.5.

For more information on this file, see
https://docs.djangoproject.com/en/5.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/5.1/ref/settings/
"""

from pathlib import Path
import os
import dotenv

import pymysql
pymysql.install_as_MySQLdb()

dotenv.load_dotenv()
# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

CAREER_URL = os.getenv('CAREER_URL', 'http://127.0.0.1:8001') 
# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.1/howto/deployment/checklist/

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.getenv("CAREER_DEBUG", "False").lower() == "true"
ALLOWED_HOSTS = ['career.readerclub.in', '127.0.0.1', 'localhost']


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',  # Ensure this line is present
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django_elasticsearch_dsl',
    'job_portal',
    'policies',
    'widget_tweaks',
    'oauth',
    'internship_portal',
    'abroad_studies',
    # for Google auth
    'django.contrib.sites',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'allauth.socialaccount.providers.google',
    'allauth.socialaccount.providers.github',
]

# for Google auth
SOCIALACCOUNT_PROVIDERS = {
    "google": {
        "SCOPE": ["profile", "email"],
        "AUTH_PARAMS": {"access_type": "online"},
        "OAUTH_PKCE_ENABLED": True,
        "APP": {
            "client_id": os.getenv("READERCLUB_GOOGLE_CLIENT_ID"),
            "secret": os.getenv("READERCLUB_GOOGLE_CLIENT_SECRET"),
        }
    },
    "github": {
        "SCOPE": ["read:user", "user:email"],
        "AUTH_PARAMS": {"access_type": "online"},
        "OAUTH_PKCE_ENABLED": True,
        "APP": {
            "client_id": os.getenv("READERCLUB_GITHUB_CLIENT_ID"),
            "secret": os.getenv("READERCLUB_GITHUB_CLIENT_SECRET"),
        }
    }
}

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',  # Add WhiteNoise middleware
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'allauth.account.middleware.AccountMiddleware',  # for Google auth
    'career.middleware.LoginRequiredMiddleware',
    'career.middleware.EnsureUserIdMiddleware',

]
SITE_ID = 1

ROOT_URLCONF = 'career.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
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

WSGI_APPLICATION = 'career.wsgi.application'


# Database
# https://docs.djangoproject.com/en/5.1/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.getenv("CAREER_DB_NAME"),
        'USER': os.getenv("CAREER_DB_USER"),
        'PASSWORD': os.getenv("CAREER_DB_PASSWORD"),
        'HOST': os.getenv( "CAREER_DB_HOST"),
        'PORT': os.getenv("CAREER_DB_PORT"),
    }
}
ELASTICSEARCH_DSL = {
    'default': {
        # 'hosts': ['http://localhost:9200'],
        'hosts': [os.getenv("CAREER_ELASTICSEARCH_HOST")],
        # 'http_auth': ('elastic', 'password'),
        'verify_certs': False,
    },
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
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    BASE_DIR / "static",
]
STATIC_ROOT = BASE_DIR / "staticfiles"  # Add this line

# WhiteNoise settings
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Media files (Uploaded by users)
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / "media"

# Default primary key field type
# https://docs.djangoproject.com/en/5.1/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

SESSION_ENGINE = 'django.contrib.sessions.backends.db'
SESSION_COOKIE_NAME = 'sessionid'     # same name

SESSION_COOKIE_DOMAIN = os.getenv("CAREER_SESSION_COOKIE_DOMAIN")
SECRET_KEY = 'django-insecure-mp$6t+(&#r+f5z97ggc%l0_%2efeg%bj713nhu-y=f16y_pmgs'

AUTH_USER_MODEL = 'oauth.UsersDB'

PUBLIC_PATHS = [
    '/',
    '/oauth/',
    '/login/',
    '/policies/',
    '/maintenence/'
    # Add any other unrestricted paths
]

SOCIALACCOUNT_LOGIN_ON_GET = True
LOGIN_REDIRECT_URL = '/'

SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
CSRF_TRUSTED_ORIGINS = ['https://career.readerclub.in']

LOGOUT_REDIRECT_URL = "/"
CAREER_URL=os.getenv('CAREER_URL', 'http://127.0.0.1:8001')
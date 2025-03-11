"""
Django settings for readerclub project.

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
import dotenv
dotenv.load_dotenv()

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv("SECRET_KEY")


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.getenv("DEBUG", "False").lower() == "true"


ALLOWED_HOSTS = ['readerclub.in' , '127.0.0.1',  'localhost']
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
    # 'jobportol',
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
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'allauth.account.middleware.AccountMiddleware',  # for Google auth
    'oauth.middleware.EnsureUserIdMiddleware',
    'admin_portal.middleware.DashboardAccessMiddleware', 
    'oauth.middleware.LoginRequiredMiddleware', 
    

       
]


ROOT_URLCONF = 'readerclub.urls'

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

WSGI_APPLICATION = 'readerclub.wsgi.application'

# Database
# https://docs.djangoproject.com/en/5.1/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.getenv("DB_NAME"),
        'USER': os.getenv("DB_USER"),
        'PASSWORD': os.getenv("DB_PASSWORD"),
        'HOST': os.getenv( "DB_HOST"),
        'PORT': os.getenv("DB_PORT"),
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
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')  # Add this line

# WhiteNoise settings
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

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
SESSION_COOKIE_SECURE = True  # Set to True if using HTTPS
SESSION_COOKIE_HTTPONLY = True  # Prevent JavaScript from accessing the session cookie
SESSION_COOKIE_SAMESITE = 'Lax'  # Adjust as needed ('Lax', 'Strict', 'None')
SESSION_EXPIRE_AT_BROWSER_CLOSE = False  # Keep session after browser is closed
SESSION_COOKIE_AGE = 1209600  # Session expiry in seconds (2 weeks)
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
CSRF_TRUSTED_ORIGINS = os.getenv("READERCLUB_CSRF_TRUSTED_ORIGINS").split(" ")
CSRF_COOKIE_DOMAIN = os.getenv("CSRF_COOKIE_DOMAIN")

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

# Secrets securely access
RAZORPAY_KEY_ID = os.getenv("READERCLUB_RAZORPAY_KEY_ID")
RAZORPAY_KEY_SECRET = os.getenv("READERCLUB_RAZORPAY_KEY_SECRET")


# Email Configuration
EMAIL_HOST_USER = os.getenv("READERCLUB_EMAIL_HOST_USER")
EMAIL_HOST_PASSWORD = os.getenv("READERCLUB_EMAIL_HOST_PASSWORD")
# Settings for social auth
SOCIAL_AUTH_PIPELINE = (
    'social_core.pipeline.social_auth.social_details',
    'social_core.pipeline.social_auth.social_uid',
    'social_core.pipeline.social_auth.auth_allowed',
    'social_core.pipeline.social_auth.social_user',
    'social_core.pipeline.user.get_username',
    'social_core.pipeline.user.create_user',
    'social_core.pipeline.social_auth.associate_user',
    'social_core.pipeline.social_auth.load_extra_data',
    'social_core.pipeline.user.user_details',
)

# Add to PUBLIC_PATHS in settings
PUBLIC_PATHS = [
    '/',
    '/accounts/login',
    '/accounts/signup',
    '/accounts/google/login/',
    '/accounts/github/login/',
    '/accounts/social-auth/',
    '/price/',

]

LOGIN_URL = '/login/'

SESSION_ENGINE = 'django.contrib.sessions.backends.db'
SESSION_COOKIE_NAME = 'sessionid'
SESSION_COOKIE_DOMAIN = "127.0.0.1" 
SESSION_COOKIE_AGE = 1209600  # etc.
SESSION_SAVE_EVERY_REQUEST = True
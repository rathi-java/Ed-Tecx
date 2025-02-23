from django.apps import AppConfig

class AdminPortalConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'admin_portal'

    def ready(self):
        import admin_portal.signals  # Import signals to activate them

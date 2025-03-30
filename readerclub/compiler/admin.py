from django.contrib import admin
from .models import CompilerUsage, CodeSubmission

@admin.register(CompilerUsage)
class CompilerUsageAdmin(admin.ModelAdmin):
    list_display = ['user', 'hit', 'get_user_email', 'get_user_subscription']
    list_filter = ['hit']
    search_fields = ['user__username', 'user__email', 'user__full_name']
    
    def get_user_email(self, obj):
        return obj.user.email if obj.user.email else "N/A"
    get_user_email.short_description = 'Email'
    
    def get_user_subscription(self, obj):
        if hasattr(obj.user, 'is_subscription_active') and obj.user.is_subscription_active():
            return "Active"
        return "None"
    get_user_subscription.short_description = 'Subscription'

@admin.register(CodeSubmission)
class CodeSubmissionAdmin(admin.ModelAdmin):
    list_display = ['id', 'language', 'created_at', 'truncated_code', 'truncated_output']
    list_filter = ['language', 'created_at']
    search_fields = ['code', 'output']
    
    def truncated_code(self, obj):
        return (obj.code[:50] + '...') if len(obj.code) > 50 else obj.code
    truncated_code.short_description = 'Code'
    
    def truncated_output(self, obj):
        return (obj.output[:50] + '...') if obj.output and len(obj.output) > 50 else obj.output
    truncated_output.short_description = 'Output'

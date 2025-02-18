from django.contrib import admin
from .models import *

@admin.register(SuperAdminDB)
class SuperAdminAdmin(admin.ModelAdmin):
    list_display = ('username', 'full_name', 'email', 'phone_number')
    search_fields = ('username', 'full_name', 'email')
    readonly_fields = ('username',)

@admin.register(AdminDB)
class AdminAdmin(admin.ModelAdmin):
    list_display = ('username', 'full_name', 'email', 'phone_number')
    search_fields = ('username', 'full_name', 'email')
    readonly_fields = ('username',)

@admin.register(ManagerDB)
class ManagerAdmin(admin.ModelAdmin):
    list_display = ('username', 'full_name', 'email', 'phone_number')
    search_fields = ('username', 'full_name', 'email')
    readonly_fields = ('username',)

@admin.register(EmployeeDB)
class EmployeeAdmin(admin.ModelAdmin):
    list_display = ('username', 'full_name', 'email', 'phone_number')
    search_fields = ('username', 'full_name', 'email')
    readonly_fields = ('username',)

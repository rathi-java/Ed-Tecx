from django.contrib import admin
from .models import SubscriptionPlan, PlanType
# Register your models here.
admin.site.register(SubscriptionPlan)
admin.site.register(PlanType)
from django.db import models


class PlanType(models.Model):
    code = models.CharField(max_length=20, unique=True)  # e.g., 'basic', 'monthly'
    display_name = models.CharField(max_length=50)  # e.g., 'Basic', 'Monthly'
    
    def __str__(self):
        return self.display_name

class SubscriptionPlan(models.Model):
    plan_type = models.ForeignKey(PlanType, on_delete=models.CASCADE, related_name='subscriptions',null = True, blank = True)
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    duration_in_months = models.IntegerField(default=1)  # 1 for monthly, 12 for yearly, 0 for free
    features = models.JSONField(default=dict)  # Store features as a dictionary
    is_active = models.BooleanField(default=True)
    discount = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)  # In percentage

    def discounted_price(self):
        """Calculates the discounted price if a discount exists"""
        return round(self.price * (1 - (self.discount / 100)), 2)

    def __str__(self):
        return f"{self.plan_type.display_name} - ₹{self.discounted_price()}/m"

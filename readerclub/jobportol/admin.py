from django.contrib import admin
from django import forms
from .models import Job

class JobForm(forms.ModelForm):
    employment_types = forms.CharField(
        widget=forms.Textarea(attrs={'rows': 2}),
        required=False,
        help_text="Enter employment types as a comma-separated list (e.g., full-time, part-time, contract)"
    )

    class Meta:
        model = Job
        fields = '__all__'

    def clean_employment_types(self):
        """Convert comma-separated input to a list"""
        employment_types = self.cleaned_data.get('employment_types', '')
        if employment_types:
            return [etype.strip() for etype in employment_types.split(',')]
        return []  # Default empty list if nothing entered


class JobAdmin(admin.ModelAdmin):
    form = JobForm
    list_display = ('job_id', 'profile', 'company_name', 'min_experience', 'max_experience', 'posted_at')
    search_fields = ('profile', 'company_name', 'job_id')
    list_filter = ('location_state', 'min_experience', 'max_experience')
    ordering = ('-posted_at',)
    readonly_fields = ('job_id', 'posted_at', 'updated_at')  # Make job_id non-editable

    def save_model(self, request, obj, form, change):
        """Ensure job_id is always auto-generated and cannot be set manually"""
        if not obj.job_id:
            last_job = Job.objects.order_by('-id').first()
            if last_job and last_job.job_id.startswith("JOB"):
                last_number = int(last_job.job_id[3:])
                new_number = last_number + 1
            else:
                new_number = 1
            obj.job_id = f"JOB{new_number:04d}"  # Format: JOB0001, JOB0002, etc.

        super().save_model(request, obj, form, change)

admin.site.register(Job, JobAdmin)

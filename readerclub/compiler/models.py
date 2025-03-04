from django.db import models

# Create your models here.

class CodeSubmission(models.Model):
    language = models.CharField(max_length=20)  # To store the language (Java, Python, etc.)
    code = models.TextField()  # To store the user's code
    input_data = models.TextField(blank=True)  # To store any input data provided by the user
    output = models.TextField(blank=True, null=True)  # To store the output from the compiler or runtime

    created_at = models.DateTimeField(auto_now_add=True)  # Automatically store the submission time
    updated_at = models.DateTimeField(auto_now=True)  # Automatically update the submission time on changes

    def __str__(self):
        return f"Submission {self.id} - {self.language}"

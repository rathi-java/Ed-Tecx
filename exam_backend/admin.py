from django.contrib import admin
from exam_backend.models import Professor, Course, Difficulty, Exam, Question

admin.site.register(Professor)
admin.site.register(Course)
admin.site.register(Difficulty)
admin.site.register(Exam)
admin.site.register(Question)

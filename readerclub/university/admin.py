from django.contrib import admin
from .models import University, UniversityProfessor, UniversityCourse, UniversityExamDifficulty, UniversityExam, UniversityQuestion
admin.site.register(University)
admin.site.register(UniversityProfessor)
admin.site.register(UniversityCourse)
admin.site.register(UniversityExamDifficulty)
admin.site.register(UniversityExam)
admin.site.register(UniversityQuestion)


# Register your models here.

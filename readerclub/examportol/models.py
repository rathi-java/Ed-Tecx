from django.db import models
from django.contrib.auth import get_user_model
import uuid
from oauth.models import UsersDB

class Category(models.Model):
    category_code = models.CharField(max_length=10, unique=True, blank=True, null=True)
    category_name = models.CharField(max_length=255)

    def save(self, *args, **kwargs):
        if not self.category_code:
            last_category = Category.objects.order_by('-id').first()
            new_id = int(last_category.category_code[1:]) + 1 if last_category and last_category.category_code else 1
            self.category_code = f'C{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.category_name

class Subject(models.Model):
    subject_code = models.CharField(max_length=15, unique=True, blank=True, null=True)
    subject_name = models.CharField(max_length=255)
    subject_category = models.ForeignKey(
        Category, on_delete=models.CASCADE, related_name='subjects'
    )

    def save(self, *args, **kwargs):
        if not self.subject_code and self.subject_category:
            last_subject = Subject.objects.filter(subject_category=self.subject_category).order_by('-id').first()
            if last_subject and last_subject.subject_code:
                try:
                    new_id = int(last_subject.subject_code.split('-S')[1]) + 1
                except (IndexError, ValueError):
                    new_id = 1
            else:
                new_id = 1

            self.subject_code = f'{self.subject_category.category_code}-S{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.subject_name

class Question(models.Model):
    question_code = models.CharField(max_length=20, unique=True, blank=True, null=True)
    question_text = models.TextField()
    question_subject = models.ForeignKey(
        Subject, on_delete=models.CASCADE, related_name='questions'
    )
    answers = models.JSONField(blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.question_code and self.question_subject:
            last_question = Question.objects.filter(question_subject=self.question_subject).order_by('-id').first()
            if last_question and last_question.question_code:
                try:
                    new_id = int(last_question.question_code.split('-Q')[1]) + 1
                except (IndexError, ValueError):
                    new_id = 1
            else:
                new_id = 1

            self.question_code = f'{self.question_subject.subject_code}-Q{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.question_text

class ExamResult(models.Model):
    user = models.ForeignKey(UsersDB, on_delete=models.CASCADE)  # Use custom user model   
    session_id = models.UUIDField(default=uuid.uuid4, editable=False, blank=True, null=True)  # Unique ID for guests
    total_questions = models.IntegerField(default=0)
    correct_answers = models.IntegerField(default=0)
    score = models.FloatField(default=0.0)
    submitted_answers = models.JSONField(blank=True, null=True)  # Stores {"question_id": {"selected": "A", "correct": "B"}}
    submitted_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Exam Result - {self.user if self.user else 'Guest'} - Score: {self.score}%"
    class Meta:
        db_table = 'examportol_examresult'

from django.db import models

class Exam(models.Model):
    name = models.CharField(max_length=255)
    questions = models.ManyToManyField(Question, related_name='exams')
    duration = models.PositiveIntegerField(help_text="Duration in minutes")
    exam_code = models.CharField(max_length=10, unique=True, blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0)  # New field

    def save(self, *args, **kwargs):
        if not self.exam_code:
            last_exam = Exam.objects.order_by('-id').first()
            new_id = int(last_exam.exam_code[1:]) + 1 if last_exam and last_exam.exam_code else 1
            self.exam_code = f'E{new_id:04d}'
        super().save(*args, **kwargs)

    class Meta:
        db_table = 'examportol_exam'


from django.db import models

class Professor(models.Model):
    professor_code = models.CharField(max_length=10, unique=True, blank=True)
    name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)

    def save(self, *args, **kwargs):
        if not self.professor_code:  # Assign professor_code if not already set
            self.professor_code = 'P{:04d}'.format(Professor.objects.count() + 1)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class Course(models.Model):
    name = models.CharField(max_length=255, unique=True)
    course_code = models.CharField(max_length=10, unique=True, blank=True)

    def save(self, *args, **kwargs):
        self.name = self.name.strip().upper()
        if not self.course_code:
            last_course = Course.objects.order_by('course_code').last()
            if last_course:
                last_code_number = int(last_course.course_code[1:])
                new_code_number = last_code_number + 1
            else:
                new_code_number = 1
            self.course_code = f'C{new_code_number:03}'
        super(Course, self).save(*args, **kwargs)

    def __str__(self):
        return self.name

class Difficulty(models.Model):
    difficulty_name = models.CharField(max_length=100, unique=True)
    difficulty_code = models.CharField(max_length=10, unique=True, blank=True)

    def save(self, *args, **kwargs):
        # Normalize the difficulty name to uppercase before saving
        self.difficulty_name = self.difficulty_name.strip().upper()

        # Assign a unique difficulty_code if not already set
        if not self.difficulty_code:
            last_difficulty = Difficulty.objects.order_by('difficulty_code').last()
            if last_difficulty:
                # Extract the number from the code (ignoring 'D' part)
                last_code_number = int(last_difficulty.difficulty_code[1:])
                new_code_number = last_code_number + 1
            else:
                new_code_number = 1

            # Format the new difficulty code, ensuring two digits for the number
            self.difficulty_code = f'D{new_code_number:02}'

        # Call the parent class's save method to store the object in the database
        super(Difficulty, self).save(*args, **kwargs)

    def __str__(self):
        return self.difficulty_name

class Exam(models.Model):
    professor = models.ForeignKey(Professor, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    difficulty = models.ForeignKey(Difficulty, on_delete=models.CASCADE)
    exam_code = models.CharField(max_length=5, unique=True)
    duration = models.IntegerField()  # Duration in minutes
    num_questions = models.IntegerField()

    def save(self, *args, **kwargs):
        if not self.exam_code:
            last_exam = Exam.objects.all().order_by('exam_code').last()
            new_code = f"E{int(last_exam.exam_code[1:]) + 1:03d}" if last_exam else "E001"
            self.exam_code = new_code
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Exam {self.exam_code}"

class Question(models.Model):
    exam = models.ForeignKey(Exam, on_delete=models.CASCADE, related_name='questions')
    question_code = models.CharField(max_length=50)
    question_text = models.TextField()
    options = models.JSONField()
    correct_option = models.CharField(max_length=1)

    def __str__(self):
        return f"{self.question_code} - {self.question_text}"


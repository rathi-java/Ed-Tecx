from django.db import models
class University(models.Model):
    university_code = models.CharField(max_length=10, unique=True, blank=True)
    university_name = models.CharField(max_length=255)  
    university_location = models.CharField(max_length=255)
    def save(self, *args, **kwargs):
        if not self.university_code:  # Assign university_code if not already set
            last_university = University.objects.order_by('id').last()
            new_id = last_university.id + 1 if last_university else 1
            self.university_code = f'U{new_id:04d}'
        super().save(*args, **kwargs)
    def __str__(self):
        return self.university_name
    class Meta:
        db_table = "university_university"    


class UniversityProfessor(models.Model):
    university = models.ForeignKey(University, on_delete=models.CASCADE)
    professor_code = models.CharField(max_length=55, unique=True, blank=True)
    name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)

    def save(self, *args, **kwargs):
        if not self.professor_code:  # Assign professor_code if not already set
            last_professor = UniversityProfessor.objects.filter(university=self.university).order_by('id').last()
            new_id = last_professor.id + 1 if last_professor else 1
            self.professor_code = f'{self.university.university_code}-P{new_id:04d}'
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name
    class Meta:
        db_table = "university_professor"

class UniversityCourse(models.Model):
    university = models.ForeignKey(University, on_delete=models.CASCADE)
    name = models.CharField(max_length=255, unique=True)
    course_code = models.CharField(max_length=55, unique=True, blank=True)

    def save(self, *args, **kwargs):
        self.name = self.name.strip().upper()  # Normalize to uppercase
        if not self.course_code:
            last_course = UniversityCourse.objects.order_by('course_code').last()
            if last_course:
                last_code_number = int(last_course.course_code[1:])
                new_code_number = last_code_number + 1
            else:
                new_code_number = 1
            self.course_code = f'C{new_code_number:03}'
        super(UniversityCourse, self).save(*args, **kwargs)

    def __str__(self):
        return self.name
    class Meta:
        db_table = "university_course"    

class UniversityExamDifficulty(models.Model):
    university = models.ForeignKey(University, on_delete=models.CASCADE)
    difficulty_name = models.CharField(max_length=100, unique=True)
    difficulty_code = models.CharField(max_length=55, unique=True, blank=True)

    def save(self, *args, **kwargs):
        # Normalize the difficulty name to uppercase before saving
        self.difficulty_name = self.difficulty_name.strip().upper()

        # Assign a unique difficulty_code if not already set
        if not self.difficulty_code:
            last_difficulty = UniversityExamDifficulty.objects.order_by('difficulty_code').last()
            if last_difficulty:
                # Extract the number from the code (ignoring 'D' part)
                last_code_number = int(last_difficulty.difficulty_code[1:])
                new_code_number = last_code_number + 1
            else:
                new_code_number = 1

            # Format the new difficulty code, ensuring two digits for the number
            self.difficulty_code = f'D{new_code_number:02}'

        # Call the parent class's save method to store the object in the database
        super(UniversityExamDifficulty, self).save(*args, **kwargs)

    def __str__(self):
        return self.difficulty_name
    class Meta:
        db_table = "university_difficulty"
class UniversityExam(models.Model):
    professor = models.ForeignKey(UniversityProfessor, on_delete=models.CASCADE)
    course = models.ForeignKey(UniversityCourse, on_delete=models.CASCADE)
    difficulty = models.ForeignKey(UniversityExamDifficulty, on_delete=models.CASCADE)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    exam_code = models.CharField(max_length=55, unique=True,blank=True)
    duration = models.IntegerField()  # Duration in minutes
    num_questions = models.IntegerField()
    EXAM_TYPE_CHOICES = [
        ('university', 'University'),
        ('examportol', 'ExamPortol'),
    ]
    exam_type = models.CharField(
        max_length=20,
        choices=EXAM_TYPE_CHOICES,
        default='university'
    )
    def save(self, *args, **kwargs):
    # Generate the exam_code if it doesn't exist
        if not self.exam_code:
            last_exam = UniversityExam.objects.order_by('id').last()
            if last_exam:
                # Try to extract a numeric part from the last exam code
                try:
                    # Find digits in the exam_code
                    digits = ''.join(filter(str.isdigit, last_exam.exam_code))
                    last_code_number = int(digits) if digits else 0
                except (ValueError, AttributeError):
                    last_code_number = 0
                new_code_number = last_code_number + 1
            else:
                new_code_number = 1
                
            # Format the new exam code
            self.exam_code = f'E{new_code_number:03d}'
            
        # Call the parent class's save method
        super().save(*args, **kwargs)    
        def __str__(self):
            return f"Exam {self.exam_code}"
    def can_edit_questions(self, professor):
        """Check if the given professor can edit and add questions to this exam."""
        return self.professor == professor
    class Meta:
        db_table = "university_exam"

class UniversityQuestion(models.Model):
    exam = models.ForeignKey(UniversityExam, on_delete=models.CASCADE, related_name='questions')
    question_code = models.CharField(max_length=50)
    question_text = models.TextField()
    answers = models.JSONField(blank=True, null=True)  # {"options": {"A": "Option A text", "B": "Option B text", ...}, "is_correct": "A"}

    def __str__(self):
        return f"{self.question_code} - {self.question_text}"

    class Meta:
        db_table = "university_question"    

class UniversityExamResult(models.Model):
    exam = models.ForeignKey(UniversityExam, on_delete=models.CASCADE, related_name="exam_results")
    student_name = models.CharField(max_length=255)  # Storing student details
    total_questions = models.IntegerField(default=0)
    correct_answers = models.IntegerField(default=0)
    score = models.FloatField(default=0.0)
    submitted_answers = models.JSONField(blank=True, null=True)  # {"question_id": {"selected": "A", "correct": "B"}}
    submitted_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.student_name} - {self.exam.exam_code} - Score: {self.score}%"

    class Meta:
        db_table = "university_examresult"

class ExamLink(models.Model):
    """
    Model to store unique links for exams that professors can share with students.
    Each link has a unique code that students can use to access the exam.
    """
    exam = models.ForeignKey('UniversityExam', on_delete=models.CASCADE, related_name='links')  # Ensure this references UniversityExam
    unique_code = models.CharField(max_length=50, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        db_table = 'exam_link'  # Ensure this matches the database table name
        verbose_name = "Exam Link"
        verbose_name_plural = "Exam Links"
        ordering = ['-created_at']

    def __str__(self):
        return f"Link for {self.exam.exam_code} ({self.unique_code})"
    
    def is_valid(self):
        """Check if this link is still valid (active and exam hasn't ended)"""
        current_time = timezone.now()
        return self.is_active and current_time <= self.exam.end_time
    
    def time_until_start(self):
        """Get time remaining until exam starts, in minutes"""
        current_time = timezone.now()
        if current_time >= self.exam.start_time:
            return 0
        
        time_delta = self.exam.start_time - current_time
        return int(time_delta.total_seconds() / 60)

    def get_exam(self):
        """Fetch the associated exam if the link is valid."""
        if self.is_valid():
            return self.exam
        return None
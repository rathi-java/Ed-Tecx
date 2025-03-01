import csv
from django.contrib import admin, messages
from django.shortcuts import render, redirect
from django.urls import path
from django.utils.html import format_html
from django.http import HttpResponseRedirect
from .models import Question, Subject, Category
from .forms import QuestionUploadForm

class QuestionAdmin(admin.ModelAdmin):
    list_display = ('question_text', 'question_subject')  # Removed 'created_at'
    search_fields = ('question_text',)

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('upload-questions/', self.admin_site.admin_view(self.upload_questions), name='upload_questions'),
        ]
        return custom_urls + urls

    def upload_questions(self, request):
        if request.method == 'POST':
            form = QuestionUploadForm(request.POST, request.FILES)
            if form.is_valid():
                category_id = form.cleaned_data['category'].id
                subject_id = form.cleaned_data['subject'].id
                file = request.FILES['file']

                # Ensure file is CSV
                if not file.name.endswith('.csv'):
                    self.message_user(request, "Invalid file format! Please upload a CSV file.", level=messages.ERROR)
                    return redirect('admin:upload_questions')

                try:
                    decoded_file = file.read().decode('utf-8').splitlines()
                    reader = csv.DictReader(decoded_file)

                    required_fields = ['Question', 'Correct Answer', 'Option A', 'Option B', 'Option C', 'Option D']
                    missing_rows = []
                    subject = Subject.objects.get(id=subject_id)
                    category = Category.objects.get(id=category_id)

                    for index, row in enumerate(reader, start=1):
                        if not all(row.get(field, '').strip() for field in required_fields):
                            missing_rows.append(index)
                            continue

                        question_text = row['Question'].strip()
                        correct_answer = row['Correct Answer'].strip().upper()

                        if correct_answer not in ['A', 'B', 'C', 'D']:
                            self.message_user(request, f"Row {index}: Invalid correct answer '{correct_answer}', skipping.", level=messages.WARNING)
                            continue

                        answers = {
                            f'option_{letter}': {
                                'text': row[f'Option {letter}'].strip(),
                                'is_correct': (letter == correct_answer)
                            } for letter in ['A', 'B', 'C', 'D']
                        }

                        if Question.objects.filter(question_text=question_text, question_subject=subject).exists():
                            self.message_user(request, f"Row {index}: Duplicate question skipped.", level=messages.WARNING)
                            continue

                        Question.objects.create(
                            question_text=question_text,
                            question_subject=subject,
                            answers=answers
                        )

                    if missing_rows:
                        self.message_user(request, f"Skipped rows {missing_rows} due to missing fields.", level=messages.WARNING)

                    self.message_user(request, "Questions uploaded successfully!", level=messages.SUCCESS)
                    return HttpResponseRedirect(request.path)

                except Exception as e:
                    self.message_user(request, f"Error processing file: {e}", level=messages.ERROR)

        else:
            form = QuestionUploadForm()

        return render(request, 'admin/upload_questions.html', {'form': form})

    def upload_questions_button(self, obj):
        return format_html('<a class="button" href="upload-questions/">Upload Questions</a>')

    upload_questions_button.short_description = "Upload Questions"
    upload_questions_button.allow_tags = True

admin.site.register(Question, QuestionAdmin)

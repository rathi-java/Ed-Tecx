# Generated by Django 5.1.4 on 2025-01-09 07:53

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam_backend', '0004_difficulty'),
    ]

    operations = [
        migrations.CreateModel(
            name='Exam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('exam_code', models.CharField(max_length=5, unique=True)),
                ('duration', models.IntegerField()),
                ('num_questions', models.IntegerField()),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='exam_backend.course')),
                ('difficulty', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='exam_backend.difficulty')),
                ('professor', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='exam_backend.professor')),
            ],
        ),
    ]

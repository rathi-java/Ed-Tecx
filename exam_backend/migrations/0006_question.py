# Generated by Django 5.1.4 on 2025-01-09 09:37

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam_backend', '0005_exam'),
    ]

    operations = [
        migrations.CreateModel(
            name='Question',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('question_code', models.CharField(max_length=50)),
                ('question_text', models.TextField()),
                ('options', models.JSONField()),
                ('correct_option', models.CharField(max_length=1)),
                ('exam', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='questions', to='exam_backend.exam')),
            ],
        ),
    ]

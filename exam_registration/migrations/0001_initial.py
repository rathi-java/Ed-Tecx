from django.db import migrations, models

class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name='Registration',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=100)),
                ('email', models.EmailField(max_length=254)),
                ('domain', models.CharField(max_length=50)),
                ('topic', models.CharField(max_length=50)),
                ('date', models.DateField()),
                ('payment', models.CharField(max_length=20)),
            ],
        ),
    ]

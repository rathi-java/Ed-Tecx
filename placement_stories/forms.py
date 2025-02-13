from django import forms
from .models import PlacementStories
class PlacementStoriesForm(forms.ModelForm):
    class Meta:
        model = PlacementStories
        fields = '__all__'
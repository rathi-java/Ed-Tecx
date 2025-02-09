from django.shortcuts import render, redirect, get_object_or_404
from django.core.paginator import Paginator
from .models import PlacementStories
from .forms import PlacementStoriesForm

# View to display all placement stories with pagination
def placement_stories(request):
    # Fetch all placement stories ordered by id in descending order
    qs = PlacementStories.objects.all().order_by('-id')
    
    # Set up pagination, e.g., showing 2 stories per page
    paginator = Paginator(qs, 3)  # e.g. 2 stories per page
    page_number = request.GET.get('page')  # Get the page number from GET parameters
    page_obj = paginator.get_page(page_number)  # Get the current page of stories

    # If the user is a superuser, show the form to add a new story
    form = None
    if request.user.is_superuser:
        if request.method == 'POST':
            form = PlacementStoriesForm(request.POST, request.FILES)
            # If the form is valid, save the new story and redirect to the story list page
            if form.is_valid():
                form.save()
                return redirect('placement_stories')  # Redirect to avoid re-submission
        else:
            form = PlacementStoriesForm()  # Show an empty form if GET request

    # Render the placement_stories page with pagination and the form if applicable
    return render(request, 'placement_stories.html', {
        'page_obj': page_obj,  # Paginated stories for the current page
        'form': form,          # The form to add a new story (if superuser)
    })

# View to display details of a specific placement story
def story_detail(request, story_id):
    story = get_object_or_404(PlacementStories, id=story_id)
    # Grab the referring URL if present
    prev_url = request.META.get('HTTP_REFERER', '')
    # If it's empty, you can optionally default to your listing page
    if not prev_url:
        prev_url = '/'
    
    return render(request, 'storydetail.html', {
        'story': story,
        'prev_url': prev_url
    })

# View to edit a specific placement story
def edit_story(request, story_id):
    # Fetch the story or return 404 if not found
    story = get_object_or_404(PlacementStories, id=story_id)
    
    if request.method == 'POST':
        # If the form is submitted, bind the data to the form and validate
        form = PlacementStoriesForm(request.POST, request.FILES, instance=story)
        if form.is_valid():
            # If form is valid, save the updated story and redirect to the list page
            form.save()
            return redirect('placement_stories')
    else:
        # If it's a GET request, pre-fill the form with the story data
        form = PlacementStoriesForm(instance=story)
    
    # Render the edit story page with the form and the story details
    return render(request, 'edit_story.html', {'form': form, 'story': story})

# View to delete a specific placement story
def delete_story(request, story_id):
    # Fetch the story or return 404 if not found
    story = get_object_or_404(PlacementStories, id=story_id)
    
    if request.method == 'POST':
        # If the form is submitted, delete the story and redirect to the story list page
        story.delete()
        return redirect('placement_stories')
    
    # Render the delete story page with a confirmation message
    return render(request, 'delete_story.html', {'story': story})
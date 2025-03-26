from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
from django.contrib import messages
from .models import Blog, Tag, Section
from django.utils.text import slugify

def blog_list(request, blog_type=None):
    """
    View to display a list of all active blogs, ordered by published date.
    """
    blogs = Blog.objects.filter(active=True, blog_type=blog_type).order_by("-published_date")
    template_name = f'{blog_type}_blog_list.html' if blog_type else 'blog_list.html'
    return render(request, template_name, {"blogs": blogs})

def blog_detail(request, slug, blog_type=None):
    """
    View to display the details of a specific blog post with recent issues.
    """
    blog = get_object_or_404(Blog, slug=slug, blog_type=blog_type)
    recent_blogs = Blog.objects.filter(
        active=True, 
        blog_type=blog_type
    ).exclude(
        id=blog.id
    ).order_by(
        "-published_date"
    )[:4]  # Get 4 most recent blogs of the same type
    
    return render(request, f'{blog_type}_blog_detail.html', {
        'blog': blog,
        'recent_blogs': recent_blogs
    })

def form(request):
    """
    View to handle the creation of a new blog post.
    """
    if request.method == "POST":
        data = request.POST
        title = data.get('title')
        slug = data.get('slug')
        image = request.FILES.get('image')
        content = data.get('content')
        short_description = data.get('short_description')
        category = data.get('category')
        published_date = data.get('published_date')
        author = data.get('author')
        author_description = data.get('author_description')
        author_image = request.FILES.get('author_image')
        tags_input = data.get('tags', '').strip()
        blog_type = data.get('blog_type', 'readerclub')  # Ensure this matches the form value

        # Generate slug from title if not provided
        if not slug:
            slug = slugify(title)

        # Create the blog post
        blog = Blog.objects.create(
            title=title,
            slug=slug,
            image=image,
            content=content,
            short_description=short_description,
            category=category,
            published_date=published_date,
            author=author,
            author_description=author_description,
            author_image=author_image,
            blog_type=blog_type
        )

        # Add tags to the blog post
        if tags_input:
            tags = [tag.strip() for tag in tags_input.split(',')]
            for tag_name in tags:
                tag, created = Tag.objects.get_or_create(name=tag_name)
                blog.tags.add(tag)

        # Handle sections for the blog post
        sections_data = data.getlist('section_title')
        sections_content = data.getlist('section_content')
        for title, content in zip(sections_data, sections_content):
            if title and content:
                Section.objects.create(
                    blog=blog,
                    title=title,
                    content=content,
                    slug=slugify(title)
                )

        messages.success(request, 'Blog created successfully!')
        return redirect(reverse(f'{blog_type}_blog_list'))  # Ensure this matches the URL name

    # Render the form template for GET requests
    blogs = Blog.objects.all()
    return render(request, 'form.html', {'blogs': blogs})

def toggle_blog_status(request, blog_id):
    """
    View to toggle the active status of a blog post.
    """
    blog = get_object_or_404(Blog, id=blog_id)
    blog.active = not blog.active
    blog.save()
    messages.success(request, f'Blog status updated to {"Active" if blog.active else "Inactive"}')
    return redirect('form')

def edit_blog(request, blog_id):
    """
    View to handle editing an existing blog post.
    """
    try:
        blog = Blog.objects.get(id=blog_id)
    except Blog.DoesNotExist:
        messages.error(request, 'Blog not found!')
        return redirect('form')

    if request.method == "POST":
        data = request.POST
        blog.title = data.get('title')
        blog.slug = data.get('slug')
        blog.image = request.FILES.get('image') or blog.image
        blog.content = data.get('content')
        blog.short_description = data.get('short_description')
        blog.category = data.get('category')
        blog.published_date = data.get('published_date')
        blog.author = data.get('author')
        blog.author_description = data.get('author_description')
        blog.author_image = request.FILES.get('author_image') or blog.author_image
        blog.blog_type = data.get('blog_type', 'readerclub')  # Ensure this matches the form value

        # Update tags for the blog post
        tags_input = data.get('tags', '').strip()
        if tags_input:
            tags = [tag.strip() for tag in tags_input.split(',')]
            blog.tags.clear()
            for tag_name in tags:
                tag, created = Tag.objects.get_or_create(name=tag_name)
                blog.tags.add(tag)

        # Update sections for the blog post
        blog.sections.all().delete()
        sections_data = data.getlist('section_title')
        sections_content = data.getlist('section_content')
        for title, content in zip(sections_data, sections_content):
            if title and content:
                Section.objects.create(
                    blog=blog,
                    title=title,
                    content=content,
                    slug=slugify(title)
                )

        blog.save()
        messages.success(request, 'Blog updated successfully!')
        return redirect(reverse(f'{blog.blog_type}_blog_list'))  # Ensure this matches the URL name

    # Render the edit template for GET requests
    return render(request, 'edit_blog.html', {'blog': blog})

def delete_blog(request, blog_id):
    """
    View to delete a blog post.
    """
    try:
        blog = Blog.objects.get(id=blog_id)
        blog_type = blog.blog_type
        blog.delete()
        messages.success(request, 'Blog deleted successfully!')
    except Blog.DoesNotExist:
        messages.error(request, 'Blog not found!')
    return redirect(reverse(f'{blog_type}_blog_list'))
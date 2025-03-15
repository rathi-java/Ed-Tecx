from django.shortcuts import render
from django.http import JsonResponse
from .documents import InternshipDocument
import datetime
import calendar

def autocomplete_internship(request):
    term = request.GET.get('term', '')
    suggestions = []
    
    if term and len(term) > 2:
        search = InternshipDocument.search().suggest(
            'internship-suggest', term,
            completion={
                'field': 'role_suggest',
                'fuzzy': {'fuzziness': 'AUTO'}
            }
        )
        search_response = search.execute()
        
        try:
            suggest_results = search_response.suggest["internship-suggest"]
        except KeyError:
            suggest_results = []
        
        for entry in suggest_results:
            for option in entry.options:
                suggestions.append(option.text)
    
    return JsonResponse(suggestions, safe=False)
from django.shortcuts import render
from django.http import JsonResponse
from .documents import InternshipDocument

def elastic_internship_search(request):
    """
    Search internships using Elasticsearch with filters and pagination.
    """
    # Get filter parameters
    location = request.GET.get('location', '')
    duration = request.GET.get('duration', '')
    stipend = request.GET.get('stipend', '')
    skills = request.GET.get('skills', '')
    query = request.GET.get('q', '')

    # Pagination parameters
    try:
        page = int(request.GET.get('page', 1))
    except ValueError:
        page = 1
    try:
        limit = int(request.GET.get('limit', 20))
    except ValueError:
        limit = 40
    start = (page - 1) * limit

    # Initialize Elasticsearch search
    search = InternshipDocument.search()

    # Free-text search across multiple fields
    if query:
        search = search.query("bool", should=[
            {"match": {"role": {"query": query, "fuzziness": "AUTO"}}},
            {"match": {"responsibilities": {"query": query}}},
            {"match": {"required_skills": {"query": query}}}
        ], minimum_should_match=1)

    # Location filter (company address)
    if location:
        search = search.filter("match", location=location)

    # Duration filter (exact match)
    if duration:
        search = search.filter("match", duration=duration)

    # Stipend range filter
    if stipend:
        try:
            if '-' in stipend:
                min_stipend, max_stipend = map(float, stipend.split('-'))
                search = search.filter("range", stipend={"gte": min_stipend, "lte": max_stipend})
            else:
                search = search.filter("range", stipend={"gte": float(stipend)})
        except ValueError:
            pass

    # Skills filter
    if skills:
        search = search.filter("match", required_skills=skills)

    # Apply pagination slicing
    search = search[start: start + limit]

    # Execute search
    response = search.execute()
    
    # Prepare results for response
    internships = []
    for hit in response:
        internship = {
            'id': hit.meta.id,
            'role': hit.role,
            'company': {
                'name': hit.company_name,
                'address': hit.location,
                'logo': hit.company_logo,  # Actual logo URL
                'about': hit.company_about,
                'established_year': hit.company_established_year,
            },
            'duration': hit.duration,
            'stipend': hit.stipend,
            'openings': hit.openings,
            'required_skills': hit.required_skills.split(',') if isinstance(hit.required_skills, str) else hit.required_skills,
            'responsibilities': hit.responsibilities.split('\n') if isinstance(hit.responsibilities, str) else hit.responsibilities,
            'created_at': hit.created_at,
        }
        internships.append(internship)

    # If it's an AJAX request (triggered by scrolling), return JSON data
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        return JsonResponse({'internships': internships})
    
    # For the initial load render the page with internships
    return render(request, 'internship_page.html', {'internships': internships})

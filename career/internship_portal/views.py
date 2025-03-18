from django.shortcuts import render
from django.http import JsonResponse
from .documents import InternshipDocument
import datetime
import calendar


def internship_landing_page(request):
    """
    Render the internship portal page.
    """
    return render(request, 'internship_landing_page.html')

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
def elastic_internship_search(request):
    # Initialize the search object from InternshipDocument
    search = InternshipDocument.search()

    # Optionally, add filters, queries, pagination, etc.
    # For example:
    location = request.GET.get('location', '')
    if location:
        search = search.filter("match", location=location)

    # Execute the search
    response = search.execute()
    
    internships = []
    for hit in response:
        internship = {
            'id': hit.meta.id,
            'role': hit.role,
            'company': {
                'name': hit.company_name,
                'address': hit.location,
                'logo': hit.company_logo,
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

    # Return response based on the request type
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        return JsonResponse({'internships': internships})
    else:
        return render(request, 'internship_page.html', {'internships': internships})

def internship_landing_page(request):
    """
    Render the internship portal page.
    """
    return render(request, 'internship_landing_page.html')
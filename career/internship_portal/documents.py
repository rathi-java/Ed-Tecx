from django_elasticsearch_dsl import Document, Index, fields
from django_elasticsearch_dsl.registries import registry
from .models import Internship, Company

# Define the index settings for Elasticsearch
internship_index = Index('internships')
internship_index.settings(
    number_of_shards=1,
    number_of_replicas=0
)
@registry.register_document
class InternshipDocument(Document):
    company_name = fields.TextField(attr='company.name')
    location = fields.TextField(attr='company.address')
    company_logo = fields.TextField(attr='company.logo.url')         # Expose logo URL
    company_about = fields.TextField(attr='company.about')           # Expose about text
    company_established_year = fields.IntegerField(attr='company.established_year')  # Expose established year
    openings = fields.IntegerField()                                 # Expose number of openings

    class Index:
        name = 'internships'
        settings = {
            'number_of_shards': 1,
            'number_of_replicas': 0,
        }

    class Django:
        model = Internship
        fields = [
            'role',
            'responsibilities',
            'required_skills',
            'stipend',
            'duration',
            'created_at',
        ]
        # Related models are used to trigger reindexing when InternshipCompany updates.
        related_models = [Company]

    def get_instances_from_related(self, related_instance):
        if isinstance(related_instance, Company):
            return related_instance.internship_set.all()
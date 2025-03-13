# from django_elasticsearch_dsl import Document, Index, fields
# from django_elasticsearch_dsl.registries import registry
# from .models import Job

# # Define the index
# job_index = Index('jobs')
# job_index.settings(number_of_shards=1, number_of_replicas=0)

# @registry.register_document
# class JobDocument(Document):
#     # Nested fields for related models
#     company = fields.ObjectField(properties={
#         'name': fields.TextField(),
#         'address': fields.TextField(),
#     })
#     category = fields.ObjectField(properties={
#         'name': fields.TextField(),
#     })
#     # Completion field for autocomplete on the job role.
#     role_suggest = fields.CompletionField()

#     class Index:
#         name = 'jobs'
#         settings = {'number_of_shards': 1, 'number_of_replicas': 0}

#     class Django:
#         model = Job  # The model associated with this Document
#         # Fields of the model to be indexed in Elasticsearch
#         fields = [
#             'job_code',
#             'role',
#             'responsibilities',
#             'position',
#             'eligibility',
#             'job_type',
#             'salary_per_annum',
#             'required_experience',
#             'job_description',
#             'required_skills',
#             'vacancy',
#             'created_at',
#             'updated_at',
#         ]
#     def prepare_role_suggest(self, instance):
#         return {
#             "input": instance.role.split(),
#             "weight": len(instance.role)
#         }
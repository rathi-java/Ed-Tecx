from django.urls import path
from . import views  # Import views from the same app

urlpatterns = [
    # Base index page remains at the root URL
    path('', views.practice_questions, name="practice_questions"),

    # IT Practice Questions
    path('it/python_practice/', views.python_practice, name='python_practice'),
    path('it/java_practice/', views.java_practice, name='java_practice'),
    path('it/cpp_practice/', views.cpp_practice, name='cpp_practice'),
    path('it/html_practice/', views.html_practice, name='html_practice'),
    path('it/css_practice/', views.css_practice, name='css_practice'),
    path('it/javascript_practice/', views.javascript_practice, name='javascript_practice'),
    path('it/dsa_practice/', views.dsa_practice, name='dsa_practice'),
    path('it/dbms_practice/', views.dbms_practice, name='dbms_practice'),
    path('it/sdlc_practice/', views.sdlc_practice, name='sdlc_practice'),
    path('it/csharp_practice/', views.csharp_practice, name='csharp_practice'),

    # Management Practice Questions
    path('management/finance/', views.finance_practice, name="finance_practice"),
    path('management/marketing/', views.marketing_practice, name="marketing_practice"),
    path('management/operations_management/', views.operations_management_practice, name="operations_management_practice"),
    path('management/organizational_behaviour/', views.organizational_behaviour_practice, name="organizational_behaviour_practice"),
    path('management/hospital_administration/', views.hospital_administration_practice, name="hospital_administration_practice"),
    path('management/digital_marketing/', views.digital_marketing_practice, name="digital_marketing_practice"),
    path('management/decision_making/', views.decision_making_practice, name="decision_making_practice"),
    path('management/entrepreneurship/', views.entrepreneurship_practice, name="entrepreneurship_practice"),
    path('management/corporate_law/', views.corporate_law_practice, name="corporate_law_practice"),
    path('management/strategic_management/', views.strategic_management_practice, name="strategic_management_practice"),

    # Aptitude Practice Questions
    path('aptitude/abstract_reasoning/', views.abstract_reasoning_practice, name="abstract_reasoning_practice"),
    path('aptitude/data_interpretation/', views.data_interpretation_practice, name="data_interpretation_practice"),
    path('aptitude/data_sufficiency/', views.data_sufficiency_practice, name="data_sufficiency_practice"),
    path('aptitude/general_knowledge/', views.general_knowledge_and_current_affairs_practice, name="general_knowledge_and_current_affairs_practice"),
    path('aptitude/quantitative/', views.quantitative_practice, name="quantitative_practice"),
    path('aptitude/reasoning/', views.reasoning_practice, name="reasoning_practice"),
    path('aptitude/verbal_ability/', views.verbal_ability_practice, name="verbal_ability_practice"),

    # Coding Practice
    path('coding/', views.coding_practice, name="coding_practice"),
]

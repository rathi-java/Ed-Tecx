import csv
import os
from decimal import Decimal, InvalidOperation

from django.core.management.base import BaseCommand
from django.core.files import File
from django.conf import settings

from internship_portal.models import InternshipCompany, Internship, InternshipCategory

class Command(BaseCommand):
    help = 'Import CSV data into InternshipCompany or Internship models'

    def add_arguments(self, parser):
        parser.add_argument(
            'csv_file',
            type=str,
            help='Path to the CSV file to import'
        )
        parser.add_argument(
            'model',
            type=str,
            choices=['company', 'internship'],
            help='Specify which model to import data into: "company" or "internship"'
        )

    def handle(self, *args, **options):
        csv_file_path = options['csv_file']
        model_type = options['model']

        if not os.path.exists(csv_file_path):
            self.stdout.write(self.style.ERROR(f"File {csv_file_path} does not exist."))
            return

        with open(csv_file_path, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            count = 0

            if model_type == 'company':
                # Expected CSV columns: name, address, email, contact_number, logo, about, established_year
                for row in reader:
                    company = InternshipCompany(
                        name=row.get('name'),
                        address=row.get('address'),
                        email=row.get('email'),
                        contact_number=row.get('contact_number'),
                        about=row.get('about'),
                        established_year=int(row.get('established_year', 0)),
                    )
                    logo_path = row.get('logo')
                    # If a logo file path is provided and exists, attach it to the ImageField.
                    if logo_path and os.path.exists(logo_path):
                        with open(logo_path, 'rb') as logo_file:
                            company.logo.save(os.path.basename(logo_path), File(logo_file), save=False)
                    company.save()
                    count += 1
                self.stdout.write(self.style.SUCCESS(f"Imported {count} companies successfully."))

            elif model_type == 'internship':
                # Expected CSV columns: category, company_email, role, responsibilities, duration, stipend, required_skills, openings
                for row in reader:
                    # Get or create category
                    category_name = row.get('category')
                    if not category_name:
                        self.stdout.write(self.style.WARNING("Missing category; skipping row."))
                        continue
                    category, created = InternshipCategory.objects.get_or_create(name=category_name)
                    
                    # Find the company using email (or adjust this as needed)
                    company_email = row.get('company_email')
                    try:
                        company = InternshipCompany.objects.get(email=company_email)
                    except InternshipCompany.DoesNotExist:
                        self.stdout.write(self.style.WARNING(
                            f"Company with email {company_email} not found, skipping internship: {row.get('role')}"
                        ))
                        continue

                    # Parse stipend (if provided)
                    stipend_raw = row.get('stipend')
                    stipend = None
                    if stipend_raw:
                        try:
                            stipend = Decimal(stipend_raw)
                        except InvalidOperation:
                            self.stdout.write(self.style.WARNING(
                                f"Invalid stipend '{stipend_raw}' for internship {row.get('role')}, setting as None."
                            ))
                    
                    # Parse openings
                    openings_raw = row.get('openings')
                    try:
                        openings = int(openings_raw) if openings_raw else 1
                    except ValueError:
                        openings = 1

                    internship = Internship(
                        category=category,
                        company=company,
                        role=row.get('role'),
                        responsibilities=row.get('responsibilities'),
                        duration=row.get('duration'),
                        stipend=stipend,
                        required_skills=row.get('required_skills'),
                        openings=openings,
                    )
                    internship.save()
                    count += 1
                self.stdout.write(self.style.SUCCESS(f"Imported {count} internships successfully."))

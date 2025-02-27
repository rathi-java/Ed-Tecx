from allauth.socialaccount.adapter import DefaultSocialAccountAdapter
from django.utils import timezone
from oauth.models import UsersDB
from django.db import IntegrityError, transaction
import logging
import random
import string
from datetime import date

logger = logging.getLogger(__name__)

class CustomSocialAccountAdapter(DefaultSocialAccountAdapter):
    def generate_unique_phone(self):
        """Generate a unique temporary phone number"""
        while True:
            phone = ''.join(random.choices(string.digits, k=10))
            if not UsersDB.objects.filter(phone_number=phone).exists():
                return phone

    def pre_social_login(self, request, sociallogin):
        """
        This method is called before the social login is processed.
        If a user with the same email exists, connect the social account
        to that user so that they can log in.
        """
        # If sociallogin is already linked to a user, do nothing.
        if sociallogin.is_existing:
            return

        email = sociallogin.account.extra_data.get('email')
        if not email:
            logger.error("No email provided in social account data.")
            return

        try:
            # If a user with the given email exists, connect the social account.
            user = UsersDB.objects.get(email=email)
            logger.info(f"Found existing user for email {email}. Connecting social account.")
            sociallogin.connect(request, user)
        except UsersDB.DoesNotExist:
            logger.info(f"No user found with email {email}. Proceeding to signup.")

    @transaction.atomic
    def save_user(self, request, sociallogin, form=None):
        """
        This method is called to save a new user.
        If the user already exists (and the social account is connected via pre_social_login),
        this code will update the user's details.
        """
        try:
            provider = sociallogin.account.provider
            uid = sociallogin.account.uid
            extra_data = sociallogin.account.extra_data
            
            # Get email and name based on provider
            if provider == 'github':
                email = extra_data.get('email')
                # GitHub might not provide email, try to handle this case
                if not email:
                    # Can log or handle case where GitHub doesn't share email
                    logger.warning("GitHub login without email access, using username as fallback")
                    # You might want to use a placeholder email or username-based email
                    username = extra_data.get('login')
                    email = f"{username}@github.placeholder"
                
                # Get name from GitHub, with fallbacks
                full_name = extra_data.get('name')
                if not full_name:
                    full_name = extra_data.get('login', '')  # Use username if name not available
            else:  # Google or other providers
                email = extra_data.get('email')
                full_name = extra_data.get('name')

            logger.debug(f"Processing social login for email: {email}, provider: {provider}")

            # Try to get existing user
            try:
                user = UsersDB.objects.get(email=email)
                logger.info(f"Found existing user: {email}")
                # Update details if necessary
                user.full_name = full_name
                if provider == 'google':
                    user.google_id = uid
                elif provider == 'github':
                    # Assuming you've added github_id field to your UsersDB model
                    user.github_id = uid
                user.last_login = timezone.now()
                user.save()
            except UsersDB.DoesNotExist:
                logger.info(f"Creating new user: {email}")
                temp_phone = self.generate_unique_phone()
                
                user = UsersDB(
                    email=email,
                    full_name=full_name,
                    google_id=uid if provider == 'google' else None,
                    github_id=uid if provider == 'github' else None,  # Add GitHub ID
                    phone_number=temp_phone,
                    password='',  # Social accounts may not need a password initially
                    last_login=timezone.now(),
                    college_name="Unknown College",
                    dob=date(2000, 1, 1),
                )
                user.save()
                logger.info(f"Created new user with ID: {user.id}")

            sociallogin.user = user

            # Optionally set session data
            if request and hasattr(request, 'session'):
                request.session['user_id'] = user.id
                request.session.modified = True
                logger.debug(f"Session saved for user {user.id}")

            return user

        except IntegrityError as e:
            logger.error(f"IntegrityError in social account adapter: {str(e)}", exc_info=True)
            raise
        except Exception as e:
            logger.error(f"Error in social account adapter: {str(e)}", exc_info=True)
            raise
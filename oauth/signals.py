

from django.contrib.auth.signals import user_logged_in, user_logged_out
from django.dispatch import receiver
import logging

logger = logging.getLogger(__name__)

@receiver(user_logged_in)
def on_user_logged_in(sender, request, user, **kwargs):
    try:
        request.session['user_id'] = user.id
        request.session.save()
        logger.debug(f"User {user.id} logged in, session saved")
    except Exception as e:
        logger.error(f"Error in login signal handler: {str(e)}")

@receiver(user_logged_out)
def on_user_logged_out(sender, request, user, **kwargs):
    try:
        request.session.flush()
        logger.debug(f"User {user.id if user else 'Unknown'} logged out, session flushed")
    except Exception as e:
        logger.error(f"Error in logout signal handler: {str(e)}")

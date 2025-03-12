// Get references
document.addEventListener('DOMContentLoaded', function() {
    const editBtn = document.querySelector('.edit-button');
    const actionButtons = document.getElementById('action-buttons');
    const editableFields = document.querySelectorAll('[data-editable="true"]');
    const form = document.querySelector('form');
  
    // When "Edit Details" is clicked, enable editable fields and show buttons
    editBtn.addEventListener('click', () => {
      editableFields.forEach(field => {
        field.removeAttribute('disabled');
      });
      actionButtons.style.display = 'flex';
    });
  
    // When "Cancel" is clicked, disable the editable fields again and hide buttons
    document.querySelector('.cancel-button').addEventListener('click', (e) => {
      e.preventDefault(); // Prevent form submission
      editableFields.forEach(field => {
        field.setAttribute('disabled', true);
      });
      actionButtons.style.display = 'none';
    });
  
    // Form validation before submission
    form.addEventListener('submit', function(e) {
      let isValid = true;
      const email = form.querySelector('input[name="email"]');
      const phoneNumber = form.querySelector('input[name="phone_number"]');
      
      // Simple email validation
      if (email && email.value) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email.value)) {
          alert('Please enter a valid email address');
          e.preventDefault();
          isValid = false;
        }
      }
      
      // Simple phone validation (if not N/A)
      if (phoneNumber && phoneNumber.value && phoneNumber.value !== 'N/A') {
        const phoneRegex = /^\d{10}$/;
        if (!phoneRegex.test(phoneNumber.value.replace(/\D/g, ''))) {
          alert('Please enter a valid 10-digit phone number');
          e.preventDefault();
          isValid = false;
        }
      }
      
      // If form is valid, show loading state
      if (isValid) {
        document.querySelector('.save-button').textContent = 'Saving...';
        document.querySelector('.save-button').disabled = true;
      }
    });
  });
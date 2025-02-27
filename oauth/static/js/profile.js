
  // Get references
  const editBtn = document.querySelector('.edit-button');
  const actionButtons = document.getElementById('action-buttons');
  const editableFields = document.querySelectorAll('[data-editable="true"]');

  // When "Edit Details" is clicked, enable editable fields and show buttons
  editBtn.addEventListener('click', () => {
    editableFields.forEach(field => {
      field.removeAttribute('disabled');
    });
    actionButtons.style.display = 'flex';
  });

  // When "Cancel" is clicked, disable the editable fields again and hide buttons
  document.querySelector('.cancel-button').addEventListener('click', () => {
    editableFields.forEach(field => {
      field.setAttribute('disabled', true);
    });
    actionButtons.style.display = 'none';
  });

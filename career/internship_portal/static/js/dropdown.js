document.addEventListener('DOMContentLoaded', function() {
    const toggleIcon = document.querySelector('.toggle-icon');
    const dropdownContent = document.querySelector('.dropdown-content');
    const dropupIcon = document.querySelector('.dropup-icon');

    toggleIcon.addEventListener('click', function() {
        dropdownContent.style.display = 'flex';
        toggleIcon.style.display = 'none';
        dropupIcon.style.display = 'block';
    });

    dropupIcon.addEventListener('click', function() {
        dropdownContent.style.display = 'none';
        toggleIcon.style.display = 'block';
        dropupIcon.style.display = 'none';
    });
});

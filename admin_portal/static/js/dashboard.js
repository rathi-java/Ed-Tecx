document.addEventListener('DOMContentLoaded', () => {
    // Adding click event listeners to cards
    const cards = document.querySelectorAll('.card');

    cards.forEach(card => {
        card.addEventListener('click', () => {
            const pageName = card.getAttribute('data-page-name');
            if (pageName) {
                setActive(card); // Set active class and handle page display
            }
        });
    });
});

document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);
    const section = urlParams.get('section');

    if (section === "profile") {
        document.querySelectorAll(".current_page_action").forEach(el => el.classList.add("hidden"));
        document.querySelector("[data-page-name='dashboard']").classList.remove("hidden");
    }
});

function toggleDropdown(id, element) {
    var menu = document.getElementById(id);
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
    setActive(element, 0);
    let icon = element.querySelector('.icon_toggle');
    if (icon.classList.contains('fa-chevron-right')) {
        icon.classList.remove('fa-chevron-right');
        icon.classList.add('fa-chevron-down');
    } else {
        icon.classList.add('fa-chevron-right');
        icon.classList.remove('fa-chevron-down');
    }
}

function toggleSelectAll() {
    let selectAllCheckbox = document.getElementById("select_all");
    let checkboxes = document.querySelectorAll(".select_certificate");
    checkboxes.forEach(cb => cb.checked = selectAllCheckbox.checked);
}

function setActive(element, call_type = 1) {
    // Remove 'active' class from all list items and cards
    document.querySelectorAll('.sidebar ul li, .dropdown-menu li, .card').forEach(el => {
        el.classList.remove('active', 'hover_sidebar_color');
    });

    // Add 'active' and 'hover_sidebar_color' classes to the clicked element
    element.classList.add('active', 'hover_sidebar_color');

    if (call_type === 1) {
        const pages_elements = document.querySelectorAll(".current_page_action");
        pages_elements.forEach(e => {
            if (e.getAttribute("data-page-name") === element.getAttribute("data-page-name")) {
                e.classList.add('show');
                e.classList.remove('hidden');
            } else {
                e.classList.add('hidden');
                e.classList.remove('show');
            }
        });
    }
}

function openAdminForm() {
    document.querySelector('[data-page-name="manage_admin"]').classList.add('hidden');
    document.querySelector('[data-page-name="add_admin"]').classList.remove('hidden');
}

function toggleSelectAll(source) {
    let checkboxes = document.querySelectorAll('.row-checkbox');
    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
}

function editAdmin(id, fullName, email, phone, altPhone, password, aadhar) {
    document.getElementById('admin_id').value = id;
    document.getElementById('admin_full_name').value = fullName;
    document.getElementById('admin_email').value = email;
    document.getElementById('admin_phone').value = phone;
    document.getElementById('admin_alt_phone').value = altPhone;
    document.getElementById('admin_password').value = password;
    document.getElementById('admin_aadhar_number').value = aadhar;

    setActive(document.querySelector('[data-page-name="add_admin"]'));
}

function editManager(id, fullName, email, phone, altPhone, password, aadhar) {
    document.getElementById('manager_id').value = id;
    document.getElementById('manager_full_name').value = fullName;
    document.getElementById('manager_email').value = email;
    document.getElementById('manager_phone').value = phone;
    document.getElementById('manager_alt_phone').value = altPhone;
    document.getElementById('manager_password').value = password;
    document.getElementById('manager_aadhar_number').value = aadhar;

    setActive(document.querySelector('[data-page-name="add_manager"]'));
}

function openManagerForm() {
    document.querySelector('[data-page-name="manage_manager"]').classList.add('hidden');
    document.querySelector('[data-page-name="add_manager"]').classList.remove('hidden');
}

function editEmployee(id, fullName, email, phone, altPhone, password, aadhar) {
    document.getElementById('employee_id').value = id;
    document.getElementById('employee_full_name').value = fullName;
    document.getElementById('employee_email').value = email;
    document.getElementById('employee_phone').value = phone;
    document.getElementById('employee_alt_phone').value = altPhone;
    document.getElementById('employee_password').value = password;
    document.getElementById('employee_aadhar_number').value = aadhar;

    setActive(document.querySelector('[data-page-name="add_employee"]'));
}

function openEmployeeForm() {
    document.querySelector('[data-page-name="manage_employee"]').classList.add('hidden');
    document.querySelector('[data-page-name="add_employee"]').classList.remove('hidden');
}

function editCollege(id, name, location) {
    document.getElementById("college_id").value = id;
    document.getElementById("college_name").value = name;
    document.getElementById("college_location").value = location;
    setActive(document.querySelector('[data-page-name="add_college"]'));
}

function editUser(id, fullName, email, phoneNumber, collegeName, dob, referralCode,password) {
    console.log("Editing User:", id, fullName, email, phoneNumber, collegeName, dob, referralCode);

    document.getElementById("user_id").value = id || "";
    document.getElementById("user_full_name").value = fullName || "";
    document.getElementById("user_email").value = email || "";
    document.getElementById("user_phone_number").value = phoneNumber || "";
    document.getElementById("user_college_name").value = collegeName || "";
    document.getElementById("user_dob").value = dob || "";
    document.getElementById("user_referral_code").value = referralCode || "";
    document.getElementById("user_password").value = password || "";

    // Switch to the Add/Edit User page
    setActive(document.querySelector('[data-page-name="add_user"]'));
}

function editStudent(id, username, email, phone, altPhone, domainId, subjectId, date, payment, aadhar) {
    document.getElementById('student_id').value = id;
    document.getElementById('student_username').value = username;
    document.getElementById('student_email').value = email;
    document.getElementById('student_phone_number').value = phone;  
    document.getElementById('student_alt_phone_number').value = altPhone;  
    document.getElementById('domain').value = domainId || "";
    document.getElementById('student_subject').value = subjectId || ""; 
    document.getElementById('date').value = date;
    document.getElementById('payment').value = payment;
    document.getElementById('student_aadhar_number').value = aadhar;

    setActive(document.querySelector('[data-page-name="add_student"]'));
}


function openStudentForm() {
    document.querySelector('[data-page-name="manage_student"]').classList.add('hidden');
    document.querySelector('[data-page-name="add_student"]').classList.remove('hidden');
}

function filterSubjects() {
    var categoryId = document.getElementById("category").value;
    var subjects = document.getElementById("question_subject").options;

    for (var i = 0; i < subjects.length; i++) {
        var subjectCategory = subjects[i].getAttribute("data-category");
        subjects[i].style.display = subjectCategory === categoryId || subjectCategory === null ? "block" : "none";
    }
}

function loadSubjects() {
    var selectedCategory = document.getElementById("category").value;
    var subjectDropdown = document.getElementById("question_subject");
    subjectDropdown.innerHTML = '<option value="" disabled selected>Select Subject</option>';

    document.querySelectorAll("#question_subject option[data-category]").forEach(option => {
        if (option.getAttribute("data-category") === selectedCategory) {
            subjectDropdown.appendChild(option.cloneNode(true));
        }
    });
}

function editQuestion(id, questionText, subjectId) {
    document.getElementById('question_id').value = id;
    document.getElementById('question_text').value = questionText;
    document.getElementById('question_subject').value = subjectId;

    setActive(document.querySelector('[data-page-name="add_question"]'));
}

function loadSubjects() {
    var selectedCategory = document.getElementById("category").value;
    var subjectDropdown = document.getElementById("subject");
    subjectDropdown.innerHTML = '<option value="" disabled selected>Select Subject</option>';

    // Fetch subjects for the selected category
    fetch(`/get-subjects/?category_id=${selectedCategory}`)
        .then(response => response.json())
        .then(data => {
            data.subjects.forEach(subject => {
                var option = document.createElement("option");
                option.value = subject.id;
                option.text = subject.subject_name;
                subjectDropdown.appendChild(option);
            });
        });
}

    // Get the URL parameter
const urlParams = new URLSearchParams(window.location.search);
const page = urlParams.get('page');

// Show the Manage College section if the 'page' param is 'manage_college'
if (page === 'manage_college') {
document.querySelector('[data-page-name="manage_college"]').classList.add('active');
document.querySelector('[data-page-name="manage_college"]').click();
}

function filterColleges() {
    var input = document.getElementById("collegeSearch");
    var filter = input.value.toLowerCase();
    var table = document.getElementById("collegeTable");
    var rows = table.getElementsByTagName("tr");

    for (var i = 1; i < rows.length; i++) { // Start from 1 to skip the header row
        var collegeNameCell = rows[i].getElementsByClassName("college-name")[0];
        if (collegeNameCell) {
            var txtValue = collegeNameCell.textContent || collegeNameCell.innerText;
            if (txtValue.toLowerCase().indexOf(filter) > -1) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }
}

    // Show the Manage College section if the 'page' param is 'manage_college'
if (page === 'manage_admin') {
document.querySelector('[data-page-name="manage_admin"]').classList.add('active');
document.querySelector('[data-page-name="manage_admin"]').click();
}

function filterAdmins() {
let input = document.getElementById("search-admin").value.toLowerCase();
let table = document.getElementById("admin-table");
let rows = table.getElementsByTagName("tr");

for (let i = 1; i < rows.length; i++) {
    let name = rows[i].getElementsByClassName("admin-name")[0]?.textContent.toLowerCase() || "";
    let email = rows[i].getElementsByClassName("admin-email")[0]?.textContent.toLowerCase() || "";

    rows[i].style.display = (name.includes(input) || email.includes(input)) ? "" : "none";
}
}

            // Show the Manage College section if the 'page' param is 'manage_college'
if (page === 'manage_manager') {
document.querySelector('[data-page-name="manage_manager"]').classList.add('active');
document.querySelector('[data-page-name="manage_manager"]').click();
}

function filterManagers() {
    let input = document.getElementById("managerSearch").value.toLowerCase();
    let table = document.getElementById("managerTable");
    let rows = table.getElementsByTagName("tr");
    
    for (let i = 1; i < rows.length; i++) {
        let name = rows[i].getElementsByClassName("manager-name")[0]?.textContent.toLowerCase() || "";
        let email = rows[i].getElementsByClassName("manager-email")[0]?.textContent.toLowerCase() || "";
        
        rows[i].style.display = (name.includes(input) || email.includes(input)) ? "" : "none";
    }
}

if (page === 'manage_employee') {
    document.querySelector('[data-page-name="manage_employee"]').classList.add('active');
    document.querySelector('[data-page-name="manage_employee"]').click();
}

function filterEmployees() {
    let input = document.getElementById("employeeSearch").value.toLowerCase();
    let table = document.getElementById("employeeTable");
    let rows = table.getElementsByTagName("tr");
    
    for (let i = 1; i < rows.length; i++) {
        let name = rows[i].getElementsByClassName("employee-name")[0]?.textContent.toLowerCase() || "";
        let email = rows[i].getElementsByClassName("employee-email")[0]?.textContent.toLowerCase() || "";
        
        rows[i].style.display = (name.includes(input) || email.includes(input)) ? "" : "none";
    }
}

if (page === 'manage_user') {
    document.querySelector('[data-page-name="manage_user"]').classList.add('active');
    document.querySelector('[data-page-name="manage_user"]').click();
}

function filterUsers() {
    let input = document.getElementById("search-user").value.toLowerCase();
    let table = document.getElementById("user-table");
    let rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        let name = rows[i].getElementsByClassName("user-name")[0]?.textContent.toLowerCase() || "";
        let email = rows[i].getElementsByClassName("user-email")[0]?.textContent.toLowerCase() || "";

        rows[i].style.display = (name.includes(input) || email.includes(input)) ? "" : "none";
    }
}

if (page === 'manage_student') {
    document.querySelector('[data-page-name="manage_student"]').classList.add('active');
    document.querySelector('[data-page-name="manage_student"]').click();
}

function filterStudents() {
    let input = document.getElementById("search-student").value.toLowerCase();
    let table = document.getElementById("student-table");
    let rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        let name = rows[i].getElementsByClassName("student-name")[0]?.textContent.toLowerCase() || "";
        let email = rows[i].getElementsByClassName("student-email")[0]?.textContent.toLowerCase() || "";

        rows[i].style.display = (name.includes(input) || email.includes(input)) ? "" : "none";
    }
}

if (page === 'manage_jobs') {
    document.querySelector('[data-page-name="manage_jobs"]').classList.add('active');
    document.querySelector('[data-page-name="manage_jobs"]').click();
}

function filterJobs() {
    let searchInput = document.getElementById("jobSearch").value.toLowerCase();
    let jobRows = document.querySelectorAll("#jobTable tbody tr");

    jobRows.forEach(row => {
        let profile = row.querySelector(".job-profile")?.textContent.toLowerCase() || "";
        let company = row.querySelector(".company-name")?.textContent.toLowerCase() || "";
        let aboutJob = row.querySelector(".about-job")?.textContent.toLowerCase() || "";

        if (profile.includes(searchInput) || company.includes(searchInput) || aboutJob.includes(searchInput)) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}

function editJob(id, logoUrl, profile, companyName, state, city, minExp, maxExp, minPackage, maxPackage, employmentTypes, aboutJob, qualification) {
    // ✅ Ensure employmentTypes is an array
    if (!Array.isArray(employmentTypes)) {
        try {
            if (typeof employmentTypes === "string") {
                try {
                    employmentTypes = JSON.parse(employmentTypes);
                } catch (e) {
                    employmentTypes = employmentTypes.split(",").map(t => t.trim());
                }
            }
        } catch (e) {
            employmentTypes = [];
        }
    }

    // ✅ Populate form fields
    document.getElementById("job_id").value = id;
    document.getElementById("profile").value = profile;
    document.getElementById("company_name").value = companyName;
    document.getElementById("state").value = state;
    document.getElementById("city").value = city;
    document.getElementById("experience_min").value = minExp;
    document.getElementById("experience_max").value = maxExp;
    document.getElementById("package_min").value = minPackage;
    document.getElementById("package_max").value = maxPackage;
    document.getElementById("employment_types").value = employmentTypes.join(", ");  // ✅ Display correctly
    document.getElementById("about_job").value = aboutJob;
    document.getElementById("qualification").value = qualification;

    // ✅ Show the "Add Job" section
    setActive(document.querySelector('[data-page-name="add_jobs"]'));
}

function loadProfileData() {
    fetch("{% url 'get_superadmin_profile' %}")
    .then(response => response.json())
    .then(data => {
        document.querySelector("input[name='full_name']").value = data.full_name;
        document.querySelector("input[name='phone_number']").value = data.phone_number;
    })
    .catch(error => console.error("Error loading profile data:", error));
}

// Call function when Edit Profile section loads
if (window.location.search.includes("section=profile")) {
    loadProfileData();
}

function editStory(id, name, company, designation, package, batch, degree, branch, description) {
    document.getElementById('story_id').value = id;
    document.getElementById('story_name').value = name;
    document.getElementById('company_name').value = company;
    document.getElementById('designation').value = designation;
    document.getElementById('package').value = package;
    document.getElementById('batch').value = batch;
    document.getElementById('degree').value = degree;
    document.getElementById('branch').value = branch;
    document.getElementById('description').value = description;

    setActive(document.querySelector('[data-page-name="add_placement_stories"]'));
}

function openStoryForm() {
    document.querySelector('[data-page-name="manage_placement_stories"]').classList.add('hidden');
    document.querySelector('[data-page-name="add_placement_stories"]').classList.remove('hidden');
} 

if (page === 'manage_placement_stories') {
    document.querySelector('[data-page-name="manage_placement_stories"]').classList.add('active');
    document.querySelector('[data-page-name="manage_placement_stories"]').click();
}

function filterStories() {
    let input = document.getElementById("search-story").value.toLowerCase();
    let table = document.getElementById("placement-stories-table");
    let rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        let name = rows[i].getElementsByClassName("story-name")[0]?.textContent.toLowerCase() || "";
        let company = rows[i].getElementsByTagName("td")[2]?.textContent.toLowerCase() || "";

        rows[i].style.display = (name.includes(input) || company.includes(input)) ? "" : "none";
    }
}
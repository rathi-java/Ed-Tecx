function updateTopicOptions() {
    var domainSelect = document.getElementById("domain");
    var subjectSelect = document.getElementById("subject");
    var selectedCategory = domainSelect.value;

    // Show only subjects related to the selected category
    for (var i = 0; i < subjectSelect.options.length; i++) {
        var option = subjectSelect.options[i];
        var optionCategory = option.getAttribute("data-category");
        if (optionCategory === selectedCategory || option.value === "Select") {
            option.style.display = "block";
        } else {
            option.style.display = "none";
        }
    }

    subjectSelect.value = "Select";
}

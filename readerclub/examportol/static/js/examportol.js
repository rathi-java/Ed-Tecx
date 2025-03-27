document.addEventListener('DOMContentLoaded', function() {
    // Variables for exam functionality
    window.currentQuestionIndex = 0;
    window.totalQuestions = parseInt(document.getElementById('totalQuestions').value, 10);
    window.answeredQuestions = new Set();
    window.reviewedQuestions = new Set();

    function showQuestion(index) {
        if (typeof index === 'object') {
            index = parseInt(index.getAttribute('data-question-index'), 10);
        }
        if (index < 0 || index >= totalQuestions) {
            console.error(`Invalid index: ${index}`);
            return;
        }
        
        document.querySelectorAll('.question-container').forEach((q, i) => {
            q.style.display = (i === index) ? 'flex' : 'none';
        });
        document.querySelectorAll('.option-container').forEach((q, i) => {
            q.style.display = (i === index) ? 'flex' : 'none';
            q.style.overflow = "auto";
        });
        
        currentQuestionIndex = index;
        updateQuestionIndicators();
        updateNavigationButtons();
        updateMarkForReviewButton();
    }
    
    function updateNavigationButtons() {
        const prevButton = document.getElementById('prevButton');
        const saveNextButton = document.getElementById('saveNextButton');
        
        // Handle Previous button visibility
        if (currentQuestionIndex === 0) {
            prevButton.style.display = 'none';
        } else {
            prevButton.style.display = 'block';
        }
        
        // Handle Save & Next button text
        if (currentQuestionIndex === totalQuestions - 1) {
            saveNextButton.textContent = 'Save';
        } else {
            saveNextButton.textContent = 'Save & Next →';
        }
    }

    function updateMarkForReviewButton() {
        const markReviewButton = document.getElementById('markReviewButton');
        if (reviewedQuestions.has(currentQuestionIndex)) {
            markReviewButton.textContent = 'Unmark Review';
            markReviewButton.classList.remove('btn-orange');
            markReviewButton.classList.add('btn-normal');
        } else {
            markReviewButton.textContent = 'Mark for Review';
            markReviewButton.classList.remove('btn-normal');
            markReviewButton.classList.add('btn-orange');
        }
    }

    window.showQuestion = showQuestion;

    function navigateQuestion(direction) {
        const newIndex = direction === 'next' ? currentQuestionIndex + 1 : currentQuestionIndex - 1;
        if (newIndex >= 0 && newIndex < totalQuestions) {
            showQuestion(newIndex);
        }
    }
    window.navigateQuestion = navigateQuestion;

    // Updated function: Do not store the radio selection on change.
    // The radio response will only be stored when the Save & Next button is clicked.
    function updateQuestionStatus(input) {
        // Intentionally left empty.
    }
    window.updateQuestionStatus = updateQuestionStatus;

    function updateQuestionIndicators() {
        document.querySelectorAll('.question-indicator').forEach((indicator, index) => {
            indicator.className = 'question-indicator';
            if (index === currentQuestionIndex) {
                indicator.classList.add('current');
            } else if (reviewedQuestions.has(index)) {
                indicator.classList.add('marked-review');
            } else if (answeredQuestions.has(index)) {
                indicator.classList.add('answered');
            } else {
                indicator.classList.add('not-answered');
            }
        });
    }

    function updateCounts() {
        document.getElementById('answeredCount').textContent = answeredQuestions.size;
        document.getElementById('remainingCount').textContent = totalQuestions - answeredQuestions.size;
    }

    function markForReview() {
        if (reviewedQuestions.has(currentQuestionIndex)) {
            reviewedQuestions.delete(currentQuestionIndex);
        } else {
            reviewedQuestions.add(currentQuestionIndex);
        }
        updateQuestionIndicators();
        updateMarkForReviewButton();
        // After marking for review, move to next question if not on the last question
        if (currentQuestionIndex < totalQuestions - 1) {
            navigateQuestion('next');
        }
    }
    window.markForReview = markForReview;

    // Updated saveAndNext function: The radio button response is stored only when Save & Next is clicked.
    function saveAndNext() {
        const selectedInput = document.querySelector(`.question-container:nth-child(${currentQuestionIndex + 1}) input[type=radio]:checked`);
        if (selectedInput) {
            answeredQuestions.add(currentQuestionIndex);
            updateCounts();
            updateQuestionIndicators();
        }
        
        // Only navigate to next question if not on the last question
        if (currentQuestionIndex < totalQuestions - 1) {
            navigateQuestion('next');
        }
    }
    window.saveAndNext = saveAndNext;

    function confirmSubmit() {
        if (confirm("You are about to submit your test. Are you sure?")) {
            storeExamResult(); // Store the result before submission
            return true;
        }
        return false;
    }
    window.confirmSubmit = confirmSubmit;

    // Timer functionality
    let timeLeft = 3600; // 60 minutes in seconds
    function updateTimer() {
        const timerDisplay = document.getElementById("timerDisplay");
        if (timerDisplay) {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            timerDisplay.textContent = `${minutes}m:${seconds.toString().padStart(2, '0')}s`;
        }
        if (timeLeft > 0) {
            timeLeft--;
            setTimeout(updateTimer, 1000);
        } else {
            alert("Time's up! Your exam will now be submitted.");
            storeExamResult(); // Store the result before submission
            document.getElementById("examForm").submit();
        }
    }

    function storeExamResult() {
        // Logic to store the exam result (e.g., save answers to a database or local storage)
        console.log("Exam result stored successfully.");
    }

    // Calculator functionality
    function toggleCalculator() {
        const calcModal = document.getElementById("calculatorModal");
        calcModal.style.display = calcModal.style.display === "flex" ? "none" : "flex";
    }
    window.toggleCalculator = toggleCalculator;

    function closeCalculator() {
        document.getElementById("calculatorModal").style.display = "none";
    }
    window.closeCalculator = closeCalculator;

    // Initialize video stream for webcam
    if (navigator.mediaDevices?.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" } })
            .then(stream => {
                const video = document.getElementById('video');
                if (video) {
                    video.srcObject = stream;
                    video.style.transform = "scaleX(-1)";
                }
            })
            .catch(() => alert("Camera access denied. Please enable permissions."));
    }

    // Calculator implementation
    const display = document.getElementById('display');
    const buttons = document.querySelectorAll('.button');
    let currentExpression = '';

    buttons.forEach((button) => {
        button.addEventListener('click', () => {
            const value = button.getAttribute('data-value');
            handleButton(value);
        });
    });

    function handleButton(value) {
        switch (value) {
            case 'AC':
                clearDisplay();
                break;
            case '⌫':
                backspace();
                break;
            case '=':
                calculate();
                break;
            case 'sin':
            case 'cos':
            case 'tan':
            case 'log':
            case 'ln':
            case 'exp':
                appendValue(value + '(');
                break;
            case 'sqrt':
                appendValue('√(');
                break;
            case '^':
                appendValue('**');
                break;
            case '1/x':
                computeReciprocal();
                break;
            case 'x^2':
                computeSquare();
                break;
            default:
                appendValue(value);
        }
    }

    function clearDisplay() {
        currentExpression = '';
        display.value = '';
    }

    function backspace() {
        currentExpression = currentExpression.slice(0, -1);
        display.value = currentExpression;
    }

    function appendValue(val) {
        currentExpression += val;
        display.value = currentExpression;
    }

    function degreesToRadians(degrees) {
        return degrees * (Math.PI / 180);
    }

    function processTrigFunction(func, angle) {
        return Math[func](degreesToRadians(angle));
    }

    function calculate() {
        try {
            let processedExpression = currentExpression;
            // Handle trigonometric functions
            processedExpression = processedExpression.replace(/sin\(([^)]+)\)/g, (match, angle) =>
                processTrigFunction('sin', eval(angle))
            );
            processedExpression = processedExpression.replace(/cos\(([^)]+)\)/g, (match, angle) =>
                processTrigFunction('cos', eval(angle))
            );
            processedExpression = processedExpression.replace(/tan\(([^)]+)\)/g, (match, angle) =>
                processTrigFunction('tan', eval(angle))
            );
            // Replace mathematical functions
            processedExpression = processedExpression.replace(/log\(/g, 'Math.log10(');
            processedExpression = processedExpression.replace(/ln\(/g, 'Math.log(');
            processedExpression = processedExpression.replace(/exp\(/g, 'Math.exp(');
            processedExpression = processedExpression.replace(/√\(/g, 'Math.sqrt(');
            
            const result = eval(processedExpression);
            display.value = Number.isInteger(result) ? result : result.toFixed(4);
            currentExpression = display.value.toString();
        } catch (error) {
            display.value = 'Error';
            currentExpression = '';
        }
    }

    function computeReciprocal() {
        try {
            const value = eval(currentExpression);
            if (value === 0) {
                display.value = 'Error';
                currentExpression = '';
            } else {
                const result = 1 / value;
                display.value = Number.isInteger(result) ? result : result.toFixed(4);
                currentExpression = display.value.toString();
            }
        } catch (error) {
            display.value = 'Error';
            currentExpression = '';
        }
    }

    function computeSquare() {
        try {
            const value = eval(currentExpression);
            const result = value * value;
            display.value = Number.isInteger(result) ? result : result.toFixed(4);
            currentExpression = display.value.toString();
        } catch (error) {
            display.value = 'Error';
            currentExpression = '';
        }
    }

    // Initialize the exam
    showQuestion(0);
    updateTimer();
});

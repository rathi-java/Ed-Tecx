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
            q.style.display = (i === index) ? 'block' : 'none';
        });
        currentQuestionIndex = index;
        updateQuestionIndicators();
    }
    window.showQuestion = showQuestion;

    function navigateQuestion(direction) {
        const newIndex = direction === 'next' ? currentQuestionIndex + 1 : currentQuestionIndex - 1;
        if (newIndex >= 0 && newIndex < totalQuestions) {
            showQuestion(newIndex);
        }
    }
    window.navigateQuestion = navigateQuestion;

    function updateQuestionStatus(input) {
        answeredQuestions.add(parseInt(input.getAttribute('data-question-index'), 10));
        updateQuestionIndicators();
        updateCounts();
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
        reviewedQuestions.add(currentQuestionIndex);
        updateQuestionIndicators();
    }
    window.markForReview = markForReview;

    function confirmSubmit() {
        return totalQuestions - answeredQuestions.size === 0 ||
            confirm(`You have ${totalQuestions - answeredQuestions.size} unanswered questions. Submit anyway?`);
    }
    window.confirmSubmit = confirmSubmit;

    function saveAndNext() {
        const selectedInput = document.querySelector(`.question-container:nth-child(${currentQuestionIndex + 1}) input[type=radio]:checked`);
        if (selectedInput) answeredQuestions.add(currentQuestionIndex);
        updateCounts();
        updateQuestionIndicators();
        navigateQuestion('next');
    }
    window.saveAndNext = saveAndNext;

    let timeLeft = 3600;
    function updateTimer() {
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        document.getElementById("timerDisplay").textContent = `${minutes}m:${seconds.toString().padStart(2, '0')}s`;
        if (timeLeft > 0) {
            timeLeft--;
            setTimeout(updateTimer, 1000);
        } else {
            alert("Time's up! Submitting your exam...");
            document.getElementById("examForm").submit();
        }
    }
    window.updateTimer = updateTimer;

    // --- Toggle Calculator Functionality ---
    // This function toggles the display of the calculator modal.
    function toggleCalculator() {
        const calcModal = document.getElementById("calculatorModal");
        // If the calculator is currently visible (display set to "flex"), hide it.
        if (calcModal.style.display === "flex") {
            calcModal.style.display = "none";
        } else {
            calcModal.style.display = "flex";
        }
    }
    window.toggleCalculator = toggleCalculator;

    // You can still keep the following functions if needed.
    function openCalculator() {
        document.getElementById("calculatorModal").style.display = "flex";
    }
    window.openCalculator = openCalculator;

    function closeCalculator() {
        document.getElementById("calculatorModal").style.display = "none";
    }
    window.closeCalculator = closeCalculator;
    // --- End Toggle Calculator Functionality ---

    if (navigator.mediaDevices?.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" } })
            .then(stream => {
                const video = document.getElementById('video' );
                if (video) video.srcObject = stream;
                video.style.transform = "scaleX(-1)";
            })
            .catch(() => alert("Camera access denied. Please enable permissions."));
    }

    showQuestion(0);
    updateTimer();

    // Calculator functionality
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
            // For functions that need an argument, append the function name plus "("
            case 'sin':
            case 'cos':
            case 'tan':
            case 'log':
            case 'ln':
            case 'exp':
                appendValue(value + '(');
                break;
            // For square root, display a unique symbol that we later convert
            case 'sqrt':
                appendValue('√(');
                break;
            // For exponentiation, convert the caret into JavaScript’s "**"
            case '^':
                appendValue('**');
                break;
            // For reciprocal and square, compute immediately
            case '1/x':
                computeReciprocal();
                break;
            case 'x^2':
                computeSquare();
                break;
            default:
                // For numbers, operators, parentheses, and dot
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

    // Convert degrees to radians (for trigonometric functions)
    function degreesToRadians(degrees) {
        return degrees * (Math.PI / 180);
    }

    // Process a trigonometric function (sin, cos, tan) assuming the argument is in degrees
    function processTrigFunction(func, angle) {
        return Math[func](degreesToRadians(angle));
    }

    function calculate() {
        try {
            let processedExpression = currentExpression;
            // Replace sin, cos, tan expressions by evaluating them (using degrees)
            processedExpression = processedExpression.replace(/sin\(([^)]+)\)/g, (match, angle) =>
                processTrigFunction('sin', eval(angle))
            );
            processedExpression = processedExpression.replace(/cos\(([^)]+)\)/g, (match, angle) =>
                processTrigFunction('cos', eval(angle))
            );
            processedExpression = processedExpression.replace(/tan\(([^)]+)\)/g, (match, angle) =>
                processTrigFunction('tan', eval(angle))
            );
            // Replace the display tokens with the proper Math functions
            processedExpression = processedExpression.replace(/log\(/g, 'Math.log10(');
            processedExpression = processedExpression.replace(/ln\(/g, 'Math.log(');
            processedExpression = processedExpression.replace(/exp\(/g, 'Math.exp(');
            
            // Evaluate the final expression
            const result = eval(processedExpression);
            // Show an integer if possible, or round to 4 decimal places
            display.value = Number.isInteger(result) ? result : result.toFixed(4);
            currentExpression = display.value.toString();
        } catch (error) {
            display.value = 'Error';
            currentExpression = '';
        }
    }

    // Immediately compute the reciprocal (1/x) of the current evaluated expression
    function computeReciprocal() {
        try {
            const value = eval(currentExpression);
            if (value === 0) {
                display.value = 'Error';
                currentExpression = '';
            } else {
                const result = 1 / value;
                display.value = result;
                currentExpression = result.toString();
            }
        } catch (error) {
            display.value = 'Error';
            currentExpression = '';
        }
    }

    // Immediately compute the square (x²) of the current evaluated expression
    function computeSquare() {
        try {
            const value = eval(currentExpression);
            const result = value * value;
            display.value = result;
            currentExpression = result.toString();
        } catch (error) {
            display.value = 'Error';
            currentExpression = '';
        }
    }
});

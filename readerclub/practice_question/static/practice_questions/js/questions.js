    function checkAnswer(button, questionId) {
        const selectedAnswer = button.getAttribute("data-answer");
        const options = document.querySelectorAll(`#${questionId} .options button`);
        options.forEach(option => option.disabled = true);
        options.forEach(option => {
            const answerType = option.getAttribute("data-answer");
            if (answerType === "correct") {
                option.classList.add("correct");
            } else if (selectedAnswer !== "correct" && option === button) {
                button.classList.add("wrong");
            }
        });
        const resultDiv = document.querySelector(`#${questionId} .result`);
        if (!resultDiv) {
            const result = document.createElement("div");
            result.classList.add("result");
            result.textContent = selectedAnswer === "correct" ? "Correct Answer!" : "Wrong Answer!";
            document.querySelector(`#${questionId}`).appendChild(result);
        }
    }
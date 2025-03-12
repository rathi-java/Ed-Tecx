document.addEventListener("DOMContentLoaded", function() {
    // Get DOM elements
    const sendOtpForm = document.getElementById('sendOtpForm');
    const verifyOtpForm = document.getElementById('verifyOtpForm');
    const resetPasswordForm = document.getElementById('resetPasswordForm');
    const messageDiv = document.getElementById('message');
    const timerDiv = document.getElementById('timer');
    const sendOtpBtn = document.getElementById('sendOtpBtn');
    const emailHidden = document.getElementById('emailHidden');

    // Global variable to hold the user's email
    let userEmail = "";
    let countdownInterval = null;

    // Helper: Get CSRF token from cookies
    function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.substring(0, name.length + 1) === (name + '=')) {
            cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
            break;
        }
        }
    }
    return cookieValue;
    }

    // Start countdown timer and disable the Send OTP button
    function startCountdown(seconds) {
    let remaining = seconds;
    sendOtpBtn.disabled = true;
    timerDiv.classList.remove('hidden');
    timerDiv.innerHTML = "Please wait " + remaining + " seconds before resending OTP.";
    countdownInterval = setInterval(() => {
        remaining--;
        if (remaining > 0) {
        timerDiv.innerHTML = "Please wait " + remaining + " seconds before resending OTP.";
        } else {
        clearInterval(countdownInterval);
        timerDiv.classList.add('hidden');
        sendOtpBtn.disabled = false;
        timerDiv.innerHTML = "";
        }
    }, 1000);
    }

    // Step 1: Send OTP via email
    sendOtpForm.addEventListener('submit', function(e) {
    e.preventDefault();
    userEmail = document.getElementById('email').value;
    messageDiv.innerHTML = "";
    timerDiv.innerHTML = "";
    fetch(sendEmailUrl, {
        method: "POST",
        headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-CSRFToken": getCookie('csrftoken')
        },
        body: "email=" + encodeURIComponent(userEmail)
    })
    .then(response => response.json())
    .then(data => {
        // If a rate-limit error occurs, start the timer
        if (data.error) {
        let secondsMatch = data.error.match(/(\d+)\s*seconds/);
        if (secondsMatch) {
            startCountdown(parseInt(secondsMatch[1]));
        }
        // Proceed to OTP entry even if rate-limited, as OTP is assumed to be sent already.
        }
        // Transition to OTP entry in any case
        document.getElementById('step1').classList.add('hidden');
        document.getElementById('step2').classList.remove('hidden');
    })
    .catch(error => {
        messageDiv.innerHTML = "<p>Error sending OTP.</p>";
    });
    });

    // Step 2: Verify OTP
    verifyOtpForm.addEventListener('submit', function(e) {
    e.preventDefault();
    const otp = document.getElementById('otp').value;
    fetch(verifyOtpUrl, {
        method: "POST",
        headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-CSRFToken": getCookie('csrftoken')
        },
        body: "email=" + encodeURIComponent(userEmail) + "&otp=" + encodeURIComponent(otp)
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
        messageDiv.innerHTML = "<p>" + data.message + "</p>";
        // Set the hidden email field for Step 3 to ensure the same email is used.
        emailHidden.value = userEmail;
        document.getElementById('step2').classList.add('hidden');
        document.getElementById('step3').classList.remove('hidden');
        } else {
        messageDiv.innerHTML = "<p>" + data.message + "</p>";
        }
    })
    .catch(error => {
        messageDiv.innerHTML = "<p>Error verifying OTP.</p>";
    });
    });

    // Step 3: Reset Password
    resetPasswordForm.addEventListener('submit', function(e) {
    e.preventDefault();
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const emailForReset = emailHidden.value;

    fetch(resetPasswordUrl, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "X-CSRFToken": getCookie('csrftoken')
        },
        body: "email=" + encodeURIComponent(emailForReset) +
                "&new_password=" + encodeURIComponent(newPassword) +
                "&confirm_password=" + encodeURIComponent(confirmPassword)
    })
    .then(response => response.json())
    .then(data => {
        messageDiv.innerHTML = "<p>" + data.message + "</p>";
        if (data.message === "Password successfully reset") {
            setTimeout(() => {
                window.location.href = "{% url 'home' %}"; // Redirect to home
            }, 2000);
        }
    })
    .catch(error => {
        messageDiv.innerHTML = "<p>Error resetting password.</p>";
    });
    });
});



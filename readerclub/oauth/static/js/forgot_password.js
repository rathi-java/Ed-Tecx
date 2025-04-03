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

// Helper: Get CSRF token from cookies or from the direct template variable
function getCsrfToken() {
  // First try to get from template variable (most reliable)
  if (typeof csrfToken !== 'undefined' && csrfToken) {
    return csrfToken;
  }
  
  // Then try to get from the form if it exists
  const csrfInput = document.querySelector('input[name="csrfmiddlewaretoken"]');
  if (csrfInput) {
    return csrfInput.value;
  }
  
  // Fall back to cookie
  return getCookie('csrftoken');
}

// Helper: Get cookie by name
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

// Helper function to safely parse JSON responses
async function safelyParseJson(response) {
  const text = await response.text();
  try {
    return JSON.parse(text);
  } catch (error) {
    if (text.includes('<!DOCTYPE html>') || text.includes('<html>')) {
      throw new Error('Server returned HTML instead of JSON. Possible server error.');
    }
    throw new Error(`Failed to parse server response.`);
  }
}

// Step 1: Send OTP via email
sendOtpForm.addEventListener('submit', function(e) {
  e.preventDefault();
  userEmail = document.getElementById('email').value;
  messageDiv.innerHTML = "<p>Sending OTP, please wait...</p>";
  timerDiv.innerHTML = "";
  
  // Get the CSRF token from the form or cookie
  const token = getCsrfToken();
  
  fetch(sendEmailUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-CSRFToken": token
    },
    body: "email=" + encodeURIComponent(userEmail),
    credentials: 'same-origin' // Important for CSRF cookie handling
  })
  .then(response => {
    // Check if the response is ok
    if (!response.ok) {
      return safelyParseJson(response)
        .then(data => {
          throw new Error(data.error || `HTTP error ${response.status}`);
        })
        .catch(error => {
          throw new Error(`Server error (${response.status}): ${error.message}`);
        });
    }
    return safelyParseJson(response);
  })
  .then(data => {
    // Display the success message
    messageDiv.innerHTML = "<p class='success-message'>" + data.message + "</p>";
    
    // If a rate-limit error occurs, start the timer
    if (data.error && data.error.includes("Wait")) {
      let secondsMatch = data.error.match(/(\d+)\s*seconds/);
      if (secondsMatch) {
        startCountdown(parseInt(secondsMatch[1]));
      }
    } else {
      // Transition to OTP entry
      document.getElementById('step1').classList.add('hidden');
      document.getElementById('step2').classList.remove('hidden');
    }
  })
  .catch(error => {
    messageDiv.innerHTML = "<p class='error-message'>" + error.message + "</p>";
  });
});

// Step 2: Verify OTP
verifyOtpForm.addEventListener('submit', function(e) {
  e.preventDefault();
  const otp = document.getElementById('otp').value;
  const token = getCsrfToken();
  
  fetch(verifyOtpUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-CSRFToken": token
    },
    body: "email=" + encodeURIComponent(userEmail) + "&otp=" + encodeURIComponent(otp),
    credentials: 'same-origin'
  })
  .then(response => {
    if (!response.ok) {
      return safelyParseJson(response)
        .then(data => {
          throw new Error(data.message || `HTTP error ${response.status}`);
        })
        .catch(error => {
          throw new Error(`Server error (${response.status}): ${error.message}`);
        });
    }
    return safelyParseJson(response);
  })
  .then(data => {
    if (data.status === "success") {
      messageDiv.innerHTML = "<p class='success-message'>" + data.message + "</p>";
      // Set the hidden email field for Step 3 to ensure the same email is used.
      emailHidden.value = userEmail;
      document.getElementById('step2').classList.add('hidden');
      document.getElementById('step3').classList.remove('hidden');
    } else {
      messageDiv.innerHTML = "<p class='error-message'>" + data.message + "</p>";
    }
  })
  .catch(error => {
    messageDiv.innerHTML = "<p class='error-message'>" + error.message + "</p>";
  });
});

// Step 3: Reset Password
resetPasswordForm.addEventListener('submit', function(e) {
  e.preventDefault();
  const newPassword = document.getElementById('newPassword').value;
  const confirmPassword = document.getElementById('confirmPassword').value;
  const emailForReset = emailHidden.value;
  const token = getCsrfToken();

  fetch(resetPasswordUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-CSRFToken": token
    },
    body: "email=" + encodeURIComponent(emailForReset) +
          "&new_password=" + encodeURIComponent(newPassword) +
          "&confirm_password=" + encodeURIComponent(confirmPassword),
    credentials: 'same-origin'
  })
  .then(response => {
    if (!response.ok) {
      return safelyParseJson(response)
        .then(data => {
          throw new Error(data.message || `HTTP error ${response.status}`);
        })
        .catch(error => {
          throw new Error(`Server error (${response.status}): ${error.message}`);
        });
    }
    return safelyParseJson(response);
  })
  .then(data => {
    messageDiv.innerHTML = "<p class='success-message'>" + data.message + "</p>";
    if (data.message === "Password reset Successful" || data.message.includes("reset")) {
      setTimeout(() => {
        window.location.href = "/"; // Redirect to home
      }, 2000);
    }
  })
  .catch(error => {
    messageDiv.innerHTML = "<p class='error-message'>" + error.message + "</p>";
  });
});
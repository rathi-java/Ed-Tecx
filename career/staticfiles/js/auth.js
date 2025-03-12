
// ===============
const hamburger = document.getElementById("hamburger");
const mobileSidebar = document.getElementById("mobileSidebar");
const closeBtn = document.getElementById("closeBtn");

if (hamburger) {
  hamburger.addEventListener("click", () => {
    mobileSidebar.style.transform = "translateX(0)";
  });
}

if (closeBtn) {
  closeBtn.addEventListener("click", () => {
    mobileSidebar.style.transform = "translateX(-100%)";
  });
}

// ===============
// PROFILE DROPDOWN
// ===============
function toggleProfileDropdown(event) {
  event.stopPropagation();
  const menu = document.getElementById("profile-menu");
  if (menu) {
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
  }
}
document.addEventListener("click", function(e) {
  // Only handle clicks that are inside or directly related to .profile-dropdown
  const dropdown = document.querySelector(".profile-dropdown");
  if (!dropdown) return;

  // If the click is outside .profile-dropdown, close it
  if (!dropdown.contains(e.target)) {
    const profileMenu = document.getElementById("profile-menu");
    if (profileMenu) {
      profileMenu.style.display = "none";
    }
  }
});

// =====================
// LOGIN/SIGNUP POP-UP
// =====================
function openModal(defaultTab = 'login') {
  const modal = document.getElementById('Modal');
  if (modal) {
    modal.style.display = 'flex';
    switchTab(defaultTab);
  }
}

function closeModal() {
  const modal = document.getElementById('Modal');
  if (modal) {
    modal.style.display = 'none';
  }
}

function switchTab(tab) {
  const loginTab = document.getElementById('loginTab');
  const signupTab = document.getElementById('signupTab');
  const loginForm = document.getElementById('loginForm');
  const signupForm = document.getElementById('signupForm');
  const header = document.querySelector('#popupContainer .header');

  if (tab === 'login') {
    if (loginTab) loginTab.classList.add('active');
    if (signupTab) signupTab.classList.remove('active');
    if (loginForm) loginForm.style.display = 'block';
    if (signupForm) signupForm.style.display = 'none';
    if (header) header.innerHTML = "JOIN US";
  } else {
    if (signupTab) signupTab.classList.add('active');
    if (loginTab) loginTab.classList.remove('active');
    if (signupForm) signupForm.style.display = 'block';
    if (loginForm) loginForm.style.display = 'none';
    if (header) header.innerHTML = "JOIN US";
  }
}

// Close modal if clicked outside the container
window.onclick = function(event) {
  const modal = document.getElementById('Modal');
  if (event.target === modal) {
    closeModal();
  }
};

// // ===============
// // AUTH CHECK
// // ===============
// function handleAuthCheck(event, linkUrl) {
//     // If user is logged in, allow the link to proceed
//     if (typeof isLoggedIn !== 'undefined' && isLoggedIn) {
//       // Optionally, you can navigate to the linkUrl here
//       window.location.href = linkUrl;
//       return;
//     }
//     // Otherwise, prevent default and show the sign-in pop-up
//     event.preventDefault();
//     const authPop = document.getElementById('authPopUp');
//     if (authPop) {
//       authPop.style.display = 'flex';
//     }
// }  

// // Local login/signup modal triggers
// function showLoginModal() {
//   const authPop = document.getElementById('authPopUp');
//   if (authPop) authPop.style.display = 'none';
//   openModal('login');
// }
// function showSignupModal() {
//   const authPop = document.getElementById('authPopUp');
//   if (authPop) authPop.style.display = 'none';
//   openModal('signup');
// }

// // Close the auth pop-up if user clicks outside it
// const authPopUp = document.getElementById('authPopUp');
// if (authPopUp) {
//   authPopUp.addEventListener('click', function(event) {
//     if (event.target === authPopUp) {
//       authPopUp.style.display = 'none';
//     }
//   });
// }

// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
  // Get the auth pop-up element
  const authPopUp = document.getElementById('authPopUp');
  
  if (authPopUp) {
    // Event listener for clicking the overlay (outside the pop-up box)
    authPopUp.addEventListener('click', function(event) {
      // Check if the clicked element is the overlay itself, not its children
      if (event.target === authPopUp) {
        authPopUp.style.display = 'none';
      }
    });
    
    // Add a close button for better UX (optional)
    const popupBox = authPopUp.querySelector('.popup-box');
    if (popupBox) {
      const closeButton = document.createElement('button');
      closeButton.innerHTML = ''; // × symbol
      closeButton.className = 'popup-close-btn';
      closeButton.onclick = function() {
        authPopUp.style.display = 'none';
      };
      popupBox.appendChild(closeButton);
      
      // Add CSS for the close button
      const style = document.createElement('style');
      style.textContent = `
        .popup-close-btn {
          position: absolute;
          top: 10px;
          right: 10px;
          background: none;
          border: none;
          font-size: 24px;
          cursor: pointer;
          color: #777;
        }
        .popup-close-btn:hover {
          color: #333;
        }
      `;
      document.head.appendChild(style);
    }
  }
  
  // Function to show the auth pop-up
  window.showAuthPopUp = function() {
    if (authPopUp) {
      authPopUp.style.display = 'flex';
    }
  };
  
  // Function to handle auth check and show pop-up
  window.handleAuthCheck = function(event, linkUrl) {
    // If user is logged in, allow the link to proceed
    if (typeof isLoggedIn !== 'undefined' && isLoggedIn) {
      window.location.href = linkUrl;
      return;
    }
    // Otherwise, prevent default and show the sign-in pop-up
    event.preventDefault();
    if (authPopUp) {
      authPopUp.style.display = 'flex';
    }
  };

  // Functions for login/signup modal triggers
  window.showLoginModal = function() {
    if (authPopUp) authPopUp.style.display = 'none';
    openModal('login');
  };
  
  window.showSignupModal = function() {
    if (authPopUp) authPopUp.style.display = 'none';
    openModal('signup');
  };
});

// ===================
// PASSWORD TOGGLE
// ===================
function togglePassword(inputId, iconId) {
    const passField = document.getElementById(inputId);
    const icon = document.getElementById(iconId);
  
    if (passField && icon) {
      if (passField.type === "password") {
        // Show password
        passField.type = "text";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
      } else {
        // Hide password
        passField.type = "password";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
      }
    }
  }
  function openForgotModal() {
    const forgotModal = document.getElementById('ForgotModal');
    if (forgotModal) {
      // Always revert to Step 1
      document.getElementById('step1').classList.remove('hidden');
      document.getElementById('step2').classList.add('hidden');
      document.getElementById('step3').classList.add('hidden');
  
      // Clear any leftover message, timer, or error
      messageDiv.innerHTML = "";
      timerDiv.innerHTML = "";
      timerDiv.classList.add('hidden');
      if (countdownInterval) {
        clearInterval(countdownInterval);
        countdownInterval = null;
      }
      sendOtpBtn.disabled = false;
  
      // Optionally clear input fields if you want a fresh start
      document.getElementById('email').value = "";
      document.getElementById('otp').value = "";
      document.getElementById('newPassword').value = "";
      document.getElementById('confirmPassword').value = "";
  
      // Finally, show the modal
      forgotModal.style.display = 'flex'; 
    }
  }  
  
  function closeForgotModal() {
    const forgotModal = document.getElementById('ForgotModal');
    if (forgotModal) {
      forgotModal.style.display = 'none'; 
    }
  }
  
  // Optionally close if user clicks outside the container
  window.addEventListener('click', function(e) {
    const forgotModal = document.getElementById('ForgotModal');
    if (e.target === forgotModal) {
      closeForgotModal();
    }
  });
  
  document.addEventListener('DOMContentLoaded', function() {
    const forgotLink = document.getElementById('forgotPasswordLink');
    forgotLink.addEventListener('click', function(e) {
      e.preventDefault();         // stops navigation to "#"
      openForgotModal();          // show your modal
    });
  });
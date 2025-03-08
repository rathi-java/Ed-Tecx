document.addEventListener("DOMContentLoaded", function() {
    const counters = document.querySelectorAll('.count');

    counters.forEach(counter => {
      const targetValue = parseInt(counter.getAttribute('data-target'));
      const suffix = counter.getAttribute('data-suffix') || '';
      const increment = Math.ceil(targetValue / 50); // Adjust for speed
      let currentValue = 0;

      const updateCounter = setInterval(() => {
        currentValue += increment;
        if (currentValue >= targetValue) {
          counter.textContent = targetValue + suffix;
          clearInterval(updateCounter);
        } else {
          counter.textContent = currentValue + suffix;
        }
      }, 30); // Update interval in milliseconds
    });
  });



  document.addEventListener("DOMContentLoaded", function() {
    // Create a global flag to track if a FAQ was just clicked
    window.faqJustClicked = false;
    
    // Use a unique namespace for the FAQ functionality
    const faqSystem = {
      init: function() {
        // Select all FAQ items by their specific class
        const faqItems = document.querySelectorAll(".faq-list li a");
        
        faqItems.forEach(item => {
          item.addEventListener("click", this.handleFaqClick.bind(this));
        });
        
        // Add a global click listener to detect clicks outside FAQs
        document.addEventListener('click', function(e) {
          // If a FAQ was just clicked, reset the flag and do nothing
          if (window.faqJustClicked) {
            window.faqJustClicked = false;
            return;
          }
          
          // Only handle clicks that are outside FAQ items
          if (!e.target.closest('.faq-list')) {
            // Do nothing - preventing auto-close behavior
          }
        }, true); // Use capture phase to get this before other handlers
      },
      
      handleFaqClick: function(e) {
        e.preventDefault(); // Prevent default link behavior
        e.stopPropagation(); // Stop event from bubbling up
        
        // Set the global flag to prevent document click from firing
        window.faqJustClicked = true;
        
        // Get parent li element
        const parentLi = e.currentTarget.parentElement;
        
        // Get the dropdown content inside this li
        const dropdownContent = parentLi.querySelector(".dropdown-content");
        if (!dropdownContent) return;
        
        // Toggle current dropdown with proper event handling
        if (parentLi.classList.contains("faq-active")) {
          // Close this dropdown
          parentLi.classList.remove("faq-active");
          dropdownContent.style.maxHeight = "0px";
          dropdownContent.style.opacity = "0";
          setTimeout(() => {
            dropdownContent.style.display = "none";
          }, 300);
        } else {
          // First close all other open dropdowns
          document.querySelectorAll(".faq-list li.faq-active").forEach(activeLi => {
            // Skip if this is the one we're about to toggle
            if (activeLi !== parentLi) {
              activeLi.classList.remove("faq-active");
              const otherDropdown = activeLi.querySelector(".dropdown-content");
              if (otherDropdown) {
                otherDropdown.style.maxHeight = "0px";
                otherDropdown.style.opacity = "0";
                setTimeout(() => {
                  otherDropdown.style.display = "none";
                }, 300);
              }
            }
          });
          
          // Open this dropdown
          parentLi.classList.add("faq-active");
          dropdownContent.style.display = "block";
          
          // Use RAF to ensure display change is registered before setting height
          requestAnimationFrame(() => {
            requestAnimationFrame(() => {
              dropdownContent.style.maxHeight = dropdownContent.scrollHeight + "px";
              dropdownContent.style.opacity = "1";
            });
          });
        }
        
        // Prevent any other handlers from running
        setTimeout(() => {
          window.faqJustClicked = false;
        }, 100);
      }
    };
    
    // Initialize the FAQ system
    faqSystem.init();
    
    // Override any existing click handlers that might be causing issues
    const originalAddEventListener = Element.prototype.addEventListener;
    Element.prototype.addEventListener = function(type, listener, options) {
      if (type === 'click' && this.matches('.faq-list li a, .faq-list li, .dropdown-content, .dropdown-content *')) {
        // For FAQ elements, make sure our handlers take precedence
        const wrappedListener = function(e) {
          if (window.faqJustClicked) {
            // Skip other handlers when a FAQ was just clicked
            return;
          }
          listener.apply(this, arguments);
        };
        return originalAddEventListener.call(this, type, wrappedListener, options);
      }
      return originalAddEventListener.call(this, type, listener, options);
    };
  });

function setActiveTab(selectedTab) {
    // Remove active class from all tabs
    var tabs = document.querySelectorAll('.tab-abroad-sec4');
    tabs.forEach(function(tab) {
      tab.classList.remove('active-abroad-sec4');
    });
    selectedTab.classList.add('active-abroad-sec4');
    
    // Get region value from button text (convert to lowercase and replace spaces)
    var region = selectedTab.textContent.toLowerCase().replace(/ /g, "_");
    
    // Hide all cards
    var cards = document.querySelectorAll('.card-abroad-sec4');
    cards.forEach(function(card) {
      card.style.display = "none";
    });
    
    // Show cards matching the selected region
    var regionCards = document.querySelectorAll('.card-abroad-sec4[data-region="' + region + '"]');
    regionCards.forEach(function(card) {
      card.style.display = "block";
    });
  }

// section6

// <script>
// let index = 0;
// const cards = document.querySelectorAll(".card");
// const totalCards = cards.length;
// const visibleCards = 3;
// const slider = document.querySelector(".slider");

// function updateSlider() {
//     let centerIndex = (index + 1) % totalCards;
//     let moveX = -(index * 320);

//     // Move the slider
//     slider.style.transform = `translateX(${moveX}px)`;

//     // Apply styles dynamically
//     cards.forEach((card, i) => {
//         if (i === centerIndex) {
//             card.style.transform = "scale(1.2)";
//             card.style.opacity = "1";
//             card.style.boxShadow = "0 6px 12px rgba(0, 0, 0, 0.2)";
//         } else {
//             card.style.transform = "scale(1)";
//             card.style.opacity = "0.5";
//             card.style.boxShadow = "none";
//         }
//     });

//     // Update index for next slide
//     index = (index + 1) % totalCards;
// }

// setInterval(updateSlider, 3000);
// </script> //



// document.addEventListener('DOMContentLoaded', function() {
//   const slider = document.querySelector('.slider-abroad-sec6');
//   const wrapper = document.querySelector('.slider-container-abroad-sec6');
//   if (!slider || !wrapper) return;

//   const cards = Array.from(slider.querySelectorAll('.card-abroad-sec6'));
//   if (cards.length === 0) return;

//   const cardWidth = cards[0].offsetWidth + 
//                     parseInt(getComputedStyle(cards[0]).marginLeft) + 
//                     parseInt(getComputedStyle(cards[0]).marginRight);

//   let scrollPosition = 0;

//   // Clone the cards multiple times to prevent gaps
//   const cloneCards = () => {
//     const totalCardsNeeded = Math.ceil(wrapper.offsetWidth / cardWidth) + 2; // Ensure enough clones
//     for (let i = 0; i < totalCardsNeeded; i++) {
//       cards.forEach(card => {
//         const clone = card.cloneNode(true);
//         slider.appendChild(clone);
//       });
//     }
//   };
  
//   cloneCards(); // Clone initially

//   function scrollCards() {
//     scrollPosition -= 1.5; // Adjust speed if needed
//     slider.style.transform = `translateX(${scrollPosition}px)`;

//     // Reset scroll when first set is completely out of view
//     if (Math.abs(scrollPosition) >= cardWidth * cards.length) {
//       scrollPosition = 0;
//       slider.style.transform = `translateX(0px)`;
//     }

//     requestAnimationFrame(scrollCards);
//   }

//   // Start animation
//   scrollCards();

//   // Pause animation on hover
//   wrapper.addEventListener('mouseenter', () => {
//     slider.style.animationPlayState = 'paused';
//   });

//   wrapper.addEventListener('mouseleave', () => {
//     slider.style.animationPlayState = 'running';
//   });
// });

const sliderTrack = document.querySelector('.slider-abroad-sec6');
const slides = Array.from(sliderTrack.children);

function cloneSlides() {
    slides.forEach(slide => {
        const clone = slide.cloneNode(true);
        sliderTrack.appendChild(clone);
    });
}

cloneSlides();
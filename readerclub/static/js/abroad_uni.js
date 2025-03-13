document.addEventListener('DOMContentLoaded', function() {
  const slider = document.querySelector('.slider-university');
  const wrapper = document.querySelector('.slider-wrapper');
  if (!slider || !wrapper) return;
  
  // Get all original cards
  const cards = Array.from(slider.querySelectorAll('.card-university'));
  const cardWidth = cards[0].offsetWidth + 
                    parseInt(getComputedStyle(cards[0]).marginLeft) + 
                    parseInt(getComputedStyle(cards[0]).marginRight);
  const totalWidth = cardWidth * cards.length;
  
  // Clone cards and add to slider for initial seamless loop
  cards.forEach(card => {
    const clone = card.cloneNode(true);
    slider.appendChild(clone);
  });
  
  // Set up animation
  let scrollPosition = 0;
  
  function scrollCards() {
    scrollPosition -= 2.5; // Speed of scroll
    
    // Reset position when we've scrolled one set of cards
    if (Math.abs(scrollPosition) >= totalWidth) {
      scrollPosition = 0;
    }
    
    slider.style.transform = `translateX(${scrollPosition}px)`;
    
    // Check if we need to add more cards
    checkAndAddCards();
    
    requestAnimationFrame(scrollCards);
  }
  
  // Start animation
  scrollCards();
  
  // Pause animation on hover
  wrapper.addEventListener('mouseenter', () => {
    // We can't use animationPlayState since we're using requestAnimationFrame
    // Instead, we'll store the current state and position
    slider.setAttribute('data-paused', 'true');
  });
  
  wrapper.addEventListener('mouseleave', () => {
    slider.removeAttribute('data-paused');
  });
  
  // Function to check if we need to add more cards
  function checkAndAddCards() {
    // Don't add cards if animation is paused
    if (slider.getAttribute('data-paused') === 'true') {
      return;
    }
    
    const lastCardRight = slider.lastElementChild.getBoundingClientRect().right;
    const wrapperRight = wrapper.getBoundingClientRect().right;
    
    // If the last card is about to enter the viewport, add more cards
    if (lastCardRight - wrapperRight < totalWidth * 2) {
      cards.forEach(card => {
        const clone = card.cloneNode(true);
        slider.appendChild(clone);
      });
    }
  }
});
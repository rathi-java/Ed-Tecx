document.addEventListener('DOMContentLoaded', function() {
  const slider = document.querySelector('.slider-university');
  const wrapper = document.querySelector('.slider-wrapper');
  if (!slider || !wrapper) return;
  
  // Clone all items once (we'll handle the infinite effect differently)
  const cards = slider.querySelectorAll('.card-university');
  const cardWidth = cards[0].offsetWidth + parseInt(getComputedStyle(cards[0]).marginLeft) + 
                   parseInt(getComputedStyle(cards[0]).marginRight);
  const totalWidth = cardWidth * cards.length;
  
  // Clone enough cards to fill the container width plus buffer
  // This ensures we always have cards to scroll into view
  const requiredClones = Math.ceil((wrapper.offsetWidth * 2) / totalWidth) + 1;
  
  for (let i = 0; i < requiredClones; i++) {
    cards.forEach(card => {
      const clone = card.cloneNode(true);
      slider.appendChild(clone);
    });
  }
  
  let currentPosition = 0;
  const speed = 2.5; // Adjust scrolling speed
  
  function animateSlider() {
    currentPosition += speed;
    
    // Check if we need to reset position (when first set of cards moves out of view)
    if (currentPosition >= totalWidth) {
      // Instead of jumping to 0, shift back by the width of the original set
      // This creates the illusion of infinite scrolling
      currentPosition = currentPosition - totalWidth;
    }
    
    slider.style.transform = `translateX(-${currentPosition}px)`;
    requestAnimationFrame(animateSlider);
  }
  
  animateSlider();
  
  // Optional: Pause animation on hover
  slider.addEventListener('mouseenter', () => {
    slider.style.animationPlayState = 'paused';
  });
  
  slider.addEventListener('mouseleave', () => {
    slider.style.animationPlayState = 'running';
  });
});
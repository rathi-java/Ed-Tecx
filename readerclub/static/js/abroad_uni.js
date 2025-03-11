document.addEventListener('DOMContentLoaded', function() {
    const slider = document.querySelector('.slider-university');
    if (!slider) return;
  
    // Duplicate the items to create a seamless loop
    slider.innerHTML += slider.innerHTML;
  
    let pos = 0;
    const speed = 1;                 // Adjust scrolling speed
    const originalWidth = slider.scrollWidth / 2;
  
    function animateSlider() {
      pos += speed;
      // Once we've scrolled the width of the original content, reset
      if (pos >= originalWidth) {
        pos = 0;
      }
      slider.style.transform = `translateX(-${pos}px)`;
      requestAnimationFrame(animateSlider);
    }
  
    animateSlider();
  });  
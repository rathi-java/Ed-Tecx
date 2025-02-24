document.addEventListener("DOMContentLoaded", function () {
  // Get references to the left and right arrow buttons and the slider container
  const leftArrow = document.querySelector(".left-arrow");
  const rightArrow = document.querySelector(".right-arrow");
  const slider = document.querySelector(".cards-row");

  // Check if slider element exists
  if (!slider) {
    console.error("No element with class 'cards-row' was found.");
    return;
  }

  // Duplicate the slider's inner content to create an infinite scrolling effect.
  // This duplicates the cards so when we reach the end, we can seamlessly scroll back.
  slider.innerHTML += slider.innerHTML;

  // Store the original scroll width (half of the total since we duplicated the content)
  const originalScrollWidth = slider.scrollWidth / 2;

  // Define the auto-scroll speed (in pixels per second) and necessary variables
  const speed = 125;
  let isPaused = false;
  let lastTime = null;
  let animationFrameId = null;

  // Auto-scroll function using requestAnimationFrame
  // This function increments the scroll position based on elapsed time and the speed
  function animateScroll(timestamp) {
    // Initialize lastTime on first call
    if (lastTime === null) {
      lastTime = timestamp;
    }
    // Calculate the time difference between frames
    const delta = timestamp - lastTime;
    lastTime = timestamp;

    // If auto-scroll is not paused, update the slider's scroll position
    if (!isPaused) {
      slider.scrollLeft += speed * (delta / 1000);

      // If scrollLeft reaches the duplicated content's end, wrap it around for infinite scrolling
      if (slider.scrollLeft >= originalScrollWidth) {
        slider.scrollLeft -= originalScrollWidth;
      }
    }
    // Request the next animation frame
    animationFrameId = requestAnimationFrame(animateScroll);
  }

  // Start auto-scrolling by ensuring the isPaused flag is false.
  // We don't cancel the animation frame; we just let animateScroll run.
  function startAutoScroll() {
    isPaused = false;
  }

  // Stop auto-scrolling by setting isPaused to true
  function stopAutoScroll() {
    isPaused = true;
  }

  // Start auto-scrolling immediately by setting isPaused to false and requesting the first frame.
  startAutoScroll();
  animationFrameId = requestAnimationFrame(animateScroll);

  // Add event listeners to each card so that auto-scroll pauses only when hovering over a card.
  const cards = document.querySelectorAll(".card");
  cards.forEach((card) => {
    card.addEventListener("mouseenter", stopAutoScroll);
    card.addEventListener("mouseleave", startAutoScroll);
  });

  // Smooth manual scroll function for arrow click events.
  // This function smoothly scrolls the slider by a given delta over a specified duration.
  function smoothScroll(deltaScroll, duration = 600) {
    const startTime = performance.now();
    const initialScrollLeft = slider.scrollLeft;

    // The step function uses requestAnimationFrame to update the scroll position gradually.
    function step(currentTime) {
      const elapsed = currentTime - startTime;
      // Calculate progress as a value between 0 and 1
      const progress = Math.min(elapsed / duration, 1);
      // Calculate the current position using linear interpolation
      const currentPos = initialScrollLeft + deltaScroll * progress;
      slider.scrollLeft = currentPos;

      // Handle infinite scrolling in both directions
      if (slider.scrollLeft >= originalScrollWidth) {
        slider.scrollLeft -= originalScrollWidth;
      } else if (slider.scrollLeft < 0) {
        slider.scrollLeft += originalScrollWidth;
      }

      // If animation is not complete, request the next frame
      if (progress < 1) {
        requestAnimationFrame(step);
      }
    }
    requestAnimationFrame(step);
  }

  // Left arrow click handler: scrolls the slider to the left by half the container's width
  leftArrow.addEventListener("click", function () {
    const scrollAmount = slider.clientWidth * 0.5;
    smoothScroll(-scrollAmount);
  });

  // Right arrow click handler: scrolls the slider to the right by half the container's width
  rightArrow.addEventListener("click", function () {
    const scrollAmount = slider.clientWidth * 0.5;
    smoothScroll(scrollAmount);
  });

  // Save the current scroll position when a card is clicked, so that if the user navigates away and back, the position is restored
  const cardLinks = document.querySelectorAll(".card-link");
  cardLinks.forEach(function (link) {
    link.addEventListener("click", function () {
      sessionStorage.setItem("sliderScrollLeft", slider.scrollLeft);
    });
  });

  // If a scroll position was saved, restore it
  const storedScroll = sessionStorage.getItem("sliderScrollLeft");
  if (storedScroll !== null) {
    slider.scrollLeft = parseInt(storedScroll, 10);
  }
});
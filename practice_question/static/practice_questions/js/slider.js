document.addEventListener("DOMContentLoaded", function () {
  const leftArrow = document.querySelector(".left-arrow");
  const rightArrow = document.querySelector(".right-arrow");
  const slider = document.querySelector(".cards-row");
  if (!slider) {
    console.error("No element with class 'cards-row' was found.");
    return;
  }
  slider.innerHTML += slider.innerHTML;
  const originalScrollWidth = slider.scrollWidth / 2;
  const speed = 125;
  let isPaused = false;
  let lastTime = null;
  let animationFrameId = null;
  function animateScroll(timestamp) {
    if (lastTime === null) {
      lastTime = timestamp;
    }
    const delta = timestamp - lastTime;
    lastTime = timestamp;
    if (!isPaused) {
      slider.scrollLeft += speed * (delta / 1000);
      if (slider.scrollLeft >= originalScrollWidth) {
        slider.scrollLeft -= originalScrollWidth;
      }
    }
    animationFrameId = requestAnimationFrame(animateScroll);
  }
  function startAutoScroll() {
    isPaused = false;
    lastTime = null;
    if (!animationFrameId) {
      animationFrameId = requestAnimationFrame(animateScroll);
    }
  }
  function stopAutoScroll() {
    isPaused = true;
  }
  startAutoScroll();
  slider.addEventListener("mouseenter", stopAutoScroll);
  slider.addEventListener("mouseleave", startAutoScroll);
  leftArrow.addEventListener("click", function () {
    stopAutoScroll();
    const scrollAmount = slider.clientWidth * 0.5;
    slider.scrollLeft -= scrollAmount;
    if (slider.scrollLeft < 0) {
      slider.scrollLeft += originalScrollWidth;
    }
    setTimeout(startAutoScroll, 1000);
  });
  rightArrow.addEventListener("click", function () {
    stopAutoScroll();
    const scrollAmount = slider.clientWidth * 0.5;
    slider.scrollLeft += scrollAmount;
    if (slider.scrollLeft >= originalScrollWidth) {
      slider.scrollLeft -= originalScrollWidth;
    }
    setTimeout(startAutoScroll, 1000);
  });
  const cardLinks = document.querySelectorAll(".card-link");
  cardLinks.forEach(function (link) {
    link.addEventListener("click", function () {
      sessionStorage.setItem("sliderScrollLeft", slider.scrollLeft);
    });
  });
  const storedScroll = sessionStorage.getItem("sliderScrollLeft");
  if (storedScroll !== null) {
    slider.scrollLeft = parseInt(storedScroll, 10);
  }
});
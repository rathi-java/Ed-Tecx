document.addEventListener('DOMContentLoaded', function() {
  const slider = document.querySelector('.slider-university');
  const wrapper = document.querySelector('.slider-wrapper');
  if (!slider || !wrapper) return;

  const cards = Array.from(slider.querySelectorAll('.card-university'));
  const cardWidth = cards[0].offsetWidth + 
                    parseInt(getComputedStyle(cards[0]).marginLeft) + 
                    parseInt(getComputedStyle(cards[0]).marginRight);
  const totalWidth = cardWidth * cards.length;

  cards.forEach(card => {
    const clone = card.cloneNode(true);
    slider.appendChild(clone);
  });

  let scrollPosition = 0;
  let animationFrame;

  function scrollCards() {
    scrollPosition -= 2.5;
    if (Math.abs(scrollPosition) >= totalWidth) {
      scrollPosition = 0;
    }
    slider.style.transform = `translateX(${scrollPosition}px)`;
    animationFrame = requestAnimationFrame(scrollCards);
  }

  function startScroll() {
    if (!animationFrame) {
      scrollCards();
    }
  }

  function stopScroll() {
    cancelAnimationFrame(animationFrame);
    animationFrame = null;
  }

  wrapper.addEventListener('mouseenter', stopScroll);
  wrapper.addEventListener('mouseleave', startScroll);

  startScroll();
});
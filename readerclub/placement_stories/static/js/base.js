const hamburger = document.getElementById("hamburger");
const closeBtn = document.getElementById("close-btn");
const navLinks = document.getElementById("nav-links");

if (hamburger && navLinks) {
  hamburger.addEventListener("click", () => {
    navLinks.classList.add("active");
  });

  closeBtn.addEventListener("click", () => {
    navLinks.classList.remove("active");
  });
}
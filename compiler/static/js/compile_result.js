document.addEventListener("DOMContentLoaded", function() {
  // Initialize CodeMirror on the code textarea
  const editor = CodeMirror.fromTextArea(document.getElementById("code"), {
    lineNumbers: true,
    mode: "text/x-c++src",  // Adjust the mode depending on the language
    theme: "default",
  });

  // Handle Resizing
  const verticalDivider = document.querySelector("#vertical-divider");
  const horizontalDivider = document.querySelector("#horizontal-divider");
  const editorContainer = document.querySelector(".editor-container");
  const outputContainer = document.querySelector(".output-container");
  const codeArea = document.querySelector(".code-area");
  const inputArea = document.querySelector(".input-area");

  let isVerticalDragging = false;
  let isHorizontalDragging = false;

  // Vertical Resizing Logic
  verticalDivider.addEventListener("mousedown", () => {
    isVerticalDragging = true;
    document.body.style.cursor = "col-resize";
  });

  document.addEventListener("mousemove", (e) => {
    if (isVerticalDragging) {
      const editorContainerRect = editorContainer.getBoundingClientRect();
      const offsetX = e.clientX - editorContainerRect.left;

      // Ensure proper boundaries
      const minFlex = 0.2; // Minimum width as flex ratio
      const maxFlex = 0.8; // Maximum width as flex ratio
      const containerWidth = editorContainer.offsetWidth;

      let leftFlex = Math.max(minFlex, offsetX / containerWidth);
      leftFlex = Math.min(leftFlex, maxFlex);

      const rightFlex = 1 - leftFlex;

      // Update flex values for code and input areas
      codeArea.style.flex = leftFlex;
      inputArea.style.flex = rightFlex;
    }

    if (isHorizontalDragging) {
      const containerHeight = editorContainer.parentElement.offsetHeight;
      const offsetY = e.clientY - editorContainer.parentElement.getBoundingClientRect().top;

      // Adjust height dynamically ensuring a minimum and maximum height
      const minHeight = 100; // Minimum height in pixels
      const maxHeight = containerHeight - minHeight; // Maximum height in pixels

      const topHeight = Math.max(minHeight, Math.min(offsetY, maxHeight));
      const bottomHeight = containerHeight - topHeight;

      editorContainer.style.height = `${topHeight}px`;
      outputContainer.style.height = `${bottomHeight}px`;
    }
  });

  // Stop dragging on mouse up
  document.addEventListener("mouseup", () => {
    isVerticalDragging = false;
    isHorizontalDragging = false;
    document.body.style.cursor = "default";
  });

  // Horizontal Resizing
  horizontalDivider.addEventListener("mousedown", () => {
    isHorizontalDragging = true;
    document.body.style.cursor = "ns-resize";
  });

  // Language Logo Update
  function changeLogo() {
    const language = document.getElementById("language").value;
    const logo = document.getElementById("logo");

    if (language === "java") {
      logo.src = "/static/images/java.png";
    } else if (language === "python") {
      logo.src = "/static/images/python.png";
    } else if (language === "javascript") {
      logo.src = "/static/images/javascript.png";
    }
  }
  // Set initial logo and update on language change
  changeLogo();
  document.getElementById("language").addEventListener("change", changeLogo);
});
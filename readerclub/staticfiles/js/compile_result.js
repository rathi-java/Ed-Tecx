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
  let dragStartY, initialEditorHeight, initialOutputHeight, totalHeight;

  // Vertical Resizing Logic (width between code and input areas)
  verticalDivider.addEventListener("mousedown", () => {
    isVerticalDragging = true;
    document.body.style.cursor = "col-resize";
  });

  document.addEventListener("mousemove", (e) => {
    if (isVerticalDragging) {
      const editorContainerRect = editorContainer.getBoundingClientRect();
      const offsetX = e.clientX - editorContainerRect.left;
      const minFlex = 0.2;
      const maxFlex = 0.8;
      const containerWidth = editorContainer.offsetWidth;
      let leftFlex = Math.max(minFlex, offsetX / containerWidth);
      leftFlex = Math.min(leftFlex, maxFlex);
      const rightFlex = 1 - leftFlex;
      codeArea.style.flex = leftFlex;
      inputArea.style.flex = rightFlex;
    }
    if (isHorizontalDragging) {
      const deltaY = e.clientY - dragStartY;
      const minHeight = 100;
      const maxEditorHeight = totalHeight - minHeight;
      let newEditorHeight = initialEditorHeight + deltaY;
      newEditorHeight = Math.max(minHeight, Math.min(newEditorHeight, maxEditorHeight));
      const newOutputHeight = totalHeight - newEditorHeight;
      editorContainer.style.height = `${newEditorHeight}px`;
      outputContainer.style.height = `${newOutputHeight}px`;
    }
  });

  document.addEventListener("mouseup", () => {
    isVerticalDragging = false;
    isHorizontalDragging = false;
    document.body.style.cursor = "default";
  });

  // Horizontal Resizing Logic (height between editor and output areas)
  horizontalDivider.addEventListener("mousedown", (e) => {
    isHorizontalDragging = true;
    document.body.style.cursor = "ns-resize";
    dragStartY = e.clientY;
    initialEditorHeight = editorContainer.offsetHeight;
    initialOutputHeight = outputContainer.offsetHeight;
    totalHeight = initialEditorHeight + initialOutputHeight;
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

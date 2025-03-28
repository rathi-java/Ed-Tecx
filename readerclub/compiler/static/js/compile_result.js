document.addEventListener("DOMContentLoaded", function() {
  // Ensure CodeMirror is loaded before using it
  if (typeof CodeMirror !== 'undefined') {
      // Initialize CodeMirror on the code textarea
      const codeTextarea = document.getElementById("code");
      if (codeTextarea) {
          const editor = CodeMirror.fromTextArea(codeTextarea, {
              lineNumbers: true,
              mode: "text/x-c++src",  // Adjust the mode depending on the language
              theme: "default",
              autoRefresh: true, // Add this to help with hidden elements
          });
          
          // Update CodeMirror when language changes
          document.getElementById("language").addEventListener("change", function() {
              const language = this.value;
              let mode = "text/x-c++src";
              
              if (language === "python") {
                  mode = "text/x-python";
              } else if (language === "javascript") {
                  mode = "text/javascript";
              } else if (language === "java") {
                  mode = "text/x-java";
              }
              
              editor.setOption("mode", mode);
          });

          // Handle form submission with AJAX
          const codeForm = document.getElementById("code-form");
          if (codeForm) {
              codeForm.addEventListener("submit", function(e) {
                  e.preventDefault(); // Prevent traditional form submission
                  
                  // Make sure CodeMirror content is updated in the textarea
                  editor.save();
                  
                  // Get the form data
                  const formData = new FormData(this);
                  
                  // Show loading indicator
                  const outputContainer = document.getElementById("output");
                  if (outputContainer) {
                      outputContainer.textContent = "Compiling...";
                  }
                  
                  // Send AJAX request
                  fetch('/compiler/compiler/', {
                      method: 'POST',
                      body: formData,
                      headers: {
                          'X-Requested-With': 'XMLHttpRequest',
                      }
                  })
                  .then(response => response.text())
                  .then(html => {
                      // Extract output from the HTML response
                      const parser = new DOMParser();
                      const doc = parser.parseFromString(html, 'text/html');
                      const outputContent = doc.querySelector('#output-content');
                      
                      if (outputContainer && outputContent) {
                          outputContainer.innerHTML = outputContent.innerHTML;
                      } else if (outputContainer) {
                          outputContainer.textContent = "Execution completed.";
                      }
                  })
                  .catch(error => {
                      console.error('Error:', error);
                      if (outputContainer) {
                          outputContainer.textContent = "Error: " + error.message;
                      }
                  });
              });
          }
      } else {
          console.error("Code textarea not found");
      }
  } else {
      console.error("CodeMirror is not loaded");
  }

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

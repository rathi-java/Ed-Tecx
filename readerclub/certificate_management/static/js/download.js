function downloadAsPNG() {
    let certificateElement = document.getElementById("capture");  // Make sure the div exists
    if (!certificateElement) {
        console.error("Error: Certificate element not found.");
        return;
    }

    html2canvas(certificateElement, {
        useCORS: true,
        allowTaint: true
    }).then(canvas => {
        let link = document.createElement('a');
        link.href = canvas.toDataURL('image/png');

        // Get certificate ID from Django context
        let userId = "{{ certificate.unique_id }}";
        let fileName = userId ? `certificate_${userId}.png` : 'certificate.png';

        link.download = fileName;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }).catch(error => {
        console.error("Error generating PNG:", error);
    });
}
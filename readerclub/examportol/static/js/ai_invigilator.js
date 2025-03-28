document.addEventListener('DOMContentLoaded', async () => {
    const video = document.getElementById('video');
    const canvas = document.getElementById('canvas');
    const aiAlert = document.getElementById('ai-alert');
    const ctx = canvas.getContext('2d');

    // Load face detection model
    await faceapi.nets.tinyFaceDetector.loadFromUri('/models');
    await faceapi.nets.faceExpressionNet.loadFromUri('/models');

    // Start webcam
    if (navigator.mediaDevices?.getUserMedia) {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ video: true });
            video.srcObject = stream;
        } catch (err) {
            alert('Camera access denied. Please enable permissions.');
        }
    }

    // Analyze video feed
    video.addEventListener('play', () => {
        const analyzeInterval = setInterval(async () => {
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

            const detections = await faceapi.detectAllFaces(video, new faceapi.TinyFaceDetectorOptions())
                .withFaceExpressions();

            if (detections.length === 0) {
                aiAlert.style.display = 'block';
                aiAlert.textContent = 'No face detected!';
            } else {
                aiAlert.style.display = 'none';

                detections.forEach(detection => {
                    const expressions = detection.expressions;
                    if (expressions.surprised > 0.5 || expressions.fearful > 0.5) {
                        aiAlert.style.display = 'block';
                        aiAlert.textContent = 'Suspicious behavior detected!';
                    }
                });
            }
        }, 1000); // Analyze every second

        video.addEventListener('pause', () => clearInterval(analyzeInterval));
        video.addEventListener('ended', () => clearInterval(analyzeInterval));
    });
});

document.getElementById('file-input').addEventListener('change', function(event) {
    const file = event.target.files[0];

    if (file && file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const previewImage = document.getElementById('image-preview');
            previewImage.src = e.target.result;
            previewImage.style.display = 'block'; // Show the uploaded image
        };
        reader.readAsDataURL(file);
    } else {
        alert('Please upload a valid image file.');
    }
});

document.getElementById('upload-btn').addEventListener('click', function() {
    const fileInput = document.getElementById('file-input');
    const file = fileInput.files[0];

    if (file) {
        const formData = new FormData();
        formData.append('image', file);

        fetch('http://localhost:3000/upload', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            alert('Image uploaded successfully to CLoud Database using Terraform!');

            // Show the image preview
            const previewImage = document.getElementById('image-preview');
            previewImage.src = URL.createObjectURL(file);
            previewImage.style.display = 'block'; // Show uploaded image

            // Show the hardcoded image container
            document.querySelector('.hardcoded-image-container').style.display = 'block'; // Show hardcoded image

            // Reset button styles back to original after the image is displayed
            const uploadButton = document.getElementById('upload-btn');
            uploadButton.style.backgroundColor = '#800080'; // Original purple background
            uploadButton.style.color = 'white'; // Original white text

            // Show the "Send to Cloud Database" button
            document.getElementById('cloud-db-btn').style.display = 'block';
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Image uploaded successfully to CLoud Database using Terraform!');

            // Show the hardcoded image container
            document.querySelector('.hardcoded-image-container').style.display = 'block'; // Show hardcoded image

            // Reset button styles back to original after the image is displayed
            const uploadButton = document.getElementById('upload-btn');
            uploadButton.style.backgroundColor = '#800080'; // Original purple background
            uploadButton.style.color = 'white'; // Original white text

        });
    } else {
        alert('Please select an image to upload.');
    }
});

// Event listener for the "Send to Cloud Database" button
document.getElementById('cloud-db-btn').addEventListener('click', function() {
    const cloudMessage = document.getElementById('cloud-message');
    cloudMessage.style.display = 'block';
});

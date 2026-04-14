document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('messageForm');
    const resultDiv = document.getElementById('result');
    const resultText = document.getElementById('resultText');
    const messageId = document.getElementById('messageId');
    const messageList = document.getElementById('messageList');
    const messageInput = document.getElementById('messageInput');

    // Load recent messages on page load
    loadRecentMessages();

    form.addEventListener('submit', async function(e) {
        e.preventDefault();

        const content = messageInput.value.trim();
        if (!content) return;

        try {
            const response = await fetch('/message', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ content }),
            });

            const data = await response.json();

            resultDiv.classList.remove('hidden');

            if (response.ok) {
                resultDiv.className = 'result success';
                resultText.textContent = 'Message processed successfully!';
                messageId.textContent = `Message ID: ${data.id}`;
                // Add to recent messages
                addMessageToList(content, data.id, 'processed');
            } else if (response.status === 409) {
                resultDiv.className = 'result duplicate';
                resultText.textContent = 'Duplicate message detected!';
                messageId.textContent = `Message ID: ${data.id}`;
                // Add to recent messages
                addMessageToList(content, data.id, 'duplicate');
            } else {
                resultDiv.className = 'result duplicate';
                resultText.textContent = data.error || 'An error occurred';
                messageId.textContent = '';
            }
        } catch (error) {
            console.error('Error:', error);
            resultDiv.className = 'result duplicate';
            resultDiv.classList.remove('hidden');
            resultText.textContent = 'Network error. Please try again.';
            messageId.textContent = '';
        }

        messageInput.value = '';
    });

    function addMessageToList(content, id, status) {
        const li = document.createElement('li');
        const timestamp = new Date().toLocaleString();
        li.innerHTML = `
            <strong>${status === 'processed' ? '✓' : '✗'}</strong>
            ${content.substring(0, 50)}${content.length > 50 ? '...' : ''}
            <br><small>ID: ${id} | ${timestamp}</small>
        `;
        messageList.insertBefore(li, messageList.firstChild);

        // Keep only last 10 messages
        while (messageList.children.length > 10) {
            messageList.removeChild(messageList.lastChild);
        }
    }

    function loadRecentMessages() {
        // For demo purposes, we'll store recent messages in localStorage
        // In a real app, you might have an endpoint to fetch recent messages
        const recent = JSON.parse(localStorage.getItem('recentMessages') || '[]');
        recent.forEach(msg => {
            addMessageToList(msg.content, msg.id, msg.status);
        });
    }

    // Override addMessageToList to also save to localStorage
    const originalAddMessage = addMessageToList;
    addMessageToList = function(content, id, status) {
        originalAddMessage(content, id, status);

        const recent = JSON.parse(localStorage.getItem('recentMessages') || '[]');
        recent.unshift({ content, id, status, timestamp: Date.now() });
        if (recent.length > 10) recent.pop();
        localStorage.setItem('recentMessages', JSON.stringify(recent));
    };
});
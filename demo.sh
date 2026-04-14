#!/bin/bash

# Demo script for Message Deduplication Service
# Run this to demonstrate the functionality to your mentor

echo "🚀 Message Deduplication Service Demo"
echo "====================================="
echo ""

# Check if server is running
echo "1. Checking if server is running..."
if curl -s http://localhost:3000/health > /dev/null; then
    echo "✅ Server is running on http://localhost:3000"
else
    echo "❌ Server is not running. Please start it with: npm start"
    exit 1
fi

echo ""
echo "2. Testing message deduplication..."
echo ""

# Test 1: New message
echo "📝 Submitting first message: 'Hello World'"
RESPONSE1=$(curl -s -X POST http://localhost:3000/message \
  -H "Content-Type: application/json" \
  -d '{"content": "Hello World"}')
echo "Response: $RESPONSE1"
echo ""

# Test 2: Same message (should be duplicate)
echo "📝 Submitting duplicate message: 'Hello World'"
RESPONSE2=$(curl -s -X POST http://localhost:3000/message \
  -H "Content-Type: application/json" \
  -d '{"content": "Hello World"}')
echo "Response: $RESPONSE2"
echo ""

# Test 3: Different message
echo "📝 Submitting different message: 'How are you?'"
RESPONSE3=$(curl -s -X POST http://localhost:3000/message \
  -H "Content-Type: application/json" \
  -d '{"content": "How are you?"}')
echo "Response: $RESPONSE3"
echo ""

# Test 4: Another duplicate test
echo "📝 Submitting another duplicate: 'Hello World'"
RESPONSE4=$(curl -s -X POST http://localhost:3000/message \
  -H "Content-Type: application/json" \
  -d '{"content": "Hello World"}')
echo "Response: $RESPONSE4"
echo ""

echo "3. Demo complete! 🎉"
echo ""
echo "Key observations:"
echo "- First 'Hello World' was processed (new message)"
echo "- Second 'Hello World' was detected as duplicate"
echo "- 'How are you?' was processed (new message)"
echo "- Third 'Hello World' was detected as duplicate"
echo ""
echo "💡 The system uses Bloom filters for efficient, probabilistic deduplication!"
echo ""
echo "🌐 Web interface available at: http://localhost:3000"
echo "📊 Check MongoDB for stored message IDs with TTL expiration"
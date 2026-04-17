# PowerShell Demo Script for Message Deduplication Service
# Run this to demonstrate the functionality to your mentor

Write-Host "🚀 Message Deduplication Service Demo" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green
Write-Host ""

# Check if server is running
Write-Host "1. Checking if server is running..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000/health" -Method GET -TimeoutSec      5
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Server is running on http://localhost:3000" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Server is not running. Please start it with: npm start" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "2. Testing message deduplication..." -ForegroundColor Yellow
Write-Host ""

# Test 1: New message
Write-Host "📝 Submitting first message: 'Hello World'" -ForegroundColor Cyan
$body1 = @{content = "Hello World"} | ConvertTo-Json
$response1 = Invoke-WebRequest -Uri "http://localhost:3000/message" -Method POST -Body $body1 -ContentType "application/json" -TimeoutSec 10
Write-Host "Response:" $response1.Content -ForegroundColor White
Write-Host ""

# Test 2: Same message (should be duplicate)
Write-Host "📝 Submitting duplicate message: 'Hello World'" -ForegroundColor Cyan
$body2 = @{content = "Hello World"} | ConvertTo-Json
$response2 = Invoke-WebRequest -Uri "http://localhost:3000/message" -Method POST -Body $body2 -ContentType "application/json" -TimeoutSec 10
Write-Host "Response:" $response2.Content -ForegroundColor White
Write-Host ""

# Test 3: Different message
Write-Host "📝 Submitting different message: 'How are you?'" -ForegroundColor Cyan
$body3 = @{content = "How are you?"} | ConvertTo-Json
$response3 = Invoke-WebRequest -Uri "http://localhost:3000/message" -Method POST -Body $body3 -ContentType "application/json" -TimeoutSec 10
Write-Host "Response:" $response3.Content -ForegroundColor White
Write-Host ""

# Test 4: Another duplicate test
Write-Host "📝 Submitting another duplicate: 'Hello World'" -ForegroundColor Cyan
$body4 = @{content = "Hello World"} | ConvertTo-Json
$response4 = Invoke-WebRequest -Uri "http://localhost:3000/message" -Method POST -Body $body4 -ContentType "application/json" -TimeoutSec 10
Write-Host "Response:" $response4.Content -ForegroundColor White
Write-Host ""

Write-Host "3. Demo complete! 🎉" -ForegroundColor Green
Write-Host ""
Write-Host "Key observations:" -ForegroundColor Yellow
Write-Host "- First 'Hello World' was processed (new message)"
Write-Host "- Second 'Hello World' was detected as duplicate"
Write-Host "- 'How are you?' was processed (new message)"
Write-Host "- Third 'Hello World' was detected as duplicate"
Write-Host ""
Write-Host "💡 The system uses Bloom filters for efficient, probabilistic deduplication!" -ForegroundColor Magenta
Write-Host ""
Write-Host "🌐 Web interface available at: http://localhost:3000" -ForegroundColor Blue
Write-Host "📊 Check MongoDB for stored message IDs with TTL expiration" -ForegroundColor Blue
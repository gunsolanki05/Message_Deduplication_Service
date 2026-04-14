# GitHub Push Script for Message Deduplication Service
# Run this after creating your GitHub repository

# Replace these variables with your actual GitHub info
$GITHUB_USERNAME = "YOUR_GITHUB_USERNAME"
$REPO_NAME = "message-deduplication-service"

# Construct the repository URL
$REPO_URL = "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

Write-Host "🚀 Pushing Message Deduplication Service to GitHub" -ForegroundColor Green
Write-Host "Repository: $REPO_URL" -ForegroundColor Yellow
Write-Host ""

# Add remote origin
Write-Host "1. Adding GitHub remote..." -ForegroundColor Cyan
git remote add origin $REPO_URL

# Rename branch to main (GitHub default)
Write-Host "2. Renaming branch to main..." -ForegroundColor Cyan
git branch -M main

# Push to GitHub
Write-Host "3. Pushing code to GitHub..." -ForegroundColor Cyan
git push -u origin main

Write-Host ""
Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
Write-Host "🌐 View your repository at: https://github.com/$GITHUB_USERNAME/$REPO_NAME" -ForegroundColor Blue
Write-Host ""
Write-Host "📋 Your repository includes:" -ForegroundColor Yellow
Write-Host "  • Complete Node.js deduplication service" -ForegroundColor White
Write-Host "  • Web frontend with HTML/CSS/JS" -ForegroundColor White
Write-Host "  • Demo scripts for presentations" -ForegroundColor White
Write-Host "  • Comprehensive README documentation" -ForegroundColor White
Write-Host "  • Full development history (5 commits)" -ForegroundColor White
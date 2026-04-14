# Deduplication Service

A Node.js service for message deduplication using Express, MongoDB, and Bloom filters.

## Features

- **Express**: Generates unique message IDs and handles API requests
- **MongoDB**: Stores processed IDs with TTL (Time To Live) for automatic expiration
- **Bloom Filters**: Probabilistic duplicate detection with minimal memory overhead
- **Shell Scripts**: Garbage collection utilities
- **Git**: Version control for deduplication policies
- **Unix Timestamps**: Consistent expiration timing
- **Probabilistic Deduplication**: Allows rare false positives to save memory
- **Web Frontend**: Simple HTML interface for testing the service

## Quick Start

1. **Prerequisites**: Ensure MongoDB is running on `mongodb://localhost:27017`

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Start the service**:
   ```bash
   npm start
   ```

4. **Access the web interface**: http://localhost:3000

## Demo Scripts

Run automated demonstrations to showcase the functionality:

**Windows (PowerShell)**:
```powershell
.\demo.ps1
```

**Linux/Mac (Bash)**:
```bash
chmod +x demo.sh
./demo.sh
```

## API Usage

Send a POST request to `/message` with JSON body containing the message content:

```bash
curl -X POST http://localhost:3000/message \
  -H "Content-Type: application/json" \
  -d '{"content": "Your message here"}'
```

Response:
- `{"status": "Processed", "id": "hash"}` - Message processed
- `{"error": "Duplicate message", "id": "hash"}` - Duplicate detected

## Configuration

- `MONGO_URL`: MongoDB connection string (default: mongodb://localhost:27017)
- `PORT`: Server port (default: 3000)
- TTL: Messages expire after 1 hour (configurable in code)

## Garbage Collection

Run the garbage collection script:
```bash
npm run gc
```

This script can be used for additional cleanup if needed, though MongoDB TTL handles automatic expiration.

## Git Integration

The project uses Git to track changes in deduplication policies and code evolution.

## Architecture Overview

- **Bloom Filter**: In-memory probabilistic data structure for fast duplicate checking
- **MongoDB TTL**: Automatic expiration of old message IDs
- **SHA-256 Hashing**: Content-based message ID generation
- **Express Server**: RESTful API with static file serving
- **Web Frontend**: HTML/CSS/JS interface for easy testing
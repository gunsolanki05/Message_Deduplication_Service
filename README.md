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

## Installation

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start MongoDB (ensure it's running on localhost:27017 or set MONGO_URL)

3. Start the service:
   ```bash
   npm start
   ```

For development:
```bash
npm run dev
```

## Usage

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
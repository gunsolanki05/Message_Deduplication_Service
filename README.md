# Message Deduplication Service

A Node.js service for message deduplication using Express, MongoDB, and Bloom filters.

[![Node.js](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-6+-blue)](https://www.mongodb.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

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

### Prerequisites
- Node.js 18+
- MongoDB 6+
- Git

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/message-deduplication-service.git
   cd message-deduplication-service
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Start MongoDB** (ensure it's running on localhost:27017 or set MONGO_URL)

4. **Start the service**:
   ```bash
   npm start
   ```

5. **Access the web interface**: http://localhost:3000

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

## Deployment

### Local Development
```bash
npm run dev  # Runs with nodemon for auto-restart
```

### Production
```bash
npm start  # Production server
```

### Environment Variables
- `MONGO_URL`: MongoDB connection string (default: mongodb://localhost:27017)
- `PORT`: Server port (default: 3000)

## Project Structure

```
message-deduplication-service/
├── app.js                 # Main Express server
├── package.json           # Dependencies and scripts
├── README.md              # Documentation
├── demo.ps1               # PowerShell demo script
├── demo.sh                # Bash demo script
├── push_to_github.ps1     # GitHub deployment script
├── .gitignore             # Git ignore rules
├── public/                # Frontend assets
│   ├── index.html         # Web interface
│   ├── style.css          # CSS styling
│   └── app.js             # Frontend JavaScript
└── scripts/               # Utility scripts
    └── garbage_collect.sh # Manual cleanup script
```

## Architecture

- **Bloom Filter**: In-memory probabilistic data structure for fast duplicate checking
- **MongoDB TTL**: Automatic expiration of old message IDs (1 hour default)
- **SHA-256 Hashing**: Content-based message ID generation
- **Express Server**: RESTful API with static file serving
- **Web Frontend**: HTML/CSS/JS interface for easy testing

## API Endpoints

### Health Check
```http
GET /health
```
Response: `{"status": "OK"}`

### Process Message
```http
POST /message
Content-Type: application/json

{
  "content": "Your message here"
}
```

**Success Response:**
```json
{
  "status": "Processed",
  "id": "sha256-hash-of-message"
}
```

**Duplicate Response:**
```json
{
  "error": "Duplicate message",
  "id": "sha256-hash-of-message"
}
```

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

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Git Integration

The project uses Git to track changes in deduplication policies and code evolution.
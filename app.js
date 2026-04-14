const express = require("express");
const { MongoClient } = require("mongodb");
const BloomFilter = require("bloomfilter").BloomFilter;
const crypto = require("crypto");

const app = express();
app.use(express.json());

// MongoDB connection
const mongoUrl = process.env.MONGO_URL || "mongodb://localhost:27017";
const dbName = "dedupdb";
const collectionName = "processed_ids";
let db;

// Bloom filter
const bloom = new BloomFilter(1024 * 1024 * 8, 16); // 1MB, 16 hashes

// Connect to MongoDB
async function connectDB() {
  const client = new MongoClient(mongoUrl);
  await client.connect();
  db = client.db(dbName);
  const collection = db.collection(collectionName);
  // Create TTL index on timestamp, expire after 3600 seconds (1 hour)
  await collection.createIndex({ timestamp: 1 }, { expireAfterSeconds: 3600 });
  console.log("Connected to MongoDB");
}

// Generate ID from message content
function generateId(content) {
  return crypto.createHash("sha256").update(content).digest("hex");
}

// Endpoint to process message
app.post("/message", async (req, res) => {
  const { content } = req.body;
  if (!content) {
    return res.status(400).json({ error: "Content required" });
  }

  const id = generateId(content);
  const now = Math.floor(Date.now() / 1000); // Unix timestamp

  // Check bloom filter
  if (bloom.test(id)) {
    // Possible duplicate, check DB
    const existing = await db.collection(collectionName).findOne({ id });
    if (existing) {
      return res.status(409).json({ error: "Duplicate message", id });
    }
  }

  // Not duplicate, process
  bloom.add(id);
  await db.collection(collectionName).insertOne({ id, timestamp: now });
  res.json({ status: "Processed", id });
});

// Health check
app.get("/health", (req, res) => {
  res.json({ status: "OK" });
});

const port = process.env.PORT || 3000;

async function start() {
  await connectDB();
  app.listen(port, () => {
    console.log(`Deduplication service listening on port ${port}`);
  });
}

start().catch(console.error);

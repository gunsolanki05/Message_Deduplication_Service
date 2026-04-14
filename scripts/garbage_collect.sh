#!/bin/bash

# Garbage collection script for deduplication service
# This script manually removes expired IDs from MongoDB
# Note: MongoDB TTL should handle this automatically

MONGO_URL=${MONGO_URL:-mongodb://localhost:27017}
DB_NAME=dedupdb
COLLECTION=processed_ids

echo "Running garbage collection..."

# Calculate cutoff timestamp (1 hour ago)
CUTOFF=$(($(date +%s) - 3600))

# Remove old entries
mongosh "$MONGO_URL/$DB_NAME" --eval "
db.$COLLECTION.deleteMany({timestamp: {\$lt: $CUTOFF}})
"

echo "Garbage collection completed."
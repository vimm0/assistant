#!/bin/bash

# POC Demo Script for Solo Dev Multi-Agent Set

echo "🚀 Starting Solo Dev Multi-Agent POC Demo..."

# 1. Ask Architect for a plan
echo "🏗️  Asking Architect for a design..."
docker-compose run --rm openclaw-cli agent --agent architect --message "Design a simple Node.js script that fetches Bitcoin price from a public API." --local

# Note: In a real scenario, you would capture the output and pass it to the next agent.
# For this POC, we are just demonstrating the calls.

echo "💻 Asking Coder to implement..."
docker-compose run --rm openclaw-cli agent --agent coder --message "Write a Node.js script called 'price.js' that fetches BTC/USD from Coindesk API based on Architect's advice." --local

echo "🔍 Asking Reviewer to check..."
docker-compose run --rm openclaw-cli agent --agent reviewer --message "Review 'price.js' for error handling and performance." --local

echo "📚 Asking Docs to document..."
docker-compose run --rm openclaw-cli agent --agent docs --message "Create a short usage guide for 'price.js'." --local

echo "✅ POC Demo Calls Completed!"

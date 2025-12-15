#!/bin/bash
echo "=== Custom installation ==="
cd frontend && npm install
cd ../backend && npm install
cd ../frontend && npm run build
echo "=== Installation complete ==="
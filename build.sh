#!/bin/bash
echo "=== Starting build process ==="

# Устанавливаем зависимости
echo "Installing frontend dependencies..."
cd frontend && npm install --include=dev
echo "Installing backend dependencies..."
cd ../backend && npm install

# Собираем фронтенд
echo "Building frontend..."
cd ../frontend && npm run build

echo "=== Build complete ==="
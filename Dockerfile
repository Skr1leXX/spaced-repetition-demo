FROM node:18-alpine

WORKDIR /app

COPY install-deps.sh .
RUN chmod +x install-deps.sh && ./install-deps.sh

# 1. Копируем и устанавливаем зависимости фронтенда
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install

# 2. Копируем и устанавливаем зависимости бэкенда (КЛЮЧЕВОЕ ИЗМЕНЕНИЕ!)
COPY backend/package*.json ./backend/
RUN cd backend && npm install

# 3. Копируем весь исходный код
COPY . .

# 4. Собираем фронтенд
RUN cd frontend && npm run build

# 5. Запускаем приложение
EXPOSE 3000
CMD ["node", "backend/server.js"]
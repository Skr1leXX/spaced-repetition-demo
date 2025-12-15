FROM node:18-alpine

WORKDIR /app

# 1. Устанавливаем зависимости для фронтенда
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install

# 2. Устанавливаем зависимости для бэкенда
COPY backend/package*.json ./backend/
RUN cd backend && npm install

# 3. Копируем ВЕСЬ исходный код проекта
COPY . .

# 4. Собираем фронтенд
RUN cd frontend && npm run build

# 5. Запускаем сервер
EXPOSE 3000
CMD ["node", "backend/server.js"]
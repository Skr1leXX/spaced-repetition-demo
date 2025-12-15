FROM node:18-alpine

# Устанавливаем глобально TypeScript и Vite ОТ ИМЕНИ ROOT
RUN npm install -g typescript@5 vite@5

WORKDIR /app

# 1. Устанавливаем зависимости фронтенда и сразу собираем
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install --loglevel=error && npm run build

# 2. Устанавливаем зависимости бэкенда
COPY backend/package*.json ./backend/
RUN cd backend && npm install --loglevel=error --only=production

# 3. Копируем остальной исходный код (уже без папки frontend/src, т.к. она собрана)
COPY . .

# 4. Запускаем приложение
EXPOSE 3000
CMD ["node", "backend/server.js"]
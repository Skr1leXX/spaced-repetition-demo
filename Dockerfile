# Используем официальный образ Node.js
FROM node:18-alpine

# Создаём непривилегированного пользователя для безопасности
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Устанавливаем рабочую директорию и меняем владельца
WORKDIR /app
RUN chown -R nodejs:nodejs /app

# Переключаемся на непривилегированного пользователя
USER nodejs

# 1. Копируем package.json и устанавливаем зависимости для фронтенда
COPY --chown=nodejs:nodejs frontend/package*.json ./frontend/
RUN cd frontend && npm install --loglevel=error

# 2. Копируем package.json и устанавливаем зависимости для бэкенда
COPY --chown=nodejs:nodejs backend/package*.json ./backend/
RUN cd backend && npm install --loglevel=error --only=production

# 3. Копируем ВЕСЬ исходный код
COPY --chown=nodejs:nodejs . .

# 4. Собираем фронтенд, используя полный путь к локальным бинарникам
RUN cd frontend && ./node_modules/.bin/tsc && ./node_modules/.bin/vite build

# 5. Запускаем приложение
EXPOSE 3000
CMD ["node", "backend/server.js"]
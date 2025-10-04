FROM nginx:alpine

# Копируем конфигурацию nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Создаем директории для хранения версий
RUN mkdir -p /home/games/damnslonik/builds

# Копируем веб-интерфейс для управления версиями
COPY web-interface/ /var/www/html/

# Устанавливаем права доступа
RUN chown -R nginx:nginx /var/www/

# Открываем порт 80
EXPOSE 80

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]

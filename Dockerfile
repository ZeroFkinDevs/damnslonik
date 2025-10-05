FROM nginx:alpine

# Устанавливаем зависимости для сборки модуля
RUN apk add --no-cache \
    git \
    gcc \
    g++ \
    make \
    cmake \
    pkgconfig \
    zlib-dev \
    pcre-dev \
    openssl-dev

# Клонируем ngx_brotli и собираем модули
RUN cd /tmp && \
    git clone --recurse-submodules -j8 https://github.com/google/ngx_brotli && \
    cd ngx_brotli/deps/brotli && \
    mkdir out && cd out && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DCMAKE_C_FLAGS="-Ofast -m64 -march=native -mtune=native -flto -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections" -DCMAKE_CXX_FLAGS="-Ofast -m64 -march=native -mtune=native -flto -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections" -DCMAKE_INSTALL_PREFIX=./installed .. && \
    cmake --build . --config Release --target brotlienc && \
    cd /tmp && \
    wget http://nginx.org/download/nginx-$(nginx -v 2>&1 | cut -d'/' -f2).tar.gz && \
    tar -xzf nginx-*.tar.gz && \
    cd nginx-* && \
    ./configure --with-compat --add-dynamic-module=/tmp/ngx_brotli && \
    make modules && \
    mkdir -p /usr/lib/nginx/modules && \
    cp objs/ngx_http_brotli_filter_module.so /usr/lib/nginx/modules/ && \
    cp objs/ngx_http_brotli_static_module.so /usr/lib/nginx/modules/ && \
    cd /tmp && \
    rm -rf nginx-* ngx_brotli

# Очищаем временные файлы и зависимости сборки
RUN apk del git gcc g++ make cmake pkgconfig zlib-dev pcre-dev openssl-dev

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

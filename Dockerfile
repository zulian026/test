# Gunakan image resmi PHP dengan ekstensi yang dibutuhkan
FROM php:8.2-cli

# Install ekstensi dan dependensi yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    curl \
    zip \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set direktori kerja di dalam container
WORKDIR /app

# Copy semua file ke container
COPY . .

# Install dependensi Laravel
RUN composer install --no-dev --optimize-autoloader

# Generate APP_KEY (opsional, bisa juga dari env)
# RUN php artisan key:generate

# Expose port yang digunakan oleh artisan serve
EXPOSE 8000

# Jalankan Laravel menggunakan artisan serve
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

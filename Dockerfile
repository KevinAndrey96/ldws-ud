FROM mileschou/phalcon:7.4-apache

# Install PDO MySQL
RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Configure Apache DocumentRoot to public/
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN sed -i '/<Directory ${APACHE_DOCUMENT_ROOT}>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

WORKDIR /var/www/html

COPY . /var/www/html/

# Permissions for Volt cache and logs
RUN mkdir -p /var/www/html/cache/volt /var/www/html/app/logs \
    && chown -R www-data:www-data /var/www/html/cache /var/www/html/app/logs \
    && chmod -R 777 /var/www/html/cache

EXPOSE 80

CMD ["apache2-foreground"]

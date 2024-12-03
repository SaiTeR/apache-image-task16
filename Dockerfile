# FROM php:7.4-apache

# COPY info.php /var/www/html/info.php

# COPY ports.conf /etc/apache2/ports.conf

# COPY sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

# EXPOSE ${PORT}

# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# CMD ["/entrypoint.sh"]



FROM php:7.4-apache

# Установка необходимых пакетов, включая gettext
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*

# Копируем файлы
COPY info.php /var/www/html/info.php
COPY index.html /var/www/html/index.html
COPY ports.conf /etc/apache2/ports.conf
COPY sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/local/bin/entrypoint.sh

# Указываем порт
EXPOSE ${PORT}

# Устанавливаем entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Команда запуска Apache
CMD ["apache2-foreground"]

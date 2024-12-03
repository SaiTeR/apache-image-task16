#!/bin/sh
set -e

# Подставляем значение переменной окружения
sed -i "s/\${PORT}/$PORT/g" /etc/apache2/sites-available/000-default.conf
cat /etc/apache2/sites-available/000-default.conf

envsubst '${PORT}' < /etc/apache2/ports.conf > /tmp/ports.conf
mv /tmp/ports.conf /etc/apache2/ports.conf

# Запускаем Apache
exec "$@"


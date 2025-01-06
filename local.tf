locals {
  custom_data_wp = <<CUSTOM_DATA
#!/bin/bash

# Update package index and install required packages
sudo apt update
sudo apt install -y apache2 \
                   ghostscript \
                   libapache2-mod-php \
                   php \
                   php-bcmath \
                   php-curl \
                   php-imagick \
                   php-intl \
                   php-json \
                   php-mbstring \
                   php-mysql \
                   php-xml \
                   php-zip

# Create the directory for the website
sudo mkdir -p /srv/www
sudo chown www-data:www-data /srv/www

# Download and extract WordPress
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

# Correct permissions for the WordPress directory
sudo chown -R www-data:www-data /srv/www/wordpress

# Create Apache configuration for WordPress
echo "<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/wordpress.conf

DB_HOSTNAME='10.0.2.4'
DB_NAME='ardb'
DB_USERNAME='abdul1891'
DB_PASSWORD='Ar@1891Secure'

# Configure WordPress
sudo cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sudo sed -i "s/database_name_here/$DB_NAME/" /srv/www/wordpress/wp-config.php
sudo sed -i "s/username_here/$DB_USERNAME/" /srv/www/wordpress/wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/" /srv/www/wordpress/wp-config.php
sudo sed -i "s/localhost/$DB_HOSTNAME/" /srv/www/wordpress/wp-config.php

# Enable the new site and required modules
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default

# Reload Apache to apply changes
sudo systemctl reload apache2
sudo systemctl restart apache2
sudo systemctl enable apache2

CUSTOM_DATA

  custom_data_db = <<CUSTOM_DATA
#!/bin/bash

# Update package index and install MySQL server
sudo apt-get update
sudo apt-get install -y mysql-server

# Start MySQL service and enable it to start on boot
sudo systemctl start mysql
sudo systemctl enable mysql

# Run MySQL commands to set up database and user
sudo mysql -u root <<EOF
CREATE DATABASE ardb;
CREATE USER 'abdul1891'@'%' IDENTIFIED BY 'Ar@1891Secure';
GRANT ALL PRIVILEGES ON ardb.* TO 'abdul1891'@'%';
FLUSH PRIVILEGES;
EOF

# Change bind address in MySQL config
sudo sed -i "s/bind-address.*$/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL service to apply changes
sudo systemctl restart mysql
sudo systemctl enable mysql


CUSTOM_DATA
}

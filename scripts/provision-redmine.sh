#!/bin/sh

ENV=$1

if [[ ${ENV} == "production" ]]; then
    mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS redmine CHARACTER SET utf8;";
else
    mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS redmine_development CHARACTER SET utf8;";
fi

cd /home/vagrant/project
git clone https://github.com/redmine/redmine.git
cd redmine
rbenv local 2.2.2
gem install bundler
rbenv rehash
cp config/database.yml.example config/database.yml

if [[ ${ENV} == "production" ]]; then
    bundle install --without development test rmagick
    bundle exec rake generate_secret_token
    RAILS_ENV=production bundle exec rake db:migrate
    RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:load_default_data
else
    bundle install
    bundle exec rake generate_secret_token
    bundle exec rake db:migrate
    REDMINE_LANG=en bundle exec rake redmine:load_default_data
fi

sudo tee /etc/apache2/sites-available/redmine.conf <<__END__
   <VirtualHost *:80>
      ServerName redmine.dev
      # !!! Be sure to point DocumentRoot to 'public'!
      DocumentRoot /home/vagrant/project/redmine/public
      RailsEnv ${HOSTNAME}
      <Directory /home/vagrant/project/redmine/public>
         # This relaxes Apache security settings.
         AllowOverride all
         # MultiViews must be turned off.
         Options -MultiViews
         # Uncomment this if you're on Apache >= 2.4:
         Require all granted
      </Directory>
   </VirtualHost>
__END__

sudo a2ensite redmine
sudo service apache2 reload

echo 'cd /home/vagrant/project/redmine >& /dev/null' >> /home/vagrant/.bash_profile

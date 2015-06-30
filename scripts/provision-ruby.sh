#!/bin/sh

git clone https://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
rbenv install -v 2.1.6

rbenv global 2.1.6
rbenv rehash

gem install passenger
rbenv rehash

passenger-install-apache2-module --auto

sudo tee /etc/apache2/mods-available/passenger.load <<__END__
   LoadModule passenger_module /home/vagrant/.rbenv/versions/2.1.6/lib/ruby/gems/2.1.0/gems/passenger-5.0.11/buildout/apache2/mod_passenger.so
   <IfModule mod_passenger.c>
     PassengerRoot /home/vagrant/.rbenv/versions/2.1.6/lib/ruby/gems/2.1.0/gems/passenger-5.0.11
     PassengerDefaultRuby /home/vagrant/.rbenv/versions/2.1.6/bin/ruby
   </IfModule>
__END__

sudo a2enmod passenger

sudo service apache2 restart

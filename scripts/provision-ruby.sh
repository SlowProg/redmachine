#!/bin/sh

git clone https://github.com/rbenv/rbenv.git /home/vagrant/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

git clone https://github.com/rbenv/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
rbenv install -v 2.2.2

rbenv global 2.2.2
rbenv rehash

gem install passenger -v 5.0.29
rbenv rehash

passenger-install-apache2-module --auto

sudo tee /etc/apache2/mods-available/passenger.load <<__END__
   LoadModule passenger_module /home/vagrant/.rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/passenger-5.0.29/buildout/apache2/mod_passenger.so
   <IfModule mod_passenger.c>
     PassengerRoot /home/vagrant/.rbenv/versions/2.2.2/lib/ruby/gems/2.2.0/gems/passenger-5.0.29
     PassengerDefaultRuby /home/vagrant/.rbenv/versions/2.2.2/bin/ruby
   </IfModule>
__END__

sudo a2enmod passenger

sudo service apache2 restart

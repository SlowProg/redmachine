# Redmine Vagrant Machine

Notes:
 * Ubuntu base box.
 * Uses very basic shell scripts for provisioning.
 * Uses apt-get to provision the OS with apache, mysql, and some other required packages.
 * Uses rbenv and ruby-build to install ruby 2.1 for the vagrant user.
 * Builds Phusion Passenger from source. Installs apache config.
 * Install redmine from git checkout into vagrant home dir.
 * Creates apache virtual host for redmine. Uses redmine.dev as ServerName.

## Install

 1. vagrant up
 2. Edit /etc/hosts and point redmine.dev to 192.168.33.15 

## TODO

* Use a more reliable provisioner (ansible, chef,...)
* Deploy redmine using capistrano.

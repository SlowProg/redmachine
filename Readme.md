# Redmine Vagrant Machine

Notes:
 * Ubuntu base box.
 * Uses very basic shell scripts for provisioning.
 * Uses apt-get to provision the OS with apache, mysql, and some other required packages.
 * Uses rbenv and ruby-build to install ruby for the vagrant user.
 * Builds Phusion Passenger from source. Installs apache config.
 * Install redmine from git checkout into vagrant home dir.
 * Creates apache virtual host for redmine. Uses redmine.dev as ServerName.

## Versions

 * Redmine 3.3.0
 * Ruby 2.2.2
 * Rails 4.2.6

## Install

 1. vagrant up
 2. Edit /etc/hosts and point redmine.dev to 192.168.33.15
 3. Go to redmine.dev and login admin:admin

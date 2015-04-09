#!/bin/sh

cd /srv/www/asumibot
bundle exec rake asumistream:reply RAILS_ENV=production

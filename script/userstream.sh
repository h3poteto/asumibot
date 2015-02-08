#!/bin/sh

cd /home/akira/projects/asumibot/script/
bundle exec rake asumistream:reply RAILS_ENV=production

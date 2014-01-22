#!/bin/sh

cd /home/akira/projects/asumibot/script/
bundle exec rake userstream:reply RAILS_ENV=production

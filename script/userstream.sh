#!/bin/sh
cd $(dirname ${BASH_SOURCE:-$0})
cd ../
bundle exec rake asumistream:reply RAILS_ENV=production

#!/bin/sh
cd $(dirname ${BASH_SOURCE:-$0})
cd ../
$HOME/.rbenv/shims/bundle exec rake asumistream:reply RAILS_ENV=production & echo $! > tmp/pids/userstream.pid

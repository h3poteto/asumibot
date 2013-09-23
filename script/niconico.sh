#!/bin/sh
cd /home/akira/projects/asumibot/
rake niconico:clear RAILS_ENV=production
rake niconico:popular RAILS_ENV=production
rake niconico:new RAILS_ENV=production

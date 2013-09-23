#!/bin/sh
cd /home/akira/projects/asumibot/
rake youtube:clear RAILS_ENV=production
rake youtube:popular RAILS_ENV=production
rake youtube:new RAILS_ENV=production
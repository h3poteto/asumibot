# coding: utf-8

ActiveRecord::Base.connection.execute("TRUNCATE admins")
Admin.create([{:email => ENV["NICONICO_ID"], :password => ENV["NICONICO_PASSWORD"], :password_confirmation => ENV["NICONICO_PASSWORD"]}])

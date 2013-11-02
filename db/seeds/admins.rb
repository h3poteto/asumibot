# coding: utf-8

Admin.create([
              {:email => Settings['nicovideo']['mail_address'], :password => Settings['nicovideo']['password'], :password_confirmation => Settings['nicovideo']['password']}
])

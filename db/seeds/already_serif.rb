# coding: utf-8

ActiveRecord::Base.connection.execute("TRUNCATE already_serifs")
AlreadySerif.create
([
   {:word => "もう登録されてるんだ" },
   {:word => "ごめん、もう登録されてた"},
   {:word => "もう登録されてた！"},
   {:word => "もう登録されてるんだ！"}
])

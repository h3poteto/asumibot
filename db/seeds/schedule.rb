# coding: utf-8

ActiveRecord::Base.connection.execute("TRUNCATE schedules")
Schedule.create(task: "twitter_ad", time: Time.now )

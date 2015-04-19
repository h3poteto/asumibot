# -*- coding: utf-8 -*-
# ワーカーの数
worker_processes 2

# ソケット経由で通信する
listen File.expand_path('tmp/sockets/unicorn.sock', ENV['RAILS_ROOT'])
pid File.expand_path('tmp/pids/unicorn.pid', ENV['RAILS_ROOT'])

# ログ
stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])

# ダウンタイムなくす
preload_app true

timeout 45

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("WINCH", File.read(old_pid).to_i)
      Thread.new {
        sleep 30
        Process.kill("KILL", File.read(old_pid).to_i)
      }
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

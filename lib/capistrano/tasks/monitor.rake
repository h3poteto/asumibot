namespace :load do
  task :defaults do
    set :monitor_pid, -> { File.join(current_path, "tmp", "pids", "monitor.pid")}
    set :monitor_roles, -> { :app }
    set :monitor_restart_sleep_time, 3
  end
end

namespace :monitor do
  desc "Stop monitor script"
  task :stop do
    on roles(fetch(:monitor_roles)) do
      within current_path do
        if test("[ -e #{fetch(:monitor_pid)} ]")
          if test("kill -0 #{pid}")
            info "stopping monitor script..."
            execute :kill, pid
          else
            info "cleaning up dead monitor pid..."
            execute :rm, fetch(:monitor_pid)
          end
        else
          info "monitor is not running."
        end
      end
    end
  end

  desc "Start monitor script"
  task :start do
    on roles(fetch(:monitor_roles)) do
      within current_path do
        if test("[ -e #{fetch(:monitor_pid)} ] && kill -0 #{pid}")
          info "monitor is running..."
        else
          execute :sh, "./script/monitor.sh &"
        end
      end
    end
  end

  desc "Restart monitor script"
  task :restart do
    invoke "monitor:stop"
    execute :sleep, fetch(:monitor_restart_sleep_time)
    invoke "monitor:start"
  end
end

def pid
  "`cat #{fetch(:monitor_pid)}"
end

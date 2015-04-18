namespace :load do
  task :defaults do
    set :monitor_pid, -> { File.join(current_path, "tmp", "pids", "monitor.pid")}
    set :userstream_pid, -> { File.joing(current_path, "tmp", "pids", "userstream.pid")}
    set :monitor_roles, -> { :app }
  end
end

namespace :monitor do
  desc "Stop monitor script"
  task :stop do
    on roles(fetch(:monitor_roles)) do
      within current_path do
        if test("[ -e #{fetch(:monitor_pid)} ]")
          if test("kill -0 #{monitor_pid}")
            info "stopping monitor script..."
            execute :kill, monitor_pid
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


  desc "Stop userstream task"
  task :stop_stream do
    within current_path do
      if test("[ e #{fetch(:userstream_pid)}]")
        if test("kill -0 #{userstream_pid}")
          info "stopping userstream..."
          execute :kill, userstream_pid
        else
          info "cleaning up dead userstream pid..."
          execute :rm, fetch(:userstream_pid)
        end
      else
        info "userstream is not running."
      end
    end
  end

  desc "Start monitor script"
  task :start do
    on roles(fetch(:monitor_roles)) do
      within current_path do
        if test("[ -e #{fetch(:monitor_pid)} ] && kill -0 #{monitor_pid}")
          info "monitor is running..."
        else
          execute "(cd #{release_path} && nohup sh ./script/monitor.sh &) && sleep 1"
        end
      end
    end
  end

  desc "Restart monitor script"
  task :restart do
    invoke "monitor:stop"
    invoke "monitor:stop_stream"
    invoke "monitor:start"
  end
end

def monitor_pid
  "`cat #{fetch(:monitor_pid)}`"
end

def userstream_pid
  "`cat #{fetch(:userstream_pid)}`"
end

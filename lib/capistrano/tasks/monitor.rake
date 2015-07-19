namespace :load do
  task :defaults do
    set :userstream_pid, -> { File.join(current_path, "tmp", "pids", "userstream.pid")}
    set :monitor_roles, -> { :app }
  end
end

namespace :monitor do
  desc "Stop userstream task"
  task :stop_stream do
    on roles(fetch(:monitor_roles)) do
      within current_path do
        if test("[ -e #{fetch(:userstream_pid)} ]")
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
  end
end

def userstream_pid
  "`cat #{fetch(:userstream_pid)}`"
end

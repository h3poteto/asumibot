namespace :cache do

  desc "delete patients"
  task :delete_patients => :environment do
    cache_file = "#{Rails.root.to_s}/public/cache/patients.html"
    if File.exist?(cache_file)
      File.unlink cache_file
    end

    open(Rails.application.routes.url_helpers.patients_url, {:read_timeout => 180})
  end
end

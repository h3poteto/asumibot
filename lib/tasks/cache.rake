namespace :cache do
  desc "delete patients"
  task :delete_patients => :environment do
    File.unlink "#{Rails.root.to_s}/public/cache/patients.html"
  end
end

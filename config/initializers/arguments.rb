Settings=YAML.load_file("#{Rails.root}/config/settings.yml")[Rails.env]
Settings=YAML.load_file("#{Rails.root}/config/settings.local.yml")[Rails.env]

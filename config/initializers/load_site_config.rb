DEPLOYR = YAML.load_file("#{::Rails.root.to_s}/config/deployr.yml") if File.exists? "#{::Rails.root.to_s}/config/deployr.yml"

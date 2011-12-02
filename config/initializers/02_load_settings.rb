raw_config = File.read(Rails.root.to_s + "/config/settings.yml")
SETTINGS = YAML.load(raw_config)[Rails.env].symbolize_keys

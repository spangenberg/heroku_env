module HerokuEnv
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        heroku_config = `heroku config --shell`.split("\n").inject({}) do |config, item|
          key, value = item.split("=", 2)
          config[key] = value
          config
        end
        custom_config = YAML.load_file(File.join(::Rails.root, "config", "heroku_env.yml"))[::Rails.env] rescue {}
        config = heroku_config.merge(custom_config)
        config.each do |key, value|
          ENV[key] = value if !ENV.has_key?(key) && key != "BUNDLE_WITHOUT"
        end
      end

    end
  end
end

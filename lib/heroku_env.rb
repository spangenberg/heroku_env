module HerokuEnv
  module Rails
    class Railtie < ::Rails::Railtie

      rake_tasks do
        namespace :heroku_env do
          namespace :config do
            desc "Create heroku_env.yml from heroku config"
            task :create => :environment do
              heroku_config = `heroku config --shell`.split("\n").inject({}) do |config, item|
                key, value = item.split(/\s+\=\>\s+/, 2)
                config[key] = value
                config
              end
              heroku_env = { :development => heroku_config.clone, :test => heroku_config.clone }
              puts heroku_env.to_yaml
            end
          end
        end
      end

      unless ENV.include?('HEROKU_UPID')
        config.before_configuration do
          if heroku_config = YAML.load_file(File.join(::Rails.root, "config", "heroku_env.yml"))[::Rails.env] rescue nil || {}
            heroku_config.each do |key, value|
              ENV[key] = value if !ENV.has_key?(key) && !["BUNDLE_WITHOUT", "RACK_ENV"].include?(key)
            end
          end
        end
      end

    end
  end
end

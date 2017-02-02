require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FileSharing
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # permet de charger toutes les classes présentes dans /lib
    # attention config écrasée si un environnement spécifie des apps particulières. 
    config.autoload_paths  = %W(#{config.root}/lib)
    
    config.before_configuration do
  		env_file = File.join(Rails.root, 'config', 'local_env.yml')
  		YAML.load(File.open(env_file)).each do |key, value|
    		ENV[key.to_s] = value
  		end if File.exists?(env_file)
	end
  end
end
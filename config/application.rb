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

    # permet de charger toutes les classes présentent dans /lib
    # attention config écrasée si un environnement spécifie des apps particulières. 
    config.autoload_paths  = %W(#{config.root}/lib)

  end
end
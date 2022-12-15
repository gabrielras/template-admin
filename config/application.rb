require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CartorioErp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.encoding = 'utf-8'
    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :utc
    config.i18n.default_locale = 'pt-BR'

    # config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    # Load paths
    # config.autoload_paths += Dir["#{config.root}/app/api*"]
    config.autoload_paths += %W[#{config.root}/lib #{config.root}/lib/**]
    config.autoload_paths += %W[#{config.root}/queries #{config.root}/queries/**]
    config.autoload_paths += Dir[Rails.root.join('app', 'policies', '*.rb')]
    config.autoload_paths += Dir[Rails.root.join('config', 'validators', '**', '*.{rb}')]

    config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :forbidden

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # sidekiq
    config.active_job.queue_adapter = :sidekiq
    # observers
    config.active_record.observers = Dir[Rails.root.join('app', 'observers', '*.rb')]
                                     .collect { |f| File.basename(f, '.rb').to_sym }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.action_dispatch.default_headers = { 'X-XSS-Protection' => '0' }
  end
end

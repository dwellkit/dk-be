Rails.application.configure do
  #S3 FOR PAPERCLIP
  config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['S3_BUCKET_NAME'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
}
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "dwellingkit-api.herokuapp.com/",
    :user_name            => "dwellingk@gmail.com",
    :password             => "DwellingKit2015",
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # ENV["REDISTOGO_URL"] = 'redis://username:password@my.host:6389'
  # ENV["REDISTOGO_URL"] = redis://fbabc14c6f7d472ee6255764ebc1f8ac@cobia.redistogo.com:9221
  ENV["REDISTOGO_URL"] = 'redis://redistogo:fbabc14c6f7d472ee6255764ebc1f8ac@cobia.redistogo.com:9221/'
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end

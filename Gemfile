source 'https://rubygems.org'

ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgres for heroku
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#require httparty for zillow
gem 'httparty'

#sucker punch for a heroku workaround
gem 'sucker_punch', '~> 1.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#devise for users
gem 'devise'

#parse them street addresses
gem 'StreetAddress', :require => "street_address"

#omni auth required for devise token auth
gem 'omniauth'

#paperclip for attachments
gem 'paperclip'

#aws for paperclip
gem 'aws-sdk', '< 2.0'

#figaro for env vars
gem 'figaro'

# Use sidekiq for bg jobs
gem 'sidekiq'

gem 'redis'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  #let stephen test locally
  gem 'proxylocal'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  #pry for prying
  gem 'pry'

  #pry rails for rails-prying
  gem 'pry-rails'

  #better errors for better errors
  gem 'better_errors'

  # visualize associations
  gem 'rails-erd'
end

group :production do
  # allow front end to hit us
  gem 'rack-cors'

  # heroku likes this
  gem 'rails_12factor'
end


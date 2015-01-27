source 'https://rubygems.org'

gem 'bundler', '>= 1.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :production do
  gem 'exception_notification'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'bullet'
  gem 'did_you_mean'
end

group :test do
  gem 'simplecov', require: false
  gem 'factory_girl_rails'
  gem 'capybara'
  #gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'database_rewinder'
  gem 'faker'
  gem 'coveralls', require: false
  gem 'webmock'
end

gem 'devise', github: 'plataformatec/devise'
gem 'devise-i18n'
gem 'slim-rails'
gem 'bootstrap-sass'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'redcarpet'
gem 'jquery-turbolinks'
gem 'nokogiri'
gem 'nprogress-rails'
gem 'paperclip'
gem 'rails-i18n'
gem 'rails_config'
gem 'annotate'
gem 'paper_trail'
gem 'diffy'
gem 'metainspector'
gem 'dotenv-rails'
gem 'omniauth-github'
gem 'responders'

source 'https://rails-assets.org' do
  gem 'rails-assets-jquery-autosize'
  gem 'rails-assets-google-code-prettify'
  gem 'rails-assets-underscore'
  gem 'rails-assets-dropzone'
  gem 'rails-assets-mousetrap'
end


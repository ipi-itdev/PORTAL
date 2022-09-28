source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end



# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '~> 5.1.6', '>= 5.1.6.1'
gem 'rails', '~> 5.2.3'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
#gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#used to connect in mssql
gem 'tiny_tds', '~> 2.1', '>= 2.1.2'
#gem 'activerecord-sqlserver-adapter', '~> 5.1', '>= 5.1.6'
gem 'activerecord-sqlserver-adapter', '~> 5.2'

#bootstrap
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '>= 3.2'
gem 'jquery-rails'

#devise / bootstrap
gem 'devise'
gem 'bootstrap_form'

#pdf generator
gem 'prawn'
gem 'prawn-table', '~> 0.2.2'

#email validator
gem "valid_email2"

#captcha feature
gem "recaptcha", require: "recaptcha/rails"
gem 'certified'

#fontawesome icons
gem "font-awesome-rails"

#saving image using carrierwave
gem 'dragonfly', '~> 1.2.0'
gem 'carrierwave'
gem 'mini_magick', '~> 4.9', '>= 4.9.3'

#rich text editor
gem 'trix-rails', require: 'trix'
gem 'popper_js', '~> 1.14', '>= 1.14.5'

gem 'pluck_to_hash', '~> 1.0', '>= 1.0.2'

#ckeditor for text field
gem 'paperclip'
gem 'ckeditor', github: 'galetahub/ckeditor'

gem 'email_validator'

#html to pdf
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary' 
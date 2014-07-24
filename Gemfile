source 'http://rubygems.org'
ruby '1.9.3'  # added this to make heroku identify the version of ruby
gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'twitter' # to support the usage of Twitter API
gem 'octokit' # to support the usage of Github APT
gem 'gems'    # to support the usage of RubyGems API

# Below mentioned gems are used for PDF generation
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'

  # below gems are used for twitter-bootstrap to build the UI for the application
  gem 'therubyracer'
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'
gem 'rails_12factor', group: :production # used to support heroku deployment

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

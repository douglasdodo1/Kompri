source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "pg", "~> 1.5.9"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "rack-cors"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec", "~> 3.13"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false
end

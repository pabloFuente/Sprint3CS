require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'capybara/rspec'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end

Capybara.default_driver = :poltergeist

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new(args: %w[headless window-size=1366,768])
    Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
  end

  Capybara.register_driver(:chrome) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(args: %w[window-size=1366,768])
    Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
  end

  ENV['HEADFULL'] ? driven_by(:chrome) : driven_by(:headless_chrome)
end

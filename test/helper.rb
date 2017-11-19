require 'simplecov'
require 'minitest/autorun'

SimpleCov.start 'rails' do
  add_filter "/test/"
end

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

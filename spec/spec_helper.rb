if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

if ENV['COVERAGE'] == "true"
  require "simplecov"
  SimpleCov.start
end

require 'boardgamegeek'
require 'rspec'
require 'rspec-its'
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include WebMock::API
end

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_hosts 'codeclimate.com'
end

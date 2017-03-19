require 'byebug'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: false)

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'ImmobilienScout'
ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'

Bundler.require

require "rack/test"
require "mail"

ENV["FROM"] = ENV["EMAILS"] = "abc@example.com"

Mail.defaults do
  delivery_method :test
end

require "./notify_app"

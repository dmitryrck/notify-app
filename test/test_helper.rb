ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'

Bundler.require

require "minitest"
require "minitest/mock"
require "rack/test"

ENV["FROM"] = ENV["EMAILS"] = "abc@example.com"

$ses = Minitest::Mock.new
def $ses.send_email(message)
  @message = message
end

def $ses.message
  @message
end

def $ses.subject
  message[:message][:subject][:data]
end

def $ses.body
  message[:message][:body][:text][:data]
end

require "./notify_app"

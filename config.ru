require "rubygems"
require "bundler/setup"

Bundler.require

$ses = AWS::SES::Base.new(
  access_key_id: ENV["AMAZON_ACCESS_KEY_ID"],
  secret_access_key: ENV["AMAZON_SECRET_ACCESS_KEY"],
)

require "./notify_app"
run NotifyApp

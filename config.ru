require "rubygems"
require "bundler/setup"

Bundler.require

$ses = if ENV["AMAZON_ACCESS_KEY_ID"].nil? || ENV["AMAZON_SECRET_ACCESS_KEY"].nil?
         nil
       else
         AWS::SES::Base.new(
           access_key_id: ENV["AMAZON_ACCESS_KEY_ID"],
           secret_access_key: ENV["AMAZON_SECRET_ACCESS_KEY"],
         )
       end

require "./notify_app"
run NotifyApp

require "rubygems"
require "bundler/setup"

Bundler.require

$ses = if ENV["AMAZON_ACCESS_KEY_ID"].nil? || ENV["AMAZON_SECRET_ACCESS_KEY"].nil?
         nil
       else
         Aws::SES::Client.new(
           region: ENV.fetch("AMAZON_REGION") { "us-east-1" },
           credentials: Aws::Credentials.new(ENV["AMAZON_ACCESS_KEY_ID"], ENV["AMAZON_SECRET_ACCESS_KEY"]),
         )
       end

require "./notify_app"
run NotifyApp

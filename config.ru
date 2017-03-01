require "rubygems"
require "bundler/setup"

Bundler.require

Mail.defaults do
  delivery_method :smtp, {
    address: ENV["POSTMARK_SMTP_SERVER"],
    port: "25", # or 2525
    domain: ENV["DOMAIN"],
    user_name: ENV["POSTMARK_API_TOKEN"],
    password: ENV["POSTMARK_API_TOKEN"],
    authentication: :cram_md5, # or :plain for plain-text authentication
    enable_starttls_auto: true, # or false for unencrypted connection
  }
end

require "./notify_app"
run NotifyApp

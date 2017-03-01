require "rubygems"
require "bundler/setup"

Bundler.require

Mail.defaults do
  delivery_method :smtp, {
    address: ENV["POSTMARK_SMTP_SERVER"],
    port: "25", # or 2525
    domain: "stormy-reaches-56145.herokuapp.com",
    user_name: ENV["POSTMARK_API_TOKEN"],
    password: ENV["POSTMARK_API_TOKEN"],
    authentication: :cram_md5, # or :plain for plain-text authentication
    enable_starttls_auto: true, # or false for unencrypted connection
  }
end

run NotifyApp

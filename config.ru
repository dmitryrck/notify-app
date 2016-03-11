require 'rubygems'
require 'bundler/setup'

Bundler.require

Mail.defaults do
  delivery_method :smtp, {
    :address => ENV['POSTMARK_SMTP_SERVER'],
    :port => '25', # or 2525
    :domain => 'stormy-reaches-56145.herokuapp.com',
    :user_name => ENV['POSTMARK_API_TOKEN'],
    :password => ENV['POSTMARK_API_TOKEN'],
    :authentication => :cram_md5, # or :plain for plain-text authentication
    :enable_starttls_auto => true, # or false for unencrypted connection
  }
end

class Notify < Sinatra::Base
  get    '*' do 'Hi.' end
  post   '*' do 'Hi.' end
  put    '*' do 'Hi.' end
  patch  '*' do 'Hi.' end
  delete '*' do 'Hi.' end

  after do
    body = "# Params: \n"
    params.each do |key, value|
      body += "* #{key} => #{value}\n"
    end

    body += "# Aditional info (From env): \n"
    env.each do |key, value|
      body += "* #{key} => #{value}\n"
    end

    message = Mail.new

    message['from']            = ENV['FROM']
    message['to']              = ENV['EMAILS']
    message['subject']         = '[NotifyApp]'
    message['body']            = body
    message['delivery_method'] = :smtp

    message.deliver
  end
end

run Notify

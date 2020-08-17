class NotifyApp < Sinatra::Base
  helpers do
    def delivery(params: {}, env: {})
      body = "# Params: \n"
      params.each do |key, value|
        body += "* #{key} => #{value}\n"
      end

      body += "# Aditional info (From env): \n"
      env.each do |key, value|
        body += "* #{key} => #{value}\n"
      end

      body += "# request body: \n"
      request.body.each do |request_body|
        body += request_body
      end

      message = Mail.new

      message['from']            = ENV['FROM']
      message['to']              = ENV['EMAILS']
      message['subject']         = params.fetch("subject", "[NotifyApp]")
      message['body']            = body
      message['delivery_method'] = :smtp

      if $ses
        $ses.send_raw_email(message)
      else
        puts body
      end
    end
  end

  get '/robots.txt' do
    %[User-agent: *
Disallow: /]
  end

  get    '*' do 'Ok' end
  post   '*' do 'Ok' end
  put    '*' do 'Ok' end
  patch  '*' do 'Ok' end
  delete '*' do 'Ok' end

  after do
    unless ["/robots.txt", "/favicon.ico"].include?(env["PATH_INFO"])
      delivery(params: params, env: env)
    end
  end
end

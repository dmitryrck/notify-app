class NotifyApp < Sinatra::Base
  DEFAULT_OUTPUT = '{"ok":true}'

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

      message = {
        destination: { to_addresses: ENV["EMAILS"].split(",") },
        message: {
          body: { text: { charset: "UTF-8", data: body } },
          subject: { charset: "UTF-8", data: params.fetch("subject", "[NotifyApp]") },
        },
        source: ENV["FROM"],
      }

      if $ses
        $ses.send_email(message)
      else
        puts body
      end
    end
  end

  get '/robots.txt' do
    %[User-agent: *
Disallow: /]
  end

  get    '*' do DEFAULT_OUTPUT end
  post   '*' do DEFAULT_OUTPUT end
  put    '*' do DEFAULT_OUTPUT end
  patch  '*' do DEFAULT_OUTPUT end
  delete '*' do DEFAULT_OUTPUT end

  after do
    unless ["/robots.txt", "/favicon.ico"].include?(env["PATH_INFO"])
      delivery(params: params, env: env)
    end
  end
end

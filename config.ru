class App
  def self.call(env)
    [
      200,
      {
        'Content-Type' => 'text/plain'
      },
      [ 'Hi.' ]
    ]
  end
end

run App

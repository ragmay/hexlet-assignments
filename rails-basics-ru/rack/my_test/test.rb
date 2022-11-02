require 'rack'
require 'byebug'

class Router
  def call(env)
    status, headers, body = @app.call(env)
    signature = Digest::SHA256.hexdigest(body.to_s)
    [status, headers, "#{body}\n#{signature}"]
  end
end

Rack::Handler::Thin.run Router.new

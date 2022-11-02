# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    start = Time.now
    status, headers, body = @app.call(env)
    stop = Time.now
    puts "Response Time: #{(stop.usec - start.usec).to_f / 1000}"
    [status, headers, body]
    # END
  end
end

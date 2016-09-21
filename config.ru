require "rack/timeout"
use Rack::Timeout           # Call as early as possible so rack-timeout runs before other middleware.
Rack::Timeout.timeout = 60  # This line is optional. If omitted, timeout defaults to 15 seconds.

Dir.glob('./{config,services,controllers,lib,models}/init.rb').each do |file|
  require file
end
run KeywordCloudAPI

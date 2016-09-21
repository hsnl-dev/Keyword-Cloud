require "rack-timeout"

# Call as early as possible so rack-timeout runs before all other middleware.
# Setting service_timeout is recommended. If omitted, defaults to 15 seconds.
use Rack::Timeout, service_timeout: 100

Dir.glob('./{config,services,controllers,lib,models}/init.rb').each do |file|
  require file
end
run KeywordCloudAPI

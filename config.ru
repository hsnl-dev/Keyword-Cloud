Dir.glob('./{config,services,controllers,lib}/init.rb').each do |file|
  require file
end
run KeywordCloudAPI

require 'sinatra'
require 'json'

# Configuration Sharing Web Service
class KeywordCloudAPI < Sinatra::Base

  def authenticated_account(env)
    scheme, auth_token = env['HTTP_AUTHORIZATION'].split(' ')
    account_payload = JSON.load JWE.decrypt(auth_token)
    (scheme =~ /^Bearer$/i) ? account_payload : nil
  end

  def authorized_account?(env, uid)
    userid = authenticated_account(env)
    userid == uid
  rescue
    false
  end

  get '/?' do
    'KeywordCloud web service is up and running at /api/v1'
  end
end

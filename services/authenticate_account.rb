require 'http'
require 'base64'
require 'digest/md5'

# Find account and check password
class AuthenticateAccount
  def self.call(account:, password:)
    return nil unless account && password
    account = Base64.strict_encode64(account)
    response = HTTP.get("#{ENV['PROXY_API']}/app/account/#{account}")
    encrypt = Digest::MD5.hexdigest(password)
    record = response.parse
    if record['password'].eql? encrypt
      [record['id'], JWE.encrypt(record['id'].to_s)]
    else
      nil
    end
  end
end

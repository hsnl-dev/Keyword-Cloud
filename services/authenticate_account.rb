require 'mysql2'
require 'digest/md5'

# Find account and check password
class AuthenticateAccount
  def self.call(account:, password:)
    return nil unless account && password

    db = Mysql2::Client.new(host: ENV['HOSTNAME'], username: ENV['USERNAME'],
                            password: ENV['PASSWORD'], database: ENV['DATABASE'])
    sql = "SELECT id,password FROM usr_account WHERE email = '#{account}' AND deleted = 0"
    result = db.query(sql)
    record = result.first
    encrypt = Digest::MD5.hexdigest(password)
    if record['password'].eql? encrypt
      [record['id'], JWE.encrypt(record['id'].to_s)]
    else
      nil
    end
  end
end

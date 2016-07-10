require 'json'
require 'base64'
require 'sequel'

# Holds a full file file's information
class Concept < Sequel::Model
  plugin :timestamps, update_on_create: true

  one_to_one :owner, class: :Course

  def document=(doc_plaintext)
    self.document_encrypted = SecureDB.encrypt(doc_plaintext) if doc_plaintext
  end

  def document
    SecureDB.decrypt(document_encrypted)
  end

  def to_json(options = {})
    doc = document ? Base64.strict_encode64(document) : nil
    JSON({  type: 'concepts',
            id: id,
            data: {
              checksum: checksum,
              document_base64: doc,
              document: document
            }
          },
         options)
  end
end

require 'json'
require 'base64'
require 'sequel'

# Holds a full file file's information
class Slide < Sequel::Model
  plugin :uuid, field: :id

  plugin :timestamps, update_on_create: true

  many_to_one :slide_folders

  def document=(doc_plaintext)
    self.document_encrypted = SecureDB.encrypt(doc_plaintext) if doc_plaintext
  end

  def document
    SecureDB.decrypt(document_encrypted)
  end

  def to_json(options = {})
    doc = document ? Base64.strict_encode64(document) : nil
    JSON({  type: 'slides',
            id: id,
            data: {
              slide_folders_id: slide_folders_id,
              filename: filename,
              checksum: checksum,
              document_base64: doc,
              document: document
            }
          },
         options)
  end
end

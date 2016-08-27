require 'base64'

class FindFileContent
  def self.call(id:, folder_id:)
    doc = SimpleFile.where(id: id, folder_id: folder_id)
                    .first
                    .document
    plain = Base64.strict_decode64(doc)
    decoded = plain.force_encoding('UTF-8')
    exec(`python script.py #{decoded}`)
  end
end

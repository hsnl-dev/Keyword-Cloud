require 'base64'

class SlideSegment
  def self.call(id:, folder_id:)
    doc = SimpleFile.where(id: id, folder_id: folder_id)
                    .first
                    .document
    plain = Base64.strict_decode64(doc)
    decoded = plain.force_encoding('UTF-8')
    string = `python3 helpers/segment.py '#{decoded}'`
    string.split("\n")
  end
end

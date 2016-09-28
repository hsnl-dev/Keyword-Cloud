require 'base64'

class SubtitleSegment
  def self.call(folder_id:, slide:)
    doc = SimpleFile.where(folder_id: folder_id)
                    .all
    fileInfo = doc.map do |s|
      plain = Base64.strict_decode64(s.document)
      decoded = plain.force_encoding('UTF-8')
      `python3 helpers/subtitle_segment.py "#{decoded}" "#{slide}"`
    end
    puts fileInfo
    fileInfo
  end
end

require 'mysql2'

class FindCourseVideo
  def self.call(course_id:, chapter_id:, folder_id:)
    response = HTTP.get("#{ENV['PROXY_API']}/app/url/#{course_id}/#{chapter_id}")
    result = response.parse['data']
    result.each do |urlInfo|
      if Videourl.where(course_id: course_id, chapter_id: chapter_id, video_id: urlInfo['vid']).first != nil
        puts urlInfo['content_order'].class
        videourl = Videourl.where(course_id: course_id, chapter_id: chapter_id, video_id: urlInfo['vid']).first
      else
        videourl = Videourl.new()
        videourl.course_id = course_id.to_i
        videourl.chapter_id = chapter_id.to_i
        videourl.chapter_order = urlInfo['chapter_order']
        videourl.video_id = urlInfo['vid']
        videourl.video_order = urlInfo['content_order']
        videourl.name = urlInfo['name']
        videourl.video_url = urlInfo['urls']
        videourl.save
      end
    end
    Videourl.where(course_id: course_id, chapter_id: chapter_id).all
  end
end

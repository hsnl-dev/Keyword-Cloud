require 'mysql2'

class FindCourseVideo
  def self.call(course_id:, chapter_id:, folder_id:)
    response = HTTP.get("#{ENV['PROXY_API']}/app/url/#{course_id}/#{chapter_id}")
    result = response.parse['data']
    result.each do |urlInfo|
      if Videourl.where(course_id: course_id, chapter_id: chapter_id, video_id: urlInfo['vid']).first != nil
        videourl = Videourl.where(course_id: course_id, chapter_id: chapter_id, video_id: urlInfo['vid']).first
      else
        videourl = Videourl.new()
        course = Course.where(course_id: course_id).first
        videourl.chapter_id = chapter_id
        videourl.chapter_order = urlInfo['chapter_order']
        videourl.video_id = urlInfo['vid']
        videourl.video_order = urlInfo['content_order']
        videourl.name = urlInfo['name']
        videourl.video_url = urlInfo['urls']
        course.add_course_videourl(videourl)
      end
    end
    course_id = Course.where(course_id: course_id).first.id
    Videourl.where(course_id: course_id, chapter_id: chapter_id).all
  end
end

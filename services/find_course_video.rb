require 'mysql2'

class FindCourseVideo
  def self.call(course_id:, chapter_id:, folder_id:)
    db = Mysql2::Client.new(host: ENV['HOSTNAME'], username: ENV['USERNAME'],
                            password: ENV['PASSWORD'], database: ENV['DATABASE'])
    sql = "SELECT chapter_order, content_order, vid, name, urls FROM v_chapter_video WHERE cid = #{course_id} AND chid = #{chapter_id}"
    result = db.query(sql)
    result.each do |chapter|
      if Videourl.where(course_id: course_id, chapter_id: chapter_id, video_id: chapter['vid']).first != nil
        videourl = Videourl.where(course_id: course_id, chapter_id: chapter_id, video_id: chapter['vid']).first
      else
        videourl = Videourl.new()
        course = Course[course_id]
        videourl.chapter_id = chapter_id
        videourl.chapter_order = chapter['chapter_order']
        videourl.video_id = chapter['vid']
        videourl.video_order = chapter['content_order']
        videourl.name = chapter['name']
        videourl.video_url = chapter['urls']
        course.add_course_videourl(videourl)
      end
    end
    Videourl.where(course_id: course_id, chapter_id: chapter_id).all
  end
end

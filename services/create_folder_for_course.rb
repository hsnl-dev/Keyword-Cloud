require 'mysql2'

# Create new folder for slide
class CreateFolderForCourse
  def self.call(course_id:, folder_type:, folder_url: nil)
    return nil unless course_id
    db = Mysql2::Client.new(host: ENV['HOSTNAME'], username: ENV['USERNAME'],
                            password: ENV['PASSWORD'], database: ENV['DATABASE'])
    sql = "SELECT name,chapter_order FROM chapter WHERE cid = #{course_id} AND deleted = 0"
    result = db.query(sql)
    result.each do |chapterInfo|
      if Folder.where(chapter_order: chapterInfo['chapter_order'], name: chapterInfo['name'], folder_type: folder_type).first != nil
        folder = Folder.where(course_id: course_id, chapter_order: chapterInfo['chapter_order']).first
      else
        folder = Folder.new()
        course = Course[course_id]
        folder.chapter_order = chapterInfo['chapter_order']
        folder.name = chapterInfo['name']
        folder.folder_type = folder_type
        folder.folder_url = folder_url if folder_url
        course.add_course_folder(folder)
      end
    end
    Folder.where(course_id: course_id, folder_type: folder_type).all
  end
end

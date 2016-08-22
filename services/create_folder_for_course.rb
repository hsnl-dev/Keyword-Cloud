require 'mysql2'

# Create new folder for slide
class CreateFolderForCourse
  def self.call(course_id:, folder_type:, folder_url: nil)
    return nil unless course_id
    response = HTTP.get("#{ENV['PROXY_API']}/app/chapter/#{course_id}")
    result = response.parse['data']
    result.each do |chapterInfo|
      if Folder.where(chapter_id: chapterInfo['id'], chapter_order: chapterInfo['chapter_order'], name: chapterInfo['name'], folder_type: folder_type).first != nil
        folder = Folder.where(course_id: course_id, chapter_id: chapterInfo['chapter_id']).first
      else
        folder = Folder.new()
        # folder.course_id = course_id.to_i
        course = Course[course_id]
        folder.chapter_order = chapterInfo['chapter_order']
        folder.chapter_id = chapterInfo['id']
        folder.name = chapterInfo['name']
        folder.folder_type = folder_type
        folder.folder_url = folder_url if folder_url
        # folder.save
        course.add_course_folder(folder)
      end
    end
    Folder.where(course_id: course_id, folder_type: folder_type).all
  end
end

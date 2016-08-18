require 'http'

class FindCourseAuth
  def self.call(uid:)
    return nil unless uid
    response = HTTP.get("#{ENV['PROXY_API']}/app/course/#{uid}")
    result = response.parse['data']
    result.each do |courseInfo|
      if Course.where(course_id: courseInfo['cid']).first != nil
        Course.where(course_id: courseInfo['cid']).first
      else
        course = Course.new()
        course.course_id = courseInfo['cid']
        course.course_name = courseInfo['name']
        course.save
      end
    end
  end
end

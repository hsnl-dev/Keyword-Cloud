require 'mysql2'

class FindCourseAuth
  def self.call(uid:)
    return nil unless uid
    db = Mysql2::Client.new(host: ENV['HOSTNAME'], username: ENV['USERNAME'],
                            password: ENV['PASSWORD'], database: ENV['DATABASE'])
    sql = "SELECT cid FROM authority WHERE uid = #{uid} AND deleted = 0"
    result = db.query(sql)
    courseInfo = []
    result.each do |cid|
      if Course[cid['cid']] != nil
        course_result = {}
        course_result['name'] = Course.where(id: cid['cid']).first.course_name
        courseInfo.push(cid.merge(course_result))
      else
        get_courseInfo = "SELECT name FROM course WHERE id = #{cid['cid']} AND deleted = 0"
        course_result = db.query(get_courseInfo)
        courseInfo.push(cid.merge(course_result.first))
        course = Course.new()
        course.id = cid['cid']
        course.course_name = course_result.first['name']
        course.save
      end
    end
  end
end

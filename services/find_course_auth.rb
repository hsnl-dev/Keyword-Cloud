require 'mysql2'

class FindCourseAuth
  def self.call(uid:)
    db = Mysql2::Client.new(host: ENV['HOSTNAME'], username: ENV['USERNAME'],
                            password: ENV['PASSWORD'], database: ENV['DATABASE'])
    sql = "SELECT cid FROM authority WHERE uid = #{uid} AND deleted = 0"
    result = db.query(sql)
    courseInfo = []
    result.each do |cid|
      get_courseInfo = "SELECT name FROM course WHERE id = #{cid['cid']}"
      course_result = db.query(get_courseInfo)
      courseInfo.push(cid.merge(course_result.first))
    end
    courseInfo
  end
end

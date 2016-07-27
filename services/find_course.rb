class FindCourse
  def self.call(course_id:)
    return nil unless course_id
    Course.where(id: course_id).first.course_name
  end
end
